import 'package:isar/isar.dart';

part 'category_entry.g.dart';

@collection
class CategoryEntry {
  Id id = Isar.autoIncrement;

  late String category;
  late int categoryColor;
}
