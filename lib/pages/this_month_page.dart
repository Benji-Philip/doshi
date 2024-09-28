import 'package:doshi/components/backup_restore_dialog.dart';
import 'package:doshi/components/break_savings_dialog.dart';
import 'package:doshi/components/mybox.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/pages/history_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> thisMonthPage(
  double scrollOffset,
  double spaceFromTop,
  BuildContext context,
  double width,
  double height,
  double amountInVault,
  WidgetRef ref,
  EntryDatabaseNotifier entriesDatabaseNotifier,
  List<Entry> currentEntries,
  List<CategoryAnalysisEntry> analysisOfExpensesThisMonth,
) {
  List<Widget> homePage = [
    SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 43.0),
            child: Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Visibility(
                visible: scrollOffset > -10,
                child: GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      showGeneralDialog(
                          pageBuilder: (context, anim1, anim2) {
                            return const Placeholder();
                          },
                          context: context,
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Opacity(
                                opacity: anim1.value,
                                child: BackupRestoreDialog(
                                    entriesDatabaseNotifier:
                                        entriesDatabaseNotifier));
                          },
                          transitionDuration:
                              const Duration(milliseconds: 200));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.save_rounded),
                    )),
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
    ),
    SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(top: -20.0 + spaceFromTop, right: 21, left: 21),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 0),
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
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.7,
                              height: 60,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  amountInVault == 0.0
                                      ? "${ref.watch(currencyProvider)}0.0"
                                      : ref.watch(currencyProvider) +
                                          amountInVault.toString(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w700,
                                      color: amountInVault > 0.0
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.redAccent),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: amountInVault == 0.0 ? true : true,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'This Month',
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Today',
                          forecastAmount: entriesDatabaseNotifier.perDayForecast
                              .toStringAsFixed(1),
                          amount:
                              "${ref.watch(currencyProvider)}${entriesDatabaseNotifier.todaysExpenses}")),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'This Week',
                          forecastAmount: entriesDatabaseNotifier
                              .perWeekForecast
                              .toStringAsFixed(1),
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.sumOfthisWeeksExpenses
                                  .toStringAsFixed(1)))
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
                                  .toStringAsFixed(1))),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Daily Average',
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.dailyAverage
                                  .toStringAsFixed(1)))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          children: [
            Visibility(
              visible:
                  entriesDatabaseNotifier.amountInSavings == 0 ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0, left: 0, top: 15),
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
                        'Savings',
                        style: GoogleFonts.montserrat(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible:
                  entriesDatabaseNotifier.amountInSavings == 0 ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0, left: 0, top: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.5,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
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
                            ref.read(currencyProvider) +
                                entriesDatabaseNotifier.amountInSavings
                                    .toStringAsFixed(1),
                            style: GoogleFonts.montserrat(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setDefaultValues(ref);
                        ref.read(amountText.notifier).update((state) => ref
                            .read(entryDatabaseProvider.notifier)
                            .amountInSavings
                            .toString());
                        showGeneralDialog(
                            pageBuilder: (context, anim1, anim2) {
                              return const Placeholder();
                            },
                            context: context,
                            transitionBuilder: (context, anim1, anim2, child) {
                              return Opacity(
                                  opacity: anim1.value,
                                  child: const BreakSavingsDialog());
                            },
                            transitionDuration:
                                const Duration(milliseconds: 200));
                      },
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
                                  color:
                                      Theme.of(context).colorScheme.surface),
                            ),
                          ),
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
    const SliverToBoxAdapter(
        child: SizedBox(
      height: 150,
    ))
  ];
  homePage.insertAll(3, historyPage(spaceFromTop, width, ref, currentEntries));
  return homePage;
}
