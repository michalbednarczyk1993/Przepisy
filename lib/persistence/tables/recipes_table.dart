import 'package:drift/drift.dart';

import 'categories_table.dart';

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get imagePath => text().nullable()();
  TextColumn get ingredients => text().withDefault(const Constant(''))();
  TextColumn get instructions => text().withDefault(const Constant(''))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
