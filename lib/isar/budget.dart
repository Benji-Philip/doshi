import 'package:isar/isar.dart';

part 'budget.g.dart';

@collection
class Budget {
  Id id = Isar.autoIncrement;

  late String budgetName;
  late String entriesListJSON;
}
