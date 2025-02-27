import 'package:doshi/isar/app_settings.dart';
import 'package:doshi/isar/budget.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/isar/subcategory_entry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class AppSettingsDatabaseNotifier extends StateNotifier<List<AppSettingEntry>> {
  static late Isar isar;

  AppSettingsDatabaseNotifier() : super([]);

  // id = Name
  // 1 = FirstAppOpen&SecondAppOpen
  // 2 = SelfiePath
  // 3 = CurrencySymbol
  // 4 = EnableCamera
  // 5 = currentBudgetName
  // 6 = ChatGptApiKey

  final firstAppOpen = AppSettingEntry()
    ..appSettingName = "FirstAppOpen&SecondAppOpen"
    ..appSettingValue = "true&false";
  final selfiePathSetting = AppSettingEntry()
    ..appSettingName = "SelfiePath"
    ..appSettingValue = "";
  final currencySymbolSetting = AppSettingEntry()
    ..appSettingName = "CurrencySymbol"
    ..appSettingValue = "\$";
  final enableCameraSetting = AppSettingEntry()
    ..appSettingName = "EnableCamera"
    ..appSettingValue = "false";
  final currentBudgetNameSetting = AppSettingEntry()
    ..appSettingName = "currentBudgetName"
    ..appSettingValue = "Default";
  final chatgptApiKey = AppSettingEntry()
    ..appSettingName = "ChatGptApiKey"
    ..appSettingValue = "";
  //list of entries

  List<AppSettingEntry> currentSettings = [];

  //Initialise
  static Future<void> initialise() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      AppSettingEntrySchema,
      CategoryEntrySchema,
      EntrySchema,
      SubCategoryEntrySchema,
      BudgetSchema,
    ], directory: dir.path);
  }

  //create

  Future<void> addSetting(
    String appSettingName,
    String appSettingValue,
  ) async {
    //create new Setting
    final newAppSetting = AppSettingEntry()
      ..appSettingName = appSettingName
      ..appSettingValue = appSettingValue;

    //save to database
    await isar.writeTxn(() => isar.appSettingEntrys.put(newAppSetting));

    //update from database
    fetchEntries();
  }

  //read/fetch & update state
  Future<void> fetchEntries() async {
    List<AppSettingEntry> newCurrentSettings = [];
    List<AppSettingEntry> fetchedEntries =
        await isar.appSettingEntrys.where().findAll();
    currentSettings.clear();
    currentSettings.addAll(fetchedEntries);
    if (currentSettings.isEmpty) {
      await isar.writeTxn(() => isar.appSettingEntrys.put(firstAppOpen));
      await isar.writeTxn(() => isar.appSettingEntrys.put(selfiePathSetting));
      await isar
          .writeTxn(() => isar.appSettingEntrys.put(currencySymbolSetting));
      await isar.writeTxn(() => isar.appSettingEntrys.put(enableCameraSetting));
      await isar
          .writeTxn(() => isar.appSettingEntrys.put(currentBudgetNameSetting));
      await isar
          .writeTxn(() => isar.appSettingEntrys.put(chatgptApiKey));
    } else {
      newCurrentSettings = await isar.appSettingEntrys.where().findAll();
      if (newCurrentSettings.length < 2) {
        // inititating setting 2 if it doesnt exist
        await addSetting("SelfiePath", "");
      }
      newCurrentSettings = await isar.appSettingEntrys.where().findAll();
      if (newCurrentSettings.length < 3) {
        // inititating setting 3 if it doesnt exist
        await addSetting("CurrencySymbol", "\$");
      }
      newCurrentSettings = await isar.appSettingEntrys.where().findAll();
      if (newCurrentSettings.length < 4) {
        // inititating setting 4 if it doesnt exist
        await addSetting("EnableCamera", "false");
      }
      newCurrentSettings = await isar.appSettingEntrys.where().findAll();
      if (newCurrentSettings.length < 5) {
        // inititating setting 5 if it doesnt exist
        await addSetting("currentBudgetName", "Default");
      }
      newCurrentSettings = await isar.appSettingEntrys.where().findAll();
      if (newCurrentSettings.length < 6) {
        // inititating setting 5 if it doesnt exist
        await addSetting("ChatGptApiKey", "");
      }
      newCurrentSettings = await isar.appSettingEntrys.where().findAll();
      if (currentSettings[0].appSettingValue == "true&false") {
        editSetting(
            currentSettings[0].id, "FirstAppOpen&SecondAppOpen", "true&true");
      }
    }
    newCurrentSettings = await isar.appSettingEntrys.where().findAll();
    currentSettings = [...newCurrentSettings];
    state = [...newCurrentSettings];
  }

  Future<List<AppSettingEntry>> fetchSettings() async {
    return await isar.appSettingEntrys.where().findAll();
  }

  //edit
  Future<void> editSetting(
      int id, String newAppSettingName, String newAppSettingValue) async {
    final existingSetting = await isar.appSettingEntrys.get(id);
    if (existingSetting != null) {
      existingSetting.appSettingName = newAppSettingName;
      existingSetting.appSettingValue = newAppSettingValue;
      await isar.writeTxn(() => isar.appSettingEntrys.put(existingSetting));
      await fetchEntries();
    }
  }

  //delete
  Future<void> deleteSetting(int id) async {
    await isar.writeTxn(() => isar.appSettingEntrys.delete(id));
    await fetchEntries();
  }
}
