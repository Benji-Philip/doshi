import 'dart:ui';

import 'package:doshi/isar/app_settings.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class CategoryDatabaseNotifier extends StateNotifier<List<CategoryEntry>> {
  static late Isar isar;

  CategoryDatabaseNotifier() : super([]);

  //Initialise
  static Future<void> initialise() async {
    isar = Isar.getInstance()!;
  }

  //list of default categories

  final uncategorised = CategoryEntry()
    ..category = "Uncategorised"
    ..categoryColor = const Color.fromARGB(255, 255, 255, 255).value;
  final food = CategoryEntry()
    ..category = "Food"
    ..categoryColor = const Color.fromARGB(255, 54, 244, 111).value;
  final groceries = CategoryEntry()
    ..category = "Groceries"
    ..categoryColor = const Color.fromARGB(255, 98, 54, 244).value;
  final transportation = CategoryEntry()
    ..category = "Transportation"
    ..categoryColor = const Color.fromARGB(255, 76, 196, 209).value;
  final utilities = CategoryEntry()
    ..category = "Utilities"
    ..categoryColor = const Color.fromARGB(255, 240, 255, 70).value;
  final healthcare = CategoryEntry()
    ..category = "Healthcare"
    ..categoryColor = const Color.fromARGB(255, 244, 54, 155).value;
  final entertainment = CategoryEntry()
    ..category = "Entertainment"
    ..categoryColor = const Color.fromARGB(255, 54, 70, 244).value;
  final internet = CategoryEntry()
    ..category = "Internet"
    ..categoryColor = const Color.fromARGB(255, 255, 63, 63).value;
  final miscellaneous = CategoryEntry()
    ..category = "Miscellaneous"
    ..categoryColor = const Color.fromARGB(255, 54, 244, 181).value;

  //list of entries

  final List<CategoryEntry> currentCategories = [];

  final List<AppSettingEntry> currentSettings = [];

  //create

  Future<void> addCategory(String categoryEntry, int categoryColor) async {
    //create new Category
    final newCategory = CategoryEntry()
      ..category = categoryEntry
      ..categoryColor = categoryColor;

    //save to database
    await isar.writeTxn(() => isar.categoryEntrys.put(newCategory));

    //update from database
    fetchEntries();
  }

  //read/fetch & update state
  Future<void> fetchEntries() async {
    List<CategoryEntry> fetchedEntries =
        await isar.categoryEntrys.where().findAll();
    fetchedEntries = fetchedEntries.reversed.toList();
    currentCategories.clear();
    currentCategories.addAll(fetchedEntries);
      if (currentCategories.isEmpty) {
        await isar.writeTxn(() => isar.categoryEntrys.put(uncategorised));
        await isar.writeTxn(() => isar.categoryEntrys.put(food));
        await isar.writeTxn(() => isar.categoryEntrys.put(groceries));
        await isar.writeTxn(() => isar.categoryEntrys.put(transportation));
        await isar.writeTxn(() => isar.categoryEntrys.put(utilities));
        await isar.writeTxn(() => isar.categoryEntrys.put(healthcare));
        await isar.writeTxn(() => isar.categoryEntrys.put(entertainment));
        await isar.writeTxn(() => isar.categoryEntrys.put(internet));
        await isar.writeTxn(() => isar.categoryEntrys.put(miscellaneous));
        fetchedEntries = await isar.categoryEntrys.where().findAll();
        currentCategories.clear();
        currentCategories.addAll(fetchedEntries);
      }
    state = [...currentCategories];
  }

  //edit
  Future<void> editCategory(
      int id, String newCategory, int newCategoryColor) async {
    final existingCategory = await isar.categoryEntrys.get(id);
    if (existingCategory != null) {
      existingCategory.category = newCategory;
      existingCategory.categoryColor = newCategoryColor;
      await isar.writeTxn(() => isar.categoryEntrys.put(existingCategory));
      await fetchEntries();
    }
  }

  //delete
  Future<void> deleteCategory(int id) async {
    await isar.writeTxn(() => isar.categoryEntrys.delete(id));
    await fetchEntries();
  }
}
