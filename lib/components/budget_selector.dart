import 'package:doshi/components/add_budget_dialogbox.dart';
import 'package:doshi/components/my_button.dart';
import 'package:doshi/components/slidable_budget.dart';
import 'package:doshi/isar/budget.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BudgetSelector extends ConsumerStatefulWidget {
  const BudgetSelector({super.key});

  @override
  ConsumerState<BudgetSelector> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<BudgetSelector> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final nameWatcher = ref.watch(appSettingsDatabaseProvider);
    // ignore: unused_local_variable
    final watcher = ref.watch(budgetName);
    // ignore: unused_local_variable
    final budgetsDP = ref.watch(budgetDatabaseProvider);
    final budgetsDN = ref.watch(budgetDatabaseProvider.notifier);
    List<Budget> currentBudgets = budgetsDN.currentBudgets;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: Theme.of(context).colorScheme.tertiary),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 21.0, vertical: 12),
                  child: Column(children: [
                    ...List.generate(
                      currentBudgets.length,
                      (index) {
                        bool isSelected = ref
                                .read(appSettingsDatabaseProvider.notifier)
                                .currentSettings[4]
                                .appSettingValue ==
                            currentBudgets[index].budgetName;

                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    if (!isSelected) {
                                      ref
                                          .read(budgetDatabaseProvider.notifier)
                                          .selectBudget(
                                              ref, currentBudgets[index].id);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Container(
                                      height: 60,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      clipBehavior: Clip.antiAlias,
                                      child: SlidableBudget(
                                        isSelected: isSelected,
                                        thisBudgetName:
                                            currentBudgets[index].budgetName,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                showGeneralDialog(
                                    pageBuilder: (context, anim1, anim2) {
                                      return const Placeholder();
                                    },
                                    context: context,
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                      return Opacity(
                                          opacity: anim1.value,
                                          child: const AddBudget());
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 200));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                child: Text(
                                  "Add new",
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: MyButton(
                borderRadius: 50,
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pop();
                },
                width: 50,
                height: 50,
                iconSize: 32,
                myIcon: Icons.close_rounded,
                iconColor: Colors.white,
                buttonColor: Colors.redAccent,
                splashColor: Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
