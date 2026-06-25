// import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:prompt_creator_flutter_app/helpers/io.dart';
import 'package:prompt_creator_flutter_app/helpers/prompts.dart';

part 'app_db.g.dart';

@DriftDatabase(tables: [Prompts])
class AppDb extends _$AppDb {
  AppDb([QueryExecutor? e]) : super(_openConnection(e));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy();

  ///////////////////
  /// PROMPTS
  ///////////////////
  Future<int> addPrompt(PromptsCompanion prompt) async {
    return into(prompts).insert(prompt);
  }

  Future<List<Prompt>> getAllPrompts() {
    return (select(
      prompts,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  Future<Prompt?> getLatestPrompt() {
    return (select(prompts)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int?> getNumberOfPrompts() async {
    Expression<int> count = prompts.id.count();

    final query = selectOnly(prompts)..addColumns([count]);
    return await query.map((row) => row.read(count)).getSingle();
  }

  Future<List<Prompt>> searchPrompts(String term) {
    print('search');
    return (select(prompts)
          ..where((t) => t.prompt.like('%$term%'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future deleteAllPrompts() async {
    return (delete(prompts)).go();
  }

  Future<int> deletePrompt(int id) {
    return (delete(prompts)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updatePrompt(Prompt prompt) {
    return update(prompts).replace(prompt);
  }
}

QueryExecutor _openConnection(QueryExecutor? e) {
  return driftDatabase(
    name: 'prompt_creator_data',
    native: DriftNativeOptions(
      databaseDirectory: getPromptCreatorDocumentsDirectory,
    ),
  );
}

AppDb db = AppDb();
