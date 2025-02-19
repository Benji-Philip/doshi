import 'package:doshi/components/budget_selector.dart';
import 'package:doshi/isar/budget.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class ScrollableBudgetSelector extends ConsumerStatefulWidget {
  const ScrollableBudgetSelector({super.key});

  @override
  ConsumerState<ScrollableBudgetSelector> createState() =>
      _ScrollableBudgetSelectorState();
}

class _ScrollableBudgetSelectorState
    extends ConsumerState<ScrollableBudgetSelector> {
  String? selectedValue;

  List<Budget> items = [];
  Budget addNew = Budget()
    ..budgetName = "Add new"
    ..entriesListJSON = "[]"
    ..id = Id.parse("-100");

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final watcher = ref.watch(budgetDatabaseProvider);

    items = [
      ...ref.watch(budgetDatabaseProvider.notifier).currentBudgets,
      addNew
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              showGeneralDialog(
                  pageBuilder: (context, anim1, anim2) {
                    return const Placeholder();
                  },
                  context: context,
                  transitionBuilder: (context, anim1, anim2, child) {
                    return Opacity(
                        opacity: anim1.value, child: const BudgetSelector());
                  },
                  transitionDuration: const Duration(milliseconds: 200));
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onTertiary, // Solid color background
                borderRadius: BorderRadius.circular(15), // Curved corners
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          ref.watch(budgetName),
                          style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: RotatedBox(
                          quarterTurns: 3,
                          child: Icon(Icons.switch_right_rounded)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
