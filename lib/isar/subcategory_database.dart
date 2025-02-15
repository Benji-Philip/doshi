import 'dart:ui';

import 'package:doshi/isar/app_settings.dart';
import 'package:doshi/isar/subcategory_entry.dart';
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
    ..subCategoryColor = const Color.fromARGB(255, 54, 231, 244).value;
  final coffee = SubCategoryEntry()
    ..parentCategory = "Food"
    ..subCategory = "Coffee"
    ..subCategoryColor = const Color.fromARGB(255, 137, 80, 15).value;
  final junk = SubCategoryEntry()
    ..parentCategory = "Food"
    ..subCategory = "Snacks"
    ..subCategoryColor = const Color.fromARGB(255, 133, 97, 57).value;
  final restaurant = SubCategoryEntry()
    ..parentCategory = "Food"
    ..subCategory = "Delivery"
    ..subCategoryColor = const Color.fromARGB(255, 174, 54, 244).value;
  final eggs = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Eggs"
    ..subCategoryColor = const Color.fromARGB(255, 238, 244, 54).value;
  final meat = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Meat"
    ..subCategoryColor = const Color.fromARGB(255, 164, 243, 255).value;
  final milk = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Dairy"
    ..subCategoryColor = const Color.fromARGB(255, 164, 243, 255).value;
  final fruits = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Fruits"
    ..subCategoryColor = const Color.fromARGB(255, 244, 54, 54).value;
  final vegetables = SubCategoryEntry()
    ..parentCategory = "Groceries"
    ..subCategory = "Vegetables"
    ..subCategoryColor = const Color.fromARGB(255, 25, 161, 54).value;
  final metro = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Metro"
    ..subCategoryColor = const Color.fromARGB(255, 76, 209, 118).value;
  final railway = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Railway"
    ..subCategoryColor = const Color.fromARGB(255, 209, 138, 76).value;
  final flight = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Flight"
    ..subCategoryColor = const Color.fromARGB(255, 128, 172, 217).value;
  final gas = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Gas"
    ..subCategoryColor = const Color.fromARGB(255, 177, 123, 61).value;
  final repairs = SubCategoryEntry()
    ..parentCategory = "Transportation"
    ..subCategory = "Repairs"
    ..subCategoryColor = const Color.fromARGB(255, 177, 123, 61).value;
  final electricity = SubCategoryEntry()
    ..parentCategory = "Utilities"
    ..subCategory = "Electricity"
    ..subCategoryColor = const Color.fromARGB(255, 240, 255, 70).value;
  final water = SubCategoryEntry()
    ..parentCategory = "Utilities"
    ..subCategory = "Water"
    ..subCategoryColor = const Color.fromARGB(255, 70, 172, 255).value;
  final trash = SubCategoryEntry()
    ..parentCategory = "Utilities"
    ..subCategory = "Trash"
    ..subCategoryColor = const Color.fromARGB(255, 167, 106, 32).value;
  final medicine = SubCategoryEntry()
    ..parentCategory = "Healthcare"
    ..subCategory = "Medicine"
    ..subCategoryColor = const Color.fromARGB(255, 54, 244, 238).value;
  final doctor = SubCategoryEntry()
    ..parentCategory = "Healthcare"
    ..subCategory = "Dental"
    ..subCategoryColor = const Color.fromARGB(255, 244, 54, 155).value;
  final vitamins = SubCategoryEntry()
    ..parentCategory = "Healthcare"
    ..subCategory = "Insurance"
    ..subCategoryColor = const Color.fromARGB(255, 187, 54, 244).value;
  final movie = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Movies"
    ..subCategoryColor = const Color.fromARGB(255, 244, 225, 54).value;
  final books = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Books"
    ..subCategoryColor = const Color.fromARGB(255, 54, 70, 244).value;
  final games = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Games"
    ..subCategoryColor = const Color.fromARGB(255, 255, 47, 47).value;
  final arcade = SubCategoryEntry()
    ..parentCategory = "Entertainment"
    ..subCategory = "Arcade"
    ..subCategoryColor = const Color.fromARGB(255, 144, 47, 145).value;
  final vpn = SubCategoryEntry()
    ..parentCategory = "Internet"
    ..subCategory = "VPN"
    ..subCategoryColor = const Color.fromARGB(255, 63, 130, 255).value;
  final wifi = SubCategoryEntry()
    ..parentCategory = "Internet"
    ..subCategory = "WiFi"
    ..subCategoryColor = const Color.fromARGB(255, 63, 130, 255).value;
  final cellular = SubCategoryEntry()
    ..parentCategory = "Internet"
    ..subCategory = "Cellular"
    ..subCategoryColor = const Color.fromARGB(255, 255, 63, 63).value;
  final charity = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Charity"
    ..subCategoryColor = const Color.fromARGB(255, 54, 244, 181).value;
  final haircut = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Emergency"
    ..subCategoryColor = const Color.fromARGB(255, 244, 54, 54).value;
  final gifts = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Gifts"
    ..subCategoryColor = const Color.fromARGB(255, 54, 244, 181).value;
  final clothing = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Clothing"
    ..subCategoryColor = const Color.fromARGB(255, 54, 244, 181).value;
  final personal = SubCategoryEntry()
    ..parentCategory = "Miscellaneous"
    ..subCategory = "Personal"
    ..subCategoryColor = const Color.fromARGB(255, 54, 244, 181).value;

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
    fetchEntries();
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
  Future<void> editCategory(
      int id, String newSubCategory, int newSubCategoryColor, String newParentCategory) async {
    final existingSubCategory = await isar.subCategoryEntrys.get(id);
    if (existingSubCategory != null) {
      existingSubCategory.parentCategory = newParentCategory;
      existingSubCategory.subCategory = newSubCategory;
      existingSubCategory.subCategoryColor = newSubCategoryColor;
      await isar
          .writeTxn(() => isar.subCategoryEntrys.put(existingSubCategory));
      await fetchEntries();
    }
  }

  //delete
  Future<void> deleteSubCategory(int id) async {
    await isar.writeTxn(() => isar.subCategoryEntrys.delete(id));
    await fetchEntries();
  }
}
