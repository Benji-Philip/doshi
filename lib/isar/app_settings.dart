import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@collection
class AppSettingEntry {
  Id id = Isar.autoIncrement;
  late String appSettingName;
  late String appSettingValue;
}
