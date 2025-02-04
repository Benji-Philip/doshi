import 'package:doshi/components/bar_graph_weekly.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

List<Widget> analysisPage(
  double spaceFromTop,
  BuildContext context,
  double width,
  double height,
  WidgetRef ref,
  EntryDatabaseNotifier entriesDatabaseNotifier,
) {
  if (ref.read(analysisOfExpenses).isNotEmpty) {
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
                      final List<CategoryAnalysisEntry> tempList = [];
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
                      ref.read(analysisOfExpenses.notifier).state = [];
                      ref.read(analysisOfExpenses.notifier).state = [];
                      tempList.addAll(sortIntoCategories(
                          sortExpensesByGivenMonth(
                              entriesDatabaseNotifier.theListOfTheExpenses,
                              date ?? DateTime.now())));
                      ref.read(analysisOfExpenses.notifier).state = tempList;
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
      Consumer(builder: (context, ref, child) {
        final analysis = ref.watch(analysisOfExpenses);
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 9, right: 21, left: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0, bottom: 15),
                        child: SizedBox(
                          height: width / 2,
                          child: PieChart(
                              swapAnimationDuration:
                                  const Duration(milliseconds: 750),
                              swapAnimationCurve: Curves.easeInOut,
                              PieChartData(
                                  sections:
                                      List.generate(analysis.length, (index) {
                                return PieChartSectionData(
                                    titlePositionPercentageOffset: 1.6,
                                    titleStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                    title:
                                        "${analysis[index].categorySumPercent}%",
                                    value: double.parse(
                                        analysis[index].categorySumPercent),
                                    color: Color(
                                        analysis[index].categoryColor ??
                                            Colors.white.value));
                              }))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 21.0),
                        child: Column(
                          children: List.generate(
                            analysis.length,
                            (index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.heavyImpact();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 55,
                                            width: width * 0.85,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  width: 5),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4,
                                                  right: 21.0,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Container(
                                                            height: 12,
                                                            width: 12,
                                                            decoration: BoxDecoration(
                                                                color: Color(analysis[
                                                                            index]
                                                                        .categoryColor ??
                                                                    Colors.white
                                                                        .value),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            100))),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          8.0),
                                                              child: SizedBox(
                                                                child: Text(
                                                                  analysis[index]
                                                                          .categoryName ??
                                                                      '',
                                                                  softWrap:
                                                                      true,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.montserrat(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(ref.read(currencyProvider) +
                                                                analysis[index]
                                                                    .categorySum
                                                                    .toString(),
                                                        softWrap: true,
                                                        style: GoogleFonts.montserrat(
                                                            color: Color(analysis[
                                                                        index]
                                                                    .categoryColor ??
                                                                Colors.white
                                                                    .value),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                      final List<CategoryAnalysisEntry> tempList = [];
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
                      ref.read(analysisOfExpenses.notifier).state = [];
                      ref.read(analysisOfExpenses.notifier).state = [];
                      tempList.addAll(sortIntoCategories(
                          sortExpensesByGivenMonth(
                              entriesDatabaseNotifier.theListOfTheExpenses,
                              date ?? DateTime.now())));
                      ref.read(analysisOfExpenses.notifier).state = tempList;
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
