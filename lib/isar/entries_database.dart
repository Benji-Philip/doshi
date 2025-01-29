import 'dart:io' as io;

import 'package:doshi/isar/app_settings_database.dart';
import 'package:doshi/isar/category_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/math_of_entries.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  double totalExpenses = 0.0;
  double totalDailyAverage = 0.0;

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
  final List<Entry> thisWeekExpenses = [];
  double totalSumOfExpenditures = 0.0;

  //create

  Future<void> addEntry(
    double amountEntry,
    DateTime dateTimeEntry,
    String categoryEntry,
    String noteEntry,
    bool isExpenseEntry,
    int categoryColor,
    bool isSavingsEntry,
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
      ..isSavings = isSavingsEntry;

    //save to database
    await isar.writeTxn(() => isar.entrys.put(newEntry));

    //update from database
    fetchEntries();
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
    todaysExpenses = expensesOfToday(theListOfExpensesThisMonth);
    thisWeekExpenses.clear();
    thisWeekExpenses.addAll(listOfExpensesThisWeek(theListOfExpensesThisMonth));
    sumOfthisWeeksExpenses = sumOfEntries(thisWeekExpenses);
    resetThisWeekExpensesByDays();
    sortThisWeekExpensesByDays(thisWeekExpenses);
    thisMonthExpenses = sumOfEntries(theListOfExpensesThisMonth);
    perDayForecast = expenditurePerDay(amountInVault, listOfExpenses);
    perWeekForecast = expenditurePerWeek(amountInVault, listOfExpenses);
    totalSumOfExpenditures = sumOfEntries(theListOfExpensesThisMonth);

    analysisOfCategories.clear();
    analysisOfCategories.addAll(sortIntoCategories(theListOfExpensesThisMonth));
    state = [];
    state = sortedList;
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
      bool newIsSavings) async {
    final existingEntry = await isar.entrys.get(id);
    if (existingEntry != null) {
      existingEntry.amount = newAmount;
      existingEntry.category = newCategory;
      existingEntry.dateTime = newDateTime;
      existingEntry.note = newNote;
      existingEntry.isExpense = newIsExpense;
      existingEntry.categoryColor = newCategoryColor;
      existingEntry.isExpense = newIsExpense;
      await isar.writeTxn(() => isar.entrys.put(existingEntry));
      await fetchEntries();
    }
  }

  Future<void> tryRestore() async {
    // Requesting permissions
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
      status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        // Permission denied, handle accordingly
        return;
      }
    }

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

      await AppSettingsDatabaseNotifier.initialise();
      await EntryDatabaseNotifier.initialise();
      await CategoryDatabaseNotifier.initialise();
      fetchEntries();
      showToast("Restored successfully");
    } else {
      showToast("Cancelled");
    }
  }

  Future<void> tryBackup() async {
    // Requesting permissions
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
      status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        // Permission denied, handle accordingly
        return;
      }
    }

    // Get external storage directory
    final directory = await FilePicker.platform.getDirectoryPath();
    if (directory != null) {
      showToast("Backing up");
      String fileName = "doshi_backup.isar";
      String path = directory;
      int count = 0;
      String filePath = '$path/$fileName';
      while (await io.File(filePath).exists()) {
        count++;
        filePath = '$path/${fileName.replaceAll('.isar', '_$count.isar')}';
      }
      await isar.copyToFile(filePath);

      showToast("Backed up successfully!");
    } else {
      showToast("Cancelled");
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
        Colors.white.value,
        true);
    await addEntry(double.parse(ref.read(amountText)), DateTime.now(),
        "Uncategorised", "", false, Colors.white.value, false);
    await fetchEntries();
  }
}
