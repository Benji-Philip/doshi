import 'package:doshi/components/bar_graph_weekly.dart';
import 'package:doshi/components/my_piechart.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

List<Widget> analysisPage(
  List<Entry> listOfExpenses,
  double spaceFromTop,
  BuildContext context,
  double width,
  double height,
  WidgetRef ref,
  EntryDatabaseNotifier entriesDatabaseNotifier,
) {
  bool headers = true;
  if (ref.read(analysisOfCatExpenses).isNotEmpty) {
    return [
      Consumer(builder: (context, ref, child) {
        final dateToDisp = ref.watch(dateToDisplay);
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
                top: 70 + spaceFromTop, right: 21, left: 21, bottom: 10),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () async {
                      HapticFeedback.lightImpact();
                      late DateTime date = DateTime.now();
                      await showMonthPicker(
                        monthPickerDialogSettings: MonthPickerDialogSettings(
                            headerSettings: PickerHeaderSettings(
                                headerBackgroundColor:
                                    Theme.of(context).colorScheme.surface),
                            dialogSettings: PickerDialogSettings(
                                dialogRoundedCornersRadius: 20,
                                dialogBackgroundColor:
                                    Theme.of(context).colorScheme.surface)),
                        context: context,
                        initialDate: DateTime.now(),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          date = selectedDate;
                          ref
                              .read(dateToDisplay.notifier)
                              .update((state) => date);
                        } else {
                          date = DateTime.now();
                        }
                      });
                      List<Entry> entrysInGivenMonth =
                          sortExpensesByGivenMonth(listOfExpenses, date);
                      ref.read(analysisOfCatExpenses.notifier).update((state) =>
                          [...sortIntoCategories(entrysInGivenMonth)]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            DateFormat('MMMMyyyy').format(dateToDisp) ==
                                    DateFormat('MMMMyyyy')
                                        .format(DateTime.now())
                                ? 'This Month'
                                : DateFormat('MMMM, yyyy').format(dateToDisp),
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context).colorScheme.primary,
                                decorationThickness: 2,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted,
                                decorationColor:
                                    Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      Consumer(builder: (context, ref, child) {
        // ignore: unused_local_variable
        final dateToDisp = ref.watch(dateToDisplay);
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 9, right: 21, left: 21),
            child: Column(
              children: [
                Visibility(
                  visible: headers,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Theme.of(context).colorScheme.onTertiary),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Categories",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                ), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: MyPieChart(
                          includeUncat: true,
                      useSubCat: false,
                      width: width,
                    )),
                  ],
                ),
                Visibility(
                  visible: headers,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Theme.of(context).colorScheme.onTertiary),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Subcategories",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                ),
                MyPieChart(
                  includeUncat: false,
                  width: width,
                  useSubCat: true,
                )
              ],
            ),
          ),
        );
      }),
      SliverToBoxAdapter(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 16.0, right: 21, left: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'This Week',
                        style: GoogleFonts.montserrat(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.only(
                right: 21.0, left: 21, top: 21, bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: width,
                height: 150,
                child: BarGraph(
                  linearGradColor1: Theme.of(context).colorScheme.primary,
                  linearGradColor2: Theme.of(context).colorScheme.primary,
                  mon: entriesDatabaseNotifier.monday,
                  tue: entriesDatabaseNotifier.tuesday,
                  wed: entriesDatabaseNotifier.wednesday,
                  thur: entriesDatabaseNotifier.thursday,
                  fri: entriesDatabaseNotifier.friday,
                  sat: entriesDatabaseNotifier.saturday,
                  sun: entriesDatabaseNotifier.sunday,
                  avg: entriesDatabaseNotifier.sumOfthisWeeksExpenses / 7,
                  context: context,
                ),
              ),
            )),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 15,
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
        ),
      ),
    ];
  } else {
    return [
      Consumer(builder: (context, ref, child) {
        final dateToDisp = ref.watch(dateToDisplay);
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
                top: 70 + spaceFromTop, right: 21, left: 21, bottom: 10),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () async {
                      final List<CategoryAnalysisEntry> tempCatList = [];
                      HapticFeedback.lightImpact();
                      late DateTime? date;
                      await showMonthPicker(
                        monthPickerDialogSettings: MonthPickerDialogSettings(
                            headerSettings: PickerHeaderSettings(
                                headerBackgroundColor:
                                    Theme.of(context).colorScheme.surface),
                            dialogSettings: PickerDialogSettings(
                                dialogRoundedCornersRadius: 20,
                                dialogBackgroundColor:
                                    Theme.of(context).colorScheme.surface)),
                        context: context,
                        initialDate: DateTime.now(),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          date = selectedDate;
                        } else {
                          date = DateTime.now();
                        }
                      });
                      ref.read(dateToDisplay.notifier).state =
                          date ?? DateTime.now();
                      tempCatList.addAll(sortIntoCategories(
                          sortExpensesByGivenMonth(
                              entriesDatabaseNotifier.theListOfTheExpenses,
                              date ?? DateTime.now())));
                      ref
                          .read(analysisOfCatExpenses.notifier)
                          .update((state) => tempCatList);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            DateFormat('MMMMyyyy').format(dateToDisp) ==
                                    DateFormat('MMMMyyyy')
                                        .format(DateTime.now())
                                ? 'This Month'
                                : DateFormat('MMMM, yyyy').format(dateToDisp),
                            style: GoogleFonts.montserrat(
                                decorationThickness: 2,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted,
                                decorationColor:
                                    Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(
              top: 0 + spaceFromTop, right: 21, left: 21, bottom: 10),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '( Nothing added )',
                        style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onTertiary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 0 + spaceFromTop, right: 21, left: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'This Week',
                        style: GoogleFonts.montserrat(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.only(
                right: 21.0, left: 21, top: 21, bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: width,
                height: 150,
                child: BarGraph(
                  linearGradColor1: Theme.of(context).colorScheme.primary,
                  linearGradColor2: Theme.of(context).colorScheme.primary,
                  mon: entriesDatabaseNotifier.monday,
                  tue: entriesDatabaseNotifier.tuesday,
                  wed: entriesDatabaseNotifier.wednesday,
                  thur: entriesDatabaseNotifier.thursday,
                  fri: entriesDatabaseNotifier.friday,
                  sat: entriesDatabaseNotifier.saturday,
                  sun: entriesDatabaseNotifier.sunday,
                  avg: entriesDatabaseNotifier.sumOfthisWeeksExpenses / 7,
                  context: context,
                ),
              ),
            )),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
        ),
      ),
    ];
  }
}
