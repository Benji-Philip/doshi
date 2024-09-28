import 'package:doshi/isar/entry.dart';
import 'package:intl/intl.dart';

List<Entry> sortEntriesByDate(List<Entry> currentEntries) {
  currentEntries.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  return currentEntries;
}

List<Entry> sortEntriesByExpense(List<Entry> currentEntries) {
  List<Entry> listOfExpenses = [];
  for (var i = 0; i < currentEntries.length; i++) {
    if (currentEntries[i].isExpense == true &&
        currentEntries[i].isSavings == false) {
      listOfExpenses.add(currentEntries[i]);
    }
  }
  return listOfExpenses;
}

List<Entry> sortEntriesByIncome(List<Entry> currentEntries) {
  List<Entry> listOfIncomes = [];
  for (var i = 0; i < currentEntries.length; i++) {
    if (currentEntries[i].isExpense == false &&
        currentEntries[i].isSavings == false) {
      listOfIncomes.add(currentEntries[i]);
    }
  }
  return listOfIncomes;
}

List<Entry> sortExpensesByMonth(List<Entry> listOfExpenses) {
  List<Entry> currentEntries = [];
  for (var i = 0; i < listOfExpenses.length; i++) {
    if (DateFormat('MMMMyyyy').format(listOfExpenses[i].dateTime) ==
        DateFormat('MMMMyyyy').format(DateTime.now())) {
      currentEntries.add(listOfExpenses[i]);
    } else {
      break;
    }
  }
  return currentEntries;
}

List<Entry> sortExpensesByGivenMonth(List<Entry> listOfExpenses, DateTime givenMonth) {
  List<Entry> currentEntries = [];
  for (var i = 0; i < listOfExpenses.length; i++) {
    if (DateFormat('MMMMyyyy').format(listOfExpenses[i].dateTime) ==
        DateFormat('MMMMyyyy').format(givenMonth)) {
      currentEntries.add(listOfExpenses[i]);
    }
  }
  return currentEntries;
}

class CategoryAnalysisEntry {
  String? categoryName;
  late int categoryNumber;
  int? categoryColor;
  late double categorySum;
  late String categorySumPercent;
}

List<CategoryAnalysisEntry> sortIntoCategories(List<Entry> expensesThisMonth) {
  double totalSum = 0.0;
  List<CategoryAnalysisEntry> sortedByCategories = [];
  if (expensesThisMonth.isNotEmpty) {
    for (var i = 0; i < expensesThisMonth.length; i++) {
      if (sortedByCategories.isEmpty) {
        sortedByCategories.add(CategoryAnalysisEntry()
          ..categoryName = expensesThisMonth[0].category
          ..categoryNumber = 1
          ..categoryColor = expensesThisMonth[0].categoryColor
          ..categorySum = expensesThisMonth[0].amount);
        totalSum = expensesThisMonth[0].amount;
      } else {
        for (var j = 0; j < sortedByCategories.length + 1; j++) {
          if (j < sortedByCategories.length) {
            if (sortedByCategories[j].categoryName ==
                expensesThisMonth[i].category) {
              sortedByCategories[j].categoryNumber++;
              sortedByCategories[j].categorySum += expensesThisMonth[i].amount;
              totalSum += expensesThisMonth[i].amount;
              break;
            }
          } else if (j == sortedByCategories.length) {
            sortedByCategories.add(CategoryAnalysisEntry()
              ..categoryName = expensesThisMonth[i].category
              ..categoryNumber = 1
              ..categoryColor = expensesThisMonth[i].categoryColor
              ..categorySum = expensesThisMonth[i].amount);
            totalSum += expensesThisMonth[i].amount;
            break;
          }
        }
      }
    }
    for (var i = 0; i < sortedByCategories.length; i++) {
      sortedByCategories[i].categorySumPercent =
          (sortedByCategories[i].categorySum * 100 / totalSum)
              .toStringAsFixed(1);
    }
    sortedByCategories.sort((a, b) => b.categorySum.compareTo(a.categorySum));
    return sortedByCategories;
  }
  return [];
}
