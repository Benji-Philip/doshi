import 'package:doshi/components/bar_graph_weekly.dart';
import 'package:doshi/components/page_budget_selector.dart';
import 'package:doshi/components/mybox.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> thisMonthPageOnboarding(
  double spaceFromTop,
  BuildContext context,
  double width,
  double height,
  double amountInVault,
  WidgetRef ref,
  EntryDatabaseNotifier entriesDatabaseNotifier,
  List<Entry> currentEntries,
  List<CategoryAnalysisEntry> analysisOfExpensesThisMonth,
  ScrollController scrollController,
) {
  List<Widget> homePage = [
    SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: spaceFromTop - 30,
            color: Colors.transparent,
            child: SizedBox(
              width: width * 0.7,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Home",
                  style: GoogleFonts.montserrat(
                      color: Colors.transparent,
                      fontSize: 36,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(top: -20.0 + spaceFromTop, right: 21, left: 21),
        child: Column(
          children: [
            const IgnorePointer(
              ignoring: true,
              child: Padding(
                padding: EdgeInsets.only(top:18.0),
                child: ScrollableBudgetSelector(),
              )),
            Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: ref.watch(showCamera) ? 12.0 : 0.0),
                        child: Container(
                          height: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              border: Border.all(
                                  width: 5,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        amountInVault == 0.0
                                            ? "${ref.watch(currencyProvider)}0.0"
                                            : ref.watch(currencyProvider) +
                                                amountInVault
                                                    .toStringAsFixed(2),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 38,
                                            fontWeight: FontWeight.w700,
                                            color: amountInVault > 0.0
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: SizedBox(
                                          height: 20,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              amountInVault >= 0.0
                                                  ? "- left in credit -"
                                                  : "- left in debt -",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 21,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'This Month',
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MyBox(
                          borderColor: entriesDatabaseNotifier.todaysExpenses >
                                  entriesDatabaseNotifier.perDayForecast
                              ? Colors.red
                              : Theme.of(context).colorScheme.onTertiary,
                          width: width,
                          label: 'Today',
                          forecastAmount: entriesDatabaseNotifier.perDayForecast
                              .toStringAsFixed(2),
                          amount:
                              "${ref.watch(currencyProvider)}${entriesDatabaseNotifier.todaysExpenses}")),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: MyBox(
                          borderColor:
                              entriesDatabaseNotifier.sumOfthisWeeksExpenses >
                                      entriesDatabaseNotifier.perWeekForecast
                                  ? Colors.red
                                  : Theme.of(context).colorScheme.onTertiary,
                          width: width,
                          label: 'This Week',
                          forecastAmount: entriesDatabaseNotifier
                              .perWeekForecast
                              .toStringAsFixed(2),
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.sumOfthisWeeksExpenses
                                  .toStringAsFixed(2)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Total',
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.thisMonthExpenses
                                  .toStringAsFixed(2))),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Daily Average',
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.dailyAverage
                                  .toStringAsFixed(2)))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
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
    SliverToBoxAdapter(
      child: Padding(
          padding:
              const EdgeInsets.only(right: 21.0, left: 21, top: 21, bottom: 24),
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
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0, left: 0, top: 15),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Savings',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0.0, left: 0, top: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minWidth: width * 0.5),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onTertiary,
                            width: 5),
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ref.watch(currencyProvider) +
                                entriesDatabaseNotifier.amountInSavings
                                    .toStringAsFixed(2),
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: entriesDatabaseNotifier.amountInSavings == 0
                        ? false
                        : true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                        width: width * 0.35,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          border: Border.all(color: Colors.green),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Break!",
                              style: GoogleFonts.montserrat(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    const SliverToBoxAdapter(
        child: SizedBox(
      height: 220,
    ))
  ];
  return homePage;
}
