// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $PromptsTable extends Prompts with TableInfo<$PromptsTable, Prompt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
    'prompt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL COLLATE NOCASE',
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, prompt, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prompts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Prompt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('prompt')) {
      context.handle(
        _promptMeta,
        prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta),
      );
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Prompt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prompt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      prompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PromptsTable createAlias(String alias) {
    return $PromptsTable(attachedDatabase, alias);
  }
}

class Prompt extends DataClass implements Insertable<Prompt> {
  final int id;
  final String prompt;
  final String? notes;
  final DateTime createdAt;
  const Prompt({
    required this.id,
    required this.prompt,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['prompt'] = Variable<String>(prompt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PromptsCompanion toCompanion(bool nullToAbsent) {
    return PromptsCompanion(
      id: Value(id),
      prompt: Value(prompt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Prompt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prompt(
      id: serializer.fromJson<int>(json['id']),
      prompt: serializer.fromJson<String>(json['prompt']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prompt': serializer.toJson<String>(prompt),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Prompt copyWith({
    int? id,
    String? prompt,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Prompt(
    id: id ?? this.id,
    prompt: prompt ?? this.prompt,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Prompt copyWithCompanion(PromptsCompanion data) {
    return Prompt(
      id: data.id.present ? data.id.value : this.id,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prompt(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, prompt, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prompt &&
          other.id == this.id &&
          other.prompt == this.prompt &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class PromptsCompanion extends UpdateCompanion<Prompt> {
  final Value<int> id;
  final Value<String> prompt;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const PromptsCompanion({
    this.id = const Value.absent(),
    this.prompt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PromptsCompanion.insert({
    this.id = const Value.absent(),
    required String prompt,
    this.notes = const Value.absent(),
    required DateTime createdAt,
  }) : prompt = Value(prompt),
       createdAt = Value(createdAt);
  static Insertable<Prompt> custom({
    Expression<int>? id,
    Expression<String>? prompt,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prompt != null) 'prompt': prompt,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PromptsCompanion copyWith({
    Value<int>? id,
    Value<String>? prompt,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return PromptsCompanion(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptsCompanion(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $PromptsTable prompts = $PromptsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [prompts];
}

typedef $$PromptsTableCreateCompanionBuilder =
    PromptsCompanion Function({
      Value<int> id,
      required String prompt,
      Value<String?> notes,
      required DateTime createdAt,
    });
typedef $$PromptsTableUpdateCompanionBuilder =
    PromptsCompanion Function({
      Value<int> id,
      Value<String> prompt,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$PromptsTableFilterComposer extends Composer<_$AppDb, $PromptsTable> {
  $$PromptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PromptsTableOrderingComposer extends Composer<_$AppDb, $PromptsTable> {
  $$PromptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PromptsTableAnnotationComposer
    extends Composer<_$AppDb, $PromptsTable> {
  $$PromptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PromptsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $PromptsTable,
          Prompt,
          $$PromptsTableFilterComposer,
          $$PromptsTableOrderingComposer,
          $$PromptsTableAnnotationComposer,
          $$PromptsTableCreateCompanionBuilder,
          $$PromptsTableUpdateCompanionBuilder,
          (Prompt, BaseReferences<_$AppDb, $PromptsTable, Prompt>),
          Prompt,
          PrefetchHooks Function()
        > {
  $$PromptsTableTableManager(_$AppDb db, $PromptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> prompt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PromptsCompanion(
                id: id,
                prompt: prompt,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String prompt,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
              }) => PromptsCompanion.insert(
                id: id,
                prompt: prompt,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PromptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $PromptsTable,
      Prompt,
      $$PromptsTableFilterComposer,
      $$PromptsTableOrderingComposer,
      $$PromptsTableAnnotationComposer,
      $$PromptsTableCreateCompanionBuilder,
      $$PromptsTableUpdateCompanionBuilder,
      (Prompt, BaseReferences<_$AppDb, $PromptsTable, Prompt>),
      Prompt,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$PromptsTableTableManager get prompts =>
      $$PromptsTableTableManager(_db, _db.prompts);
}
