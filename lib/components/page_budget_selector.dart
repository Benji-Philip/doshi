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
    // ignore: unused_local_variable
    final watcher2 = ref.watch(appSettingsDatabaseProvider);

    items = [
      ...ref.watch(budgetDatabaseProvider.notifier).currentBudgets,
      addNew
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              ref.read(budgetDatabaseProvider.notifier).fetchEntries();
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
              height: 45,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
              ),
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onTertiary
                    .withOpacity(0.7), // Solid color background
                borderRadius: BorderRadius.circular(15), // Curved corners
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ref
                            .watch(appSettingsDatabaseProvider.notifier)
                            .currentSettings[4]
                            .appSettingValue,
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12),
                        child: RotatedBox(
                            quarterTurns: 3,
                            child: Icon(Icons.switch_right_rounded)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
