import 'package:isar/isar.dart';

part 'subcategory_entry.g.dart';

@collection
class SubCategoryEntry {
  Id id = Isar.autoIncrement;
  
  late String parentCategory;
  late String subCategory;
  late int subCategoryColor;
}
