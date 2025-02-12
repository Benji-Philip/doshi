import 'package:isar/isar.dart';

part 'entry.g.dart';

@collection
class Entry {
  Id id = Isar.autoIncrement;

  String? note;
  String? category;
  String? subCategory;
  int? categoryColor;
  int? subCategoryColor;
  late bool isExpense;
  late DateTime dateTime;
  late double amount;
  bool? isSavings;
}
