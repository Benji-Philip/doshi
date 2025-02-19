import 'dart:convert';

import 'package:doshi/isar/app_settings.dart';
import 'package:doshi/isar/budget.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class BudgetDatabaseNotifier extends StateNotifier<List<Budget>> {
  static late Isar isar;

  BudgetDatabaseNotifier() : super([]);

  //Initialise
  static Future<void> initialise() async {
    isar = Isar.getInstance()!;
  }

  //list of default categories

  final defaultBudget = Budget()
    ..budgetName = "Default"
    ..entriesListJSON = "[]";

  //list of entries

  final List<Budget> currentBudgets = [];

  final List<AppSettingEntry> currentSettings = [];

  //create

  Future<void> addBudget(
      String newBudgetName, String newEntriesListJSON, WidgetRef ref) async {
    //create new Budget
    final newBudget = Budget()
      ..budgetName = newBudgetName
      ..entriesListJSON = newEntriesListJSON;

    //save to database
    await isar.writeTxn(() => isar.budgets.put(newBudget));
    //update from database
    fetchEntries();
  }

  Future<void> selectBudget(WidgetRef ref, Id id) async {
    Budget? selectedBudget = await isar.budgets.get(id);

    if (selectedBudget != null) {
      String currentBudgetName = ref
          .read(appSettingsDatabaseProvider.notifier)
          .currentSettings[4]
          .appSettingValue;
      Budget? currentBudgetBeingUsed = await isar.budgets
          .filter()
          .budgetNameEqualTo(currentBudgetName)
          .findFirst();
      if (currentBudgetBeingUsed != null) {
        Id currentBudgetId = currentBudgetBeingUsed.id;
        editBudget(
            ref,
            currentBudgetId,
            currentBudgetBeingUsed.budgetName,
            jsonEncode(ref
                .read(entryDatabaseProvider.notifier)
                .currentEntries
                .map((entry) => {
                      'id': entry.id,
                      'category': entry.category,
                      'subCategory': entry.subCategory,
                      'categoryColor': entry.categoryColor,
                      'subCategoryColor': entry.subCategoryColor,
                      'note': entry.note,
                      'amount': entry.amount,
                      'isExpense': entry.isExpense,
                      'isSavings': entry.isSavings,
                      'dateTime': entry.dateTime.toString(),
                    })
                .toList()));
        ref
            .read(appSettingsDatabaseProvider.notifier)
            .editSetting(5, "currentBudgetName", selectedBudget.budgetName);
        ref
            .read(budgetName.notifier)
            .update((state) => selectedBudget.budgetName);
        ref
            .read(entryDatabaseProvider.notifier)
            .updateWithBudget(jsonDecode(selectedBudget.entriesListJSON)
                .map((item) => Entry()
                  ..amount = item['amount']
                  ..category = item['category']
                  ..categoryColor = item['categoryColor']
                  ..dateTime = DateTime.parse(item['dateTime'])
                  ..id = item['id']
                  ..isExpense = item['isExpense']
                  ..isSavings = item['isSavings']
                  ..note = item['note']
                  ..subCategory = item['subCategory']
                  ..subCategoryColor = item['subCategoryColor'])
                .toList());
      }
    }
    await fetchEntries();
  }

  //read/fetch & update state
  Future<void> fetchEntries() async {
    List<Budget> fetchedEntries = await isar.budgets.where().findAll();
    fetchedEntries = fetchedEntries.reversed.toList();
    currentBudgets.clear();
    currentBudgets.addAll(fetchedEntries);
    if (currentBudgets.isEmpty) {
      await isar.writeTxn(() => isar.budgets.put(defaultBudget));
      fetchedEntries = await isar.budgets.where().findAll();
      currentBudgets.clear();
      currentBudgets.addAll(fetchedEntries);
    }
    state = [...currentBudgets];
  }

  //edit
  Future<void> editBudget(WidgetRef ref, int id, String newBudget,
      String newEntriesListJSON) async {
    final existingBudget = await isar.budgets.get(id);
    if (existingBudget != null) {
      existingBudget.budgetName = newBudget;
      existingBudget.entriesListJSON = newEntriesListJSON;
      await isar.writeTxn(() => isar.budgets.put(existingBudget));
      await fetchEntries();
    }
  }

  Future<void> editBudgetName(
      WidgetRef ref, String newBudgetName, String thisBudgetName) async {
    String currentBudgetName = ref
        .read(appSettingsDatabaseProvider.notifier)
        .currentSettings[4]
        .appSettingValue;
    Budget? existingBudget = await isar.budgets
        .filter()
        .budgetNameEqualTo(thisBudgetName)
        .findFirst();
    if (existingBudget != null) {
      existingBudget.budgetName = newBudgetName;
      await isar.writeTxn(() => isar.budgets.put(existingBudget));
      if (thisBudgetName.toLowerCase().trim() ==
          currentBudgetName.toLowerCase().trim()) {
        ref
            .read(appSettingsDatabaseProvider.notifier)
            .editSetting(5, "currentBudgetName", newBudgetName);
        ref.read(budgetName.notifier).update((state) => newBudgetName);
      }
      await fetchEntries();
    }
  }

  //delete
  Future<void> deleteBudget(
      WidgetRef ref, String thisBudgetName, bool isSelected) async {
    Budget? budgetToDelete = await isar.budgets
        .filter()
        .budgetNameEqualTo(thisBudgetName)
        .findFirst();
    if (budgetToDelete != null) {
      await isar.writeTxn(() => isar.budgets.delete(budgetToDelete.id));
      if (isSelected) {
        List<Budget> thisBudgetsList = await isar.budgets.where().findAll();
        if (thisBudgetsList.isNotEmpty) {
          await selectBudgetWhileDeletingCurrent(ref, thisBudgetsList[0].id);
        } else {
          await addBudget("Default", "[]", ref);
          List<Budget> temp = await isar.budgets.where().findAll();
          await selectBudgetWhileDeletingCurrent(ref, temp[0].id);
        }
      }
      await fetchEntries();
    }
  }

  Future<void> selectBudgetWhileDeletingCurrent(WidgetRef ref, Id id) async {
    Budget? selectedBudget = await isar.budgets.get(id);

    if (selectedBudget != null) {
      ref
          .read(appSettingsDatabaseProvider.notifier)
          .editSetting(5, "currentBudgetName", selectedBudget.budgetName);
      ref
          .read(budgetName.notifier)
          .update((state) => selectedBudget.budgetName);
      ref
          .read(entryDatabaseProvider.notifier)
          .updateWithBudget(jsonDecode(selectedBudget.entriesListJSON)
              .map((item) => Entry()
                ..amount = item['amount']
                ..category = item['category']
                ..categoryColor = item['categoryColor']
                ..dateTime = DateTime.parse(item['dateTime'])
                ..id = item['id']
                ..isExpense = item['isExpense']
                ..isSavings = item['isSavings']
                ..note = item['note']
                ..subCategory = item['subCategory']
                ..subCategoryColor = item['subCategoryColor'])
              .toList());
    }
    await fetchEntries();
  }
}
