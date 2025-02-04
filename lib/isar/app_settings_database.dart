import 'package:doshi/isar/app_settings.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:doshi/isar/entry.dart';
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

  final firstAppOpen = AppSettingEntry()
    ..appSettingName = "FirstAppOpen&SecondAppOpen"
    ..appSettingValue = "true&false";
  //list of entries

  final List<AppSettingEntry> currentSettings = [];

  //Initialise
  static Future<void> initialise() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [AppSettingEntrySchema, CategoryEntrySchema, EntrySchema],
        directory: dir.path);
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
    List<AppSettingEntry> fetchedEntries =
        await isar.appSettingEntrys.where().findAll();
    currentSettings.clear();
    currentSettings.addAll(fetchedEntries);
    if (currentSettings.isEmpty) {
      await isar.writeTxn(() => isar.appSettingEntrys.put(firstAppOpen));
    } else if (currentSettings[0].appSettingValue == "true&false") {
      editSetting(
          currentSettings[0].id, "FirstAppOpen&SecondAppOpen", "true&true");
    }
    if (currentSettings.length<=1) {
      // inititating setting 2 if it doesnt exist
      addSetting("SelfiePath", "");
    }if (currentSettings.length<=2) {
      // inititating setting 3 if it doesnt exist
      addSetting("CurrencySymbol", "\$");
    }
    state = [];
    state = currentSettings;
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
