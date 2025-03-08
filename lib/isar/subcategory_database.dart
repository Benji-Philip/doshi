import 'package:doshi/isar/app_settings.dart';
import 'package:doshi/isar/subcategory_entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class SubCategoryDatabaseNotifier
    extends StateNotifier<List<SubCategoryEntry>> {
  static late Isar isar;

  SubCategoryDatabaseNotifier() : super([]);

  //Initialise
  static Future<void> initialise() async {
    isar = Isar.getInstance()!;
  }

  //list of default categories
  final icecream = SubCategoryEntry()
    ..parentCategory = "Food"
    ..subCategory = "Dining Out"
    ..subCategoryColor = const Color.fromARGB(255, 54, 231, 244).toARGB32();
  final coffee = SubCategoryEntry()
    ..parentCategory = "Food"
    ..subCategory = "Coffee"
    ..subCategoryColor = const Color.fromARGB(255, 137, 80, 15).toARGB32();
  final junk = SubCategoryEntry()
    ..parentCategory = "Food"
    ..subCategory = "Snacks"
    ..subCategoryColor = const Color.fromARGB(255, 133, 97, 57).toARGB32();
  final restaurant = SubCategoryEntry()
    ..parentCategory = "Food"
    ..subCategory = "Delivery"
    ..subCategoryColor = const Color.fromARGB(255, 174, 54, 244).toARGB32();
  final eggs = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Eggs"
    ..subCategoryColor = const Color.fromARGB(255, 238, 244, 54).toARGB32();
  final meat = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Meat"
    ..subCategoryColor = const Color.fromARGB(255, 255, 75, 75).toARGB32();
  final milk = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Dairy"
    ..subCategoryColor = const Color.fromARGB(255, 164, 231, 255).toARGB32();
  final fruits = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Fruits"
    ..subCategoryColor = const Color.fromARGB(255, 244, 54, 54).toARGB32();
  final vegetables = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Vegetables"
    ..subCategoryColor = const Color.fromARGB(255, 25, 161, 54).toARGB32();
  final metro = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Metro"
    ..subCategoryColor = const Color.fromARGB(255, 76, 209, 118).toARGB32();
  final railway = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Railway"
    ..subCategoryColor = const Color.fromARGB(255, 209, 138, 76).toARGB32();
  final flight = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Flight"
    ..subCategoryColor = const Color.fromARGB(255, 128, 172, 217).toARGB32();
  final gas = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Gas"
    ..subCategoryColor = const Color.fromARGB(255, 177, 123, 61).toARGB32();
  final repairs = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Repairs"
    ..subCategoryColor = const Color.fromARGB(255, 255, 178, 91).toARGB32();
  final electricity = SubCategoryEntry()
    ..parentCategory = "Utilities"
    ..subCategory = "Electricity"
    ..subCategoryColor = const Color.fromARGB(255, 240, 255, 70).toARGB32();
  final water = SubCategoryEntry()
    ..parentCategory = "Utilities"
    ..subCategory = "Water"
    ..subCategoryColor = const Color.fromARGB(255, 70, 172, 255).toARGB32();
  final trash = SubCategoryEntry()
    ..parentCategory = "Utilities"
    ..subCategory = "Trash"
    ..subCategoryColor = const Color.fromARGB(255, 167, 106, 32).toARGB32();
  final medicine = SubCategoryEntry()
    ..parentCategory = "Healthcare"
    ..subCategory = "Medicine"
    ..subCategoryColor = const Color.fromARGB(255, 54, 244, 238).toARGB32();
  final doctor = SubCategoryEntry()
    ..parentCategory = "Healthcare"
    ..subCategory = "Dental"
    ..subCategoryColor = const Color.fromARGB(255, 244, 54, 155).toARGB32();
  final vitamins = SubCategoryEntry()
    ..parentCategory = "Healthcare"
    ..subCategory = "Insurance"
    ..subCategoryColor = const Color.fromARGB(255, 187, 54, 244).toARGB32();
  final movie = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Movies"
    ..subCategoryColor = const Color.fromARGB(255, 244, 225, 54).toARGB32();
  final books = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Books"
    ..subCategoryColor = const Color.fromARGB(255, 54, 70, 244).toARGB32();
  final games = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Games"
    ..subCategoryColor = const Color.fromARGB(255, 255, 47, 47).toARGB32();
  final arcade = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Arcade"
    ..subCategoryColor = const Color.fromARGB(255, 144, 47, 145).toARGB32();
  final vpn = SubCategoryEntry()
    ..parentCategory = "Internet"
    ..subCategory = "VPN"
    ..subCategoryColor = const Color.fromARGB(255, 131, 75, 167).toARGB32();
  final wifi = SubCategoryEntry()
    ..parentCategory = "Internet"
    ..subCategory = "WiFi"
    ..subCategoryColor = const Color.fromARGB(255, 63, 130, 255).toARGB32();
  final cellular = SubCategoryEntry()
    ..parentCategory = "Internet"
    ..subCategory = "Cellular"
    ..subCategoryColor = const Color.fromARGB(255, 255, 63, 63).toARGB32();
  final charity = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Charity"
    ..subCategoryColor = const Color.fromARGB(255, 54, 244, 181).toARGB32();
  final haircut = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Emergency"
    ..subCategoryColor = const Color.fromARGB(255, 244, 54, 54).toARGB32();
  final gifts = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Gifts"
    ..subCategoryColor = const Color.fromARGB(255, 255, 102, 227).toARGB32();
  final clothing = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Clothing"
    ..subCategoryColor = const Color.fromARGB(255, 255, 199, 44).toARGB32();
  final personal = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Personal"
    ..subCategoryColor = const Color.fromARGB(255, 95, 54, 244).toARGB32();

  //list of entries

  final List<SubCategoryEntry> currentSubCategories = [];

  final List<AppSettingEntry> currentSettings = [];

  //create

  Future<void> addSubCategory(String subCategoryEntry, int subCategoryColor,
      String parentCategory) async {
    //create new Category
    final newSubCategory = SubCategoryEntry()
      ..parentCategory = parentCategory
      ..subCategory = subCategoryEntry
      ..subCategoryColor = subCategoryColor;

    //save to database
    await isar.writeTxn(() => isar.subCategoryEntrys.put(newSubCategory));

    //update from database
    await fetchEntries();
  }

  //read/fetch & update state
  Future<void> fetchEntries() async {
    List<SubCategoryEntry> fetchedEntries =
        await isar.subCategoryEntrys.where().findAll();
    fetchedEntries = fetchedEntries.reversed.toList();
    currentSubCategories.clear();
    currentSubCategories.addAll(fetchedEntries);
    if (currentSubCategories.isEmpty) {
      await isar.writeTxn(() => isar.subCategoryEntrys.put(icecream));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(junk));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(coffee));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(restaurant));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(eggs));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(fruits));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(vegetables));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(meat));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(milk));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(railway));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(flight));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(metro));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(gas));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(repairs));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(electricity));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(water));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(trash));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(medicine));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(doctor));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(vitamins));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(movie));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(books));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(games));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(arcade));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(wifi));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(cellular));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(vpn));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(haircut));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(charity));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(gifts));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(clothing));
      await isar.writeTxn(() => isar.subCategoryEntrys.put(personal));
      fetchedEntries = await isar.subCategoryEntrys.where().findAll();
      currentSubCategories.clear();
      currentSubCategories.addAll(fetchedEntries);
    }

    state = [...currentSubCategories];
  }

  //edit
  Future<void> editSubCategory(WidgetRef ref, int id, String newSubCategory,
      int newSubCategoryColor, String parentCategory) async {
    final existingSubCategory = await isar.subCategoryEntrys.get(id);
    if (existingSubCategory != null) {
      final listOfAllExpenses = sortEntrysByParentCategory(parentCategory,
          ref.read(entryDatabaseProvider.notifier).theListOfTheExpenses);
      existingSubCategory.subCategory = newSubCategory;
      existingSubCategory.subCategoryColor = newSubCategoryColor;
      await isar
          .writeTxn(() => isar.subCategoryEntrys.put(existingSubCategory));
      for (var expense in listOfAllExpenses) {
        if (expense.subCategory == existingSubCategory.subCategory) {
          ref
              .read(amountText.notifier)
              .update((state) => expense.amount.toString());
          ref.read(noteText.notifier).update((state) => expense.note ?? "");
          ref.read(dateTimeVar.notifier).update((state) => expense.dateTime);
          ref.read(isExpense.notifier).update((state) => expense.isExpense);
          ref
              .read(categoryText.notifier)
              .update((state) => expense.category ?? "Uncategorised");
          ref
              .read(categoryColorInt.notifier)
              .update((state) => expense.categoryColor ?? Colors.white.toARGB32());
          ref
              .read(isSavings.notifier)
              .update((state) => expense.isSavings ?? false);
          ref.read(entryDatabaseProvider.notifier).editEntry(
              expense.id,
              ref.read(categoryText),
              double.parse(ref.read(amountText)),
              ref.read(noteText),
              ref.read(dateTimeVar),
              ref.read(isExpense),
              ref.read(categoryColorInt),
              ref.read(isSavings),
              newSubCategory,
              newSubCategoryColor);
        }
      }
      await fetchEntries();
    }
  }

  //delete
  Future<void> deleteSubCategory(int id) async {
    await isar.writeTxn(() => isar.subCategoryEntrys.delete(id));
    await fetchEntries();
  }
}
