import 'package:doshi/isar/entry.dart';
import 'package:doshi/isar/subcategory_entry.dart';
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

List<Entry> sortExpensesByGivenMonth(
    List<Entry> listOfExpenses, DateTime givenMonth) {
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

class SubCategoryAnalysisEntry {
  String? parentCategoryName;
  String? subCategoryName;
  late int subCategoryNumber;
  int? subCategoryColor;
  late double subCategorySum;
  late String subCategorySumPercent;
}

List<CategoryAnalysisEntry> sortIntoCategories(List<Entry> expensesThisMonth) {
  double totalSum = 0.00;
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
              .toStringAsFixed(2);
    }
    sortedByCategories.sort((a, b) => b.categorySum.compareTo(a.categorySum));
    return sortedByCategories;
  }
  return [];
}

List<SubCategoryAnalysisEntry> sortIntoSubCategories(
    List<Entry> expensesThisMonth) {
  double totalSum = 0.00;
  List<SubCategoryAnalysisEntry> sortedBySubCategories = [];
  if (expensesThisMonth.isNotEmpty) {
    for (var i = 0; i < expensesThisMonth.length; i++) {
      if (sortedBySubCategories.isEmpty) {
        sortedBySubCategories.add(SubCategoryAnalysisEntry()
          ..parentCategoryName = expensesThisMonth[0].category
          ..subCategoryName = expensesThisMonth[0].subCategory
          ..subCategoryNumber = 1
          ..subCategoryColor = expensesThisMonth[0].subCategoryColor
          ..subCategorySum = expensesThisMonth[0].amount);
        totalSum = expensesThisMonth[0].amount;
      } else {
        for (var j = 0; j < sortedBySubCategories.length + 1; j++) {
          if (j < sortedBySubCategories.length) {
            if (sortedBySubCategories[j].subCategoryName ==
                expensesThisMonth[i].subCategory) {
              sortedBySubCategories[j].subCategoryNumber++;
              sortedBySubCategories[j].subCategorySum +=
                  expensesThisMonth[i].amount;
              totalSum += expensesThisMonth[i].amount;
              break;
            }
          } else if (j == sortedBySubCategories.length) {
            sortedBySubCategories.add(SubCategoryAnalysisEntry()
              ..parentCategoryName = expensesThisMonth[0].category
              ..subCategoryName = expensesThisMonth[i].subCategory
              ..subCategoryNumber = 1
              ..subCategoryColor = expensesThisMonth[i].subCategoryColor
              ..subCategorySum = expensesThisMonth[i].amount);
            totalSum += expensesThisMonth[i].amount;
            break;
          }
        }
      }
    }
    for (var i = 0; i < sortedBySubCategories.length; i++) {
      sortedBySubCategories[i].subCategorySumPercent =
          (sortedBySubCategories[i].subCategorySum * 100 / totalSum)
              .toStringAsFixed(2);
    }
    sortedBySubCategories
        .sort((a, b) => b.subCategorySum.compareTo(a.subCategorySum));
    return sortedBySubCategories;
  }
  return [];
}

List<SubCategoryEntry> sortSubCategoriesByParent(
    String parentCategory, List<SubCategoryEntry> currentSubCategoryList) {
  List<SubCategoryEntry> filteredSubCategoryList = [];
  for (var subCategory in currentSubCategoryList) {
    if (subCategory.parentCategory == parentCategory) {
      filteredSubCategoryList.add(subCategory);
    }
  }
  return filteredSubCategoryList;
}

List<Entry> sortEntrysByParentCategory(
    String parentCategory, List<Entry> expensesThisMonth) {
  List<Entry> filteredEntrys = [];
  for (var entry in expensesThisMonth) {
    if (entry.category == parentCategory) {
      filteredEntrys.add(entry);
    }
  }
  return filteredEntrys;
}

List<Entry> sortEntrysBySubCategory(
    String subCategory, List<Entry> expensesThisMonth) {
  List<Entry> filteredEntrys = [];
  for (var entry in expensesThisMonth) {
    if (entry.subCategory == subCategory) {
      filteredEntrys.add(entry);
    }
  }
  filteredEntrys = sortEntriesByDate(filteredEntrys);
  return filteredEntrys;
}

List<Entry> sortEntrysByParentCategoryAndSubCategory(
    String parentCategory, List<Entry> expensesThisMonth) {
  List<Entry> filteredEntrys = [];
  for (var entry in expensesThisMonth) {
    if (entry.category == parentCategory &&
        entry.subCategory == "Uncategorised") {
      filteredEntrys.add(entry);
    }
  }
  return filteredEntrys;
}

List<Entry> sortEntrysByParentCategoryAndNullSubCategory(
    String parentCategory, List<Entry> expensesThisMonth) {
  List<Entry> filteredEntrys = [];
  for (var entry in expensesThisMonth) {
    if (entry.category == parentCategory && entry.subCategory == null) {
      filteredEntrys.add(entry);
    }
  }
  return filteredEntrys;
}
