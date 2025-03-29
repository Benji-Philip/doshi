import 'package:doshi/isar/budget.dart';
import 'package:doshi/onboarding/home_page_onboarding.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BudgetFix {
  void fixAppSetting(WidgetRef ref) {
    String selectedBudget = ref
        .read(appSettingsDatabaseProvider.notifier)
        .currentSettings[4]
        .appSettingValue
        .toString();
    List<Budget> budgets =
        ref.read(budgetDatabaseProvider.notifier).currentBudgets;
    List<String> budgetNames = List.generate(budgets.length, (index) {
      return budgets[index].budgetName;
    });
    if (budgetNames.contains(selectedBudget)) {
      return;
    } else {
      ref
          .read(budgetDatabaseProvider.notifier)
          .addBudget(selectedBudget, "[]", ref);
      ref
          .read(appSettingsDatabaseProvider.notifier)
          .editSetting(5, "currentBudgetName", selectedBudget);
      ref.read(budgetName.notifier).update((state) => selectedBudget);
    }
    // if appsetting.toString doesnt exist in the budgets list then add it
    // if appsetting is not a string then convert it to a string first and do the above and if it does just store it as a string
  }
}
