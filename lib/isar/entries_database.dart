import 'dart:io' as io;
import 'package:doshi/isar/app_settings.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/math_of_entries.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/main.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class EntryDatabaseNotifier extends StateNotifier<List<Entry>> {
  static late Isar isar;

  EntryDatabaseNotifier() : super([]);

  //Initialise
  static Future<void> initialise() async {
    isar = Isar.getInstance()!;
  }

  //list of entries

  final List<Entry> currentEntries = [];

  double monday = 0.0;
  double tuesday = 0.0;
  double wednesday = 0.0;
  double thursday = 0.0;
  double friday = 0.0;
  double saturday = 0.0;
  double sunday = 0.0;

  final List<Entry> currentIncomesAndExpenses = [];
  double amountInVault = 0.0;
  double amountInSavings = 0.0;
  double dailyAverage = 0.0;
  double todaysExpenses = 0.0;
  double sumOfthisWeeksExpenses = 0.0;
  double thisMonthExpenses = 0.0;
  double perDayForecast = 0.0;
  double perWeekForecast = 0.0;
  final List<Entry> theListOfTheExpenses = [];
  final List<Entry> theListOfTheSavings = [];
  final List<Entry> theSortedList = [];
  final List<Entry> theListOfExpensesThisMonth = [];
  final List<CategoryAnalysisEntry> analysisOfCategories = [];
  final List<SubCategoryAnalysisEntry> analysisOfSubCategories = [];
  final List<Entry> thisWeekExpenses = [];
  double totalSumOfExpenditures = 0.0;

  // stuff for yearly insights

  double yearlyDailyAverage = 0.0;
  double yearlyTotalSpending = 0.0;
  double yearlyMonthlyAverage = 0.0;
  final List<CategoryAnalysisEntry> yearlyAnalysisOfCategories = [];
  final List<SubCategoryAnalysisEntry> yearlyAnalysisOfSubCategories = [];

  // stuff for all time insights

  final List<CategoryAnalysisEntry> totalAnalysisOfCategories = [];
  final List<SubCategoryAnalysisEntry> totalAnalysisOfSubCategories = [];

  double totalExpenses = 0.0;
  double totalDailyAverage = 0.0;
  double givenMonthTotalExpenses = 0.0;
  double givenMonthDailyAverage = 0.0;
  //create

  Future<void> addEntry(
    double amountEntry,
    DateTime dateTimeEntry,
    String categoryEntry,
    String noteEntry,
    bool isExpenseEntry,
    int categoryColor,
    bool isSavingsEntry,
    String subCategoryEntry,
    int subCategoryColor,
  ) async {
    //create new entry
    final newEntry = Entry()
      ..amount = amountEntry
      ..dateTime = dateTimeEntry
      ..category = categoryEntry
      ..note = noteEntry
      ..isExpense = isExpenseEntry
      ..categoryColor = categoryColor
      ..isExpense = isExpenseEntry
      ..isSavings = isSavingsEntry
      ..subCategory = subCategoryEntry
      ..subCategoryColor = subCategoryColor;

    //save to database
    await isar.writeTxn(() => isar.entrys.put(newEntry));

    //update from database
    await fetchEntries();
  }

  Future<void> addParsedGPayEntry(
    int transactionID,
    double amountEntry,
    DateTime dateTimeEntry,
    String categoryEntry,
    String noteEntry,
    bool isExpenseEntry,
    int categoryColor,
    bool isSavingsEntry,
    String subCategoryEntry,
    int subCategoryColor,
  ) async {
    //create new entry
    final newEntry = Entry()
      ..id = transactionID
      ..amount = amountEntry
      ..dateTime = dateTimeEntry
      ..category = categoryEntry
      ..note = noteEntry
      ..isExpense = isExpenseEntry
      ..categoryColor = categoryColor
      ..isExpense = isExpenseEntry
      ..isSavings = isSavingsEntry
      ..subCategory = subCategoryEntry
      ..subCategoryColor = subCategoryColor;

    //save to database
    await isar.writeTxn(() => isar.entrys.put(newEntry));

    //update from database
    await fetchEntries();
  }

  //read/fetch & update state
  Future<void> fetchEntries() async {
    List<Entry> fetchedEntries = await isar.entrys.where().findAll();
    currentEntries.clear();
    currentEntries.addAll(fetchedEntries);
    List<Entry> listOfIncomes = sortEntriesByIncome(currentEntries);
    List<Entry> listOfExpenses = sortEntriesByExpense(currentEntries);
    List<Entry> listOfSavings =
        await isar.entrys.where().filter().isSavingsEqualTo(true).findAll();
    currentIncomesAndExpenses.clear();
    currentIncomesAndExpenses.addAll(listOfIncomes);
    currentIncomesAndExpenses.addAll(listOfExpenses);
    List<Entry> sortedList = sortEntriesByDate(currentIncomesAndExpenses);
    theListOfTheSavings.clear();
    theListOfTheSavings.addAll(listOfSavings);
    theListOfTheExpenses.clear();
    theListOfTheExpenses.addAll(listOfExpenses);
    theSortedList.clear();
    theSortedList.addAll(sortedList);
    listOfExpenses = sortEntriesByDate(listOfExpenses);
    theListOfExpensesThisMonth.clear();
    theListOfExpensesThisMonth.addAll(sortExpensesByMonth(listOfExpenses));
    double sumOfExpenses = sumOfEntries(listOfExpenses);
    totalExpenses = sumOfExpenses;
    givenMonthTotalExpenses = sumOfEntries(theListOfExpensesThisMonth);
    double sumOfExpensesThisMonth = sumOfEntries(theListOfExpensesThisMonth);
    double sumOfSavings = sumOfEntries(listOfSavings);
    amountInSavings = sumOfSavings;
    amountInVault = sumOfEntries(listOfIncomes) - sumOfExpenses;
    dailyAverage = double.parse((sumOfExpensesThisMonth /
            numberOfExpensesGroupedByDay(theListOfExpensesThisMonth))
        .toStringAsFixed(2));
    totalDailyAverage = double.parse(
        (totalExpenses / numberOfExpensesGroupedByDay(listOfExpenses))
            .toStringAsFixed(2));
    givenMonthDailyAverage = double.parse((givenMonthTotalExpenses /
            numberOfExpensesGroupedByDay(theListOfExpensesThisMonth))
        .toStringAsFixed(2));
    todaysExpenses = expensesOfToday(theListOfExpensesThisMonth);
    thisWeekExpenses.clear();
    thisWeekExpenses.addAll(listOfExpensesThisWeek(theListOfTheExpenses));
    sumOfthisWeeksExpenses = sumOfEntries(thisWeekExpenses);
    resetThisWeekExpensesByDays();
    sortThisWeekExpensesByDays(thisWeekExpenses);
    thisMonthExpenses = sumOfEntries(theListOfExpensesThisMonth);
    perDayForecast = expenditurePerDay(amountInVault, listOfExpenses);
    perWeekForecast = expenditurePerWeek(amountInVault, listOfExpenses);
    totalSumOfExpenditures = sumOfEntries(theListOfExpensesThisMonth);

    analysisOfCategories.clear();
    analysisOfCategories.addAll(sortIntoCategories(theListOfExpensesThisMonth));
    analysisOfSubCategories.clear();
    analysisOfSubCategories
        .addAll(sortIntoSubCategories(theListOfExpensesThisMonth));
    totalAnalysisOfCategories.clear();
    analysisOfCategories.addAll(sortIntoCategories(theListOfTheExpenses));
    totalAnalysisOfSubCategories.clear();
    analysisOfSubCategories.addAll(sortIntoSubCategories(theListOfTheExpenses));
    state = [...sortedList];
  }

  Future<void> resetThisWeekExpensesByDays() async {
    monday = 0.0;
    tuesday = 0.0;
    wednesday = 0.0;
    thursday = 0.0;
    friday = 0.0;
    saturday = 0.0;
    sunday = 0.0;
  }

  Future<void> sortThisWeekExpensesByDays(
      List<Entry> listOfExpensesThisWeek) async {
    for (var i = 0; i < listOfExpensesThisWeek.length; i++) {
      switch (DateFormat('EEEE').format(listOfExpensesThisWeek[i].dateTime)) {
        case 'Monday':
          monday += listOfExpensesThisWeek[i].amount;
          break;
        case 'Tuesday':
          tuesday += listOfExpensesThisWeek[i].amount;
          break;
        case 'Wednesday':
          wednesday += listOfExpensesThisWeek[i].amount;
          break;
        case 'Thursday':
          thursday += listOfExpensesThisWeek[i].amount;
          break;
        case 'Friday':
          friday += listOfExpensesThisWeek[i].amount;
          break;
        case 'Saturday':
          saturday += listOfExpensesThisWeek[i].amount;
          break;
        case 'Sunday':
          sunday += listOfExpensesThisWeek[i].amount;
          break;
        default:
          0.0;
      }
    }
  }

  //edit
  Future<void> editEntry(
    int id,
    String newCategory,
    double newAmount,
    String newNote,
    DateTime newDateTime,
    bool newIsExpense,
    int newCategoryColor,
    bool newIsSavings,
    String newSubCategory,
    int newSubCategoryColor,
  ) async {
    final existingEntry = await isar.entrys.get(id);
    if (existingEntry != null) {
      existingEntry.amount = newAmount;
      existingEntry.category = newCategory;
      existingEntry.dateTime = newDateTime;
      existingEntry.note = newNote;
      existingEntry.isExpense = newIsExpense;
      existingEntry.categoryColor = newCategoryColor;
      existingEntry.isExpense = newIsExpense;
      existingEntry.subCategory = newSubCategory;
      existingEntry.subCategoryColor = newSubCategoryColor;
      await isar.writeTxn(() => isar.entrys.put(existingEntry));
      await fetchEntries();
    }
  }

  Future<void> tryRestore(WidgetRef ref) async {
    // Get external storage directory
    final dbDir = await getApplicationDocumentsDirectory();
    final directory = await FilePicker.platform.pickFiles();
    if (directory != null) {
      showToast("Restoring");
      final backupFile = io.File(directory.files.first.path!);
      if (!backupFile.path.endsWith(".isar")) {
        showToast("Invalid file type");
        return;
      }
      await isar.close();
      final dbPath = '${dbDir.path}/default.isar';
      await backupFile.copy(dbPath);

      await Initialiser().initialiseDatabses();
      updateAppSettingProviders(ref);
      showToast("Restored successfully");
    } else {
      showToast("Cancelled");
    }
  }

  Future<void> tryBackup() async {
    // Get external storage directory
    final db = await getApplicationDocumentsDirectory();
    showToast("Backing up");
    String fileName = "doshi_backup.isar";
    String path = db.path;
    String filePath = '$path/$fileName';
    final backupFile = io.File(filePath);
    if (await backupFile.exists()) {
      await backupFile.delete();
    }
    await isar.copyToFile(filePath);
    final result = await Share.shareXFiles([XFile(filePath)]);
    if (result.status == ShareResultStatus.success) {
      showToast("Backed up succesfully");
    } else {
      showToast("Failed");
    }
  }

  void showToast(String myText) {
    Fluttertoast.showToast(msg: myText);
  }

  //delete
  Future<void> deleteEntry(int id) async {
    await isar.writeTxn(() => isar.entrys.delete(id));
    await fetchEntries();
  }

  Future<void> breakSavings(WidgetRef ref) async {
    var entriesToDelete =
        await isar.entrys.where().filter().isSavingsEqualTo(true).findAll();
    for (var element in entriesToDelete) {
      await isar.writeTxn(() => isar.entrys.delete(element.id));
    }
    await addEntry(
        ref.read(entryDatabaseProvider.notifier).amountInSavings -
            double.parse(ref.read(amountText)),
        DateTime.now(),
        "Uncategorised",
        "",
        false,
        Colors.white.toARGB32(),
        true,
        "Uncategorised",
        Colors.white.toARGB32());
    await addEntry(
        double.parse(ref.read(amountText)),
        DateTime.now(),
        "Uncategorised",
        "From savings",
        false,
        Colors.white.toARGB32(),
        false,
        "Uncategorised",
        Colors.white.toARGB32());
    await fetchEntries();
  }

  //edit Savings

  Future<void> editSavings(WidgetRef ref) async {
    var entriesToDelete =
        await isar.entrys.where().filter().isSavingsEqualTo(true).findAll();
    for (var element in entriesToDelete) {
      await isar.writeTxn(() => isar.entrys.delete(element.id));
    }
    await addEntry(
        double.parse(ref.read(amountText)),
        DateTime.now(),
        "Uncategorised",
        "",
        false,
        Colors.white.toARGB32(),
        true,
        "Uncategorised",
        Colors.white.toARGB32());
    await fetchEntries();
  }

  void updateWithBudget(listOfEntries) async {
    await isar.writeTxn(() => isar.entrys.clear());
    List<Entry> entryList = [];
    for (var entry in listOfEntries) {
      entryList.add(entry);
    }
    await isar.writeTxn(() => isar.entrys.putAll(entryList));
    fetchEntries();
  }

  void updateAppSettingProviders(WidgetRef ref) async {
    List<AppSettingEntry> appSettings =
        await ref.read(appSettingsDatabaseProvider.notifier).fetchSettings();
    if (appSettings.length > 2) {
      ref
          .read(currencyProvider.notifier)
          .update((state) => appSettings[2].appSettingValue);
    } else {
      ref.read(currencyProvider.notifier).update((state) => "\$");
    }
    if (appSettings.length > 3) {
      ref
          .read(showCamera.notifier)
          .update((state) => appSettings[3].appSettingValue == "true");
    } else {
      ref.read(showCamera.notifier).update((state) => false);
    }
    if (appSettings.length > 4) {
      ref
          .read(budgetName.notifier)
          .update((state) => appSettings[4].appSettingValue);
    } else {
      ref.read(budgetName.notifier).update((state) => "Default");
    }
  }

  void updateGivenMonthTotalAndDailyAverage(date) {
    List<Entry> temp = sortExpensesByGivenMonth(theListOfTheExpenses, date);
    givenMonthTotalExpenses = sumOfEntries(temp);
    givenMonthDailyAverage = double.parse(
        (givenMonthTotalExpenses / numberOfExpensesGroupedByDay(temp))
            .toStringAsFixed(2));
  }
}
