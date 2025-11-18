import 'package:doshi/components/my_piechart.dart';
import 'package:doshi/components/my_total_piechart.dart';
import 'package:doshi/components/mybox.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

List<Widget> analysisPageOnboarding(
  List<Entry> listOfExpenses,
  double spaceFromTop,
  BuildContext context,
  double width,
  double height,
  WidgetRef ref,
  EntryDatabaseNotifier entriesDatabaseNotifier,
  String curency,
  String totalDailyAverage,
  String totalExpenses
) {
  return [
     SliverToBoxAdapter(
      child: SizedBox(
        height: 70 + spaceFromTop,
      ),
    ),
    Consumer(builder: (context, ref, child) {
      final dateToDisp = ref.watch(dateToDisplay);
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(right: 21, left: 21, bottom: 10),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 2,
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
                        DateFormat('MMMMyyyy').format(dateToDisp) ==
                                DateFormat('MMMMyyyy').format(DateTime.now())
                            ? 'This Month'
                            : DateFormat('MMMM, yyyy').format(dateToDisp),
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.primary,
                            decorationThickness: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed,
                            decorationColor:
                                Theme.of(context).colorScheme.primary),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Theme.of(context).colorScheme.onTertiary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).colorScheme.onTertiary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
              MyPieChart(
                isDialogBox: false,
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
                      'All Expenses',
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Consumer(builder: (context, ref, child) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 0, right: 21, left: 21,),
          child: Column(
            children: [
              Padding(
              padding: const EdgeInsets.only(bottom: 12.0,top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Total',
                          amount:
                              "$curency$totalExpenses")),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Daily Average',
                          amount:  curency+totalDailyAverage))
                ],
              ),
            ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Theme.of(context).colorScheme.onTertiary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: MyTotalPieChart(
                    includeUncat: true,
                    useSubCat: false,
                    width: width,
                  )),
                ],
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).colorScheme.onTertiary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
              MyTotalPieChart(
                isDialogBox: false,
                includeUncat: false,
                width: width,
                useSubCat: true,
              )
            ],
          ),
        ),
      );
    }),
    const SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
      ),
    ),
  ];
}
