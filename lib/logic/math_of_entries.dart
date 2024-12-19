import 'package:doshi/logic/sort_entries.dart';
import 'package:intl/intl.dart';

import '../isar/entry.dart';

double sumOfEntries(List<Entry> listOfEntries) {
  double sumOfEntries = listOfEntries.fold(
      0, (previousValue, element) => previousValue + element.amount);
  return sumOfEntries;
}

int numberOfExpensesGroupedByDay(List<Entry> listOfExpenses) {
  if (listOfExpenses.isEmpty) {
    return 1;
  } else {
    List<Entry> currentEntries = listOfExpenses;
    sortEntriesByDate(currentEntries);
    Duration difference = currentEntries[listOfExpenses.length - 1]
        .dateTime
        .difference(DateTime.now());
    return -(difference.inDays - 1);
  }
}

double expensesOfToday(List<Entry> listOfExpenses) {
  List<Entry> currentEntries = [];

  for (var i = 0; i < listOfExpenses.length; i++) {
    if (DateFormat('dMMMyyyy').format(listOfExpenses[i].dateTime) ==
        DateFormat('dMMMyyyy').format(DateTime.now())) {
      currentEntries.add(listOfExpenses[i]);
    } else {
      break;
    }
  }

  return sumOfEntries(currentEntries);
}

List<Entry> listOfExpensesThisWeek(List<Entry> listOfExpenses) {
  List<Entry> currentEntries = [];
  for (var i = 0; i < listOfExpenses.length; i++) {
    if (weekNumber(listOfExpenses[i].dateTime) == weekNumber(DateTime.now())) {
      currentEntries.add(listOfExpenses[i]);
    } else {
      break;
    }
  }
  return currentEntries;
}

int numOfWeeks(int year) {
  DateTime dec28 = DateTime(year, 12, 28);
  int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
  return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
}

int weekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
  if (woy < 1) {
    woy = numOfWeeks(date.year - 1);
  } else if (woy > numOfWeeks(date.year)) {
    woy = 1;
  }
  return woy;
}

double expenditurePerDay(double amountInVault, List<Entry> listOfExpenses) {
  //what i should do instead => calculate how much i had in the vault at the start of the day and use that as amount in vault
  List<Entry> expensesToday = [];
  for (var i = 0; i < listOfExpenses.length; i++) {
    if (DateFormat('dMMMMyyyy').format(listOfExpenses[i].dateTime) ==
        DateFormat('dMMMMyyyy').format(DateTime.now())) {
      expensesToday.add(listOfExpenses[i]);
    } else {
      break;
    }
  }
  double sumUptoToday = amountInVault + sumOfEntries(expensesToday);
  DateTime today = DateTime.now();
  DateTime endOfMonth = DateTime(today.year, today.month + 1, 0);
  int numberOfDaysLeft = endOfMonth.day - today.day + 1;
  double dailyExpenditureForecast = sumUptoToday / numberOfDaysLeft;
  return dailyExpenditureForecast;
}

double expenditurePerWeek(double amountInVault, List<Entry> listOfExpenses) {
  List<Entry> expensesThisWeek = [];
  DateTime today = DateTime.now();
  int currentWeekNumber = weekNumber(today);
  DateTime endOfMonth = DateTime(today.year, today.month + 1, 0);
  int endWeekNumber = weekNumber(endOfMonth);
  double weeksLeft = endWeekNumber - currentWeekNumber + 1;
  for (var i = 0; i < listOfExpenses.length; i++) {
    if (weekNumber(listOfExpenses[i].dateTime) == currentWeekNumber) {
      expensesThisWeek.add(listOfExpenses[i]);
    } else {
      break;
    }
  }
  double sumUptoThisWeek = amountInVault + sumOfEntries(expensesThisWeek);
  double weeklyExpenditureForecast = sumUptoThisWeek / (weeksLeft<0?1:weeksLeft);
  return weeklyExpenditureForecast;
}
