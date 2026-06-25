import 'package:drift/drift.dart';

class Prompts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get prompt => text().customConstraint('NOT NULL COLLATE NOCASE')();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
