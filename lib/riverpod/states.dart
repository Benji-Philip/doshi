import 'package:doshi/isar/app_settings_database.dart';
import 'package:doshi/isar/category_database.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final dateToDisplay = StateProvider((ref) => DateTime.now());


  final analysisOfExpenses =
      StateProvider((ref) => ref.read(entryDatabaseProvider.notifier).analysisOfCategories);


final appOpened = StateProvider((ref) => false);
final exceedVault = StateProvider((ref) => false);
final exceedSavings = StateProvider((ref) => false);
final currentPage = StateProvider((ref) => "Home");
final snackbarProvider = StateProvider<String>((ref) => '');

final currencyProvider = StateProvider((ref) => "₹");
final amountText = StateProvider((ref) => "500");
final noteText = StateProvider((ref) => "");
final categoryText = StateProvider((ref) => "Uncategorised");
final dateTimeVar = StateProvider((ref) => DateTime.now());
final isExpense = StateProvider((ref) => true);
final isSavings = StateProvider((ref) => false);
final appOpenedTime =
    StateProvider((ref) => DateFormat('d').format(DateTime.now()));

final backupRestoreSuccess = StateProvider((ref) => true);

final categoryColorInt =
    StateProvider((ref) => const Color.fromARGB(255, 255, 255, 255).value);
final entryDatabaseProvider =
    StateNotifierProvider<EntryDatabaseNotifier, List<Entry>>(
        (ref) => EntryDatabaseNotifier());
final categoryDatabaseProvider =
    StateNotifierProvider((ref) => CategoryDatabaseNotifier());
final appSettingsDatabaseProvider =
    StateNotifierProvider((ref) => AppSettingsDatabaseNotifier());

void setDefaultValues(WidgetRef ref) {
  ref.read(amountText.notifier).update((state) => "500");
  ref.read(noteText.notifier).update((state) => "");
  ref.read(categoryText.notifier).update((state) => "Uncategorised");
  ref
      .read(categoryColorInt.notifier)
      .update((state) => const Color.fromARGB(255, 255, 255, 255).value);
  ref.read(exceedVault.notifier).update((state) => false);
  ref.read(exceedSavings.notifier).update((state) => false);
  ref.read(isSavings.notifier).update((state) => false);
}
