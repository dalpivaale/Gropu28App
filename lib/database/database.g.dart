// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PaceDao? _paceDaoInstance;

  SedDao? _sedDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Pace` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `steptodo` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Sed` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `minsed` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PaceDao get paceDao {
    return _paceDaoInstance ??= _$PaceDao(database, changeListener);
  }

  @override
  SedDao get sedDao {
    return _sedDaoInstance ??= _$SedDao(database, changeListener);
  }
}

class _$PaceDao extends PaceDao {
  _$PaceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _paceInsertionAdapter = InsertionAdapter(
            database,
            'Pace',
            (Pace item) => <String, Object?>{
                  'id': item.id,
                  'steptodo': item.steptodo,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _paceUpdateAdapter = UpdateAdapter(
            database,
            'Pace',
            ['id'],
            (Pace item) => <String, Object?>{
                  'id': item.id,
                  'steptodo': item.steptodo,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _paceDeletionAdapter = DeletionAdapter(
            database,
            'Pace',
            ['id'],
            (Pace item) => <String, Object?>{
                  'id': item.id,
                  'steptodo': item.steptodo,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Pace> _paceInsertionAdapter;

  final UpdateAdapter<Pace> _paceUpdateAdapter;

  final DeletionAdapter<Pace> _paceDeletionAdapter;

  @override
  Future<List<Pace>> findAllPaces() async {
    return _queryAdapter.queryList('SELECT * FROM Pace',
        mapper: (Map<String, Object?> row) => Pace(
            row['id'] as int?,
            row['steptodo'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertPace(Pace pace) async {
    await _paceInsertionAdapter.insert(pace, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePace(Pace pace) async {
    await _paceUpdateAdapter.update(pace, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePace(Pace task) async {
    await _paceDeletionAdapter.delete(task);
  }
}

class _$SedDao extends SedDao {
  _$SedDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _sedInsertionAdapter = InsertionAdapter(
            database,
            'Sed',
            (Sed item) => <String, Object?>{
                  'id': item.id,
                  'minsed': item.minsed,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _sedUpdateAdapter = UpdateAdapter(
            database,
            'Sed',
            ['id'],
            (Sed item) => <String, Object?>{
                  'id': item.id,
                  'minsed': item.minsed,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _sedDeletionAdapter = DeletionAdapter(
            database,
            'Sed',
            ['id'],
            (Sed item) => <String, Object?>{
                  'id': item.id,
                  'minsed': item.minsed,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sed> _sedInsertionAdapter;

  final UpdateAdapter<Sed> _sedUpdateAdapter;

  final DeletionAdapter<Sed> _sedDeletionAdapter;

  @override
  Future<List<Sed>> findAllSeds() async {
    return _queryAdapter.queryList('SELECT * FROM Sed',
        mapper: (Map<String, Object?> row) => Sed(
            row['id'] as int?,
            row['minsed'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertSed(Sed sed) async {
    await _sedInsertionAdapter.insert(sed, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSed(Sed sed) async {
    await _sedUpdateAdapter.update(sed, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSed(Sed seddelete) async {
    await _sedDeletionAdapter.delete(seddelete);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
