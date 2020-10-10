// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorDatabaseProvider {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseProviderBuilder databaseBuilder(String name) =>
      _$DatabaseProviderBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseProviderBuilder inMemoryDatabaseBuilder() =>
      _$DatabaseProviderBuilder(null);
}

class _$DatabaseProviderBuilder {
  _$DatabaseProviderBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$DatabaseProviderBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DatabaseProviderBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DatabaseProvider> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$DatabaseProvider();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseProvider extends DatabaseProvider {
  _$DatabaseProvider([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NewsDao _newsDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `table_news` (`url` TEXT, `title` TEXT, `description` TEXT, `urlToImage` TEXT, `author` TEXT, `localPath` TEXT, `isFavorite` INTEGER, PRIMARY KEY (`url`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NewsDao get newsDao {
    return _newsDaoInstance ??= _$NewsDao(database, changeListener);
  }
}

class _$NewsDao extends NewsDao {
  _$NewsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _newsInsertionAdapter = InsertionAdapter(
            database,
            'table_news',
            (News item) => <String, dynamic>{
                  'url': item.url,
                  'title': item.title,
                  'description': item.description,
                  'urlToImage': item.urlToImage,
                  'author': item.author,
                  'localPath': item.localPath,
                  'isFavorite': item.isFavorite
                },
            changeListener),
        _newsUpdateAdapter = UpdateAdapter(
            database,
            'table_news',
            ['url'],
            (News item) => <String, dynamic>{
                  'url': item.url,
                  'title': item.title,
                  'description': item.description,
                  'urlToImage': item.urlToImage,
                  'author': item.author,
                  'localPath': item.localPath,
                  'isFavorite': item.isFavorite
                },
            changeListener),
        _newsDeletionAdapter = DeletionAdapter(
            database,
            'table_news',
            ['url'],
            (News item) => <String, dynamic>{
                  'url': item.url,
                  'title': item.title,
                  'description': item.description,
                  'urlToImage': item.urlToImage,
                  'author': item.author,
                  'localPath': item.localPath,
                  'isFavorite': item.isFavorite
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _table_newsMapper = (Map<String, dynamic> row) => News(
      row['title'] as String,
      row['description'] as String,
      row['url'] as String,
      row['urlToImage'] as String,
      row['author'] as String,
      row['localPath'] as String,
      row['isFavorite'] as int);

  final InsertionAdapter<News> _newsInsertionAdapter;

  final UpdateAdapter<News> _newsUpdateAdapter;

  final DeletionAdapter<News> _newsDeletionAdapter;

  @override
  Stream<List<News>> getNewsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM table_news',
        queryableName: 'table_news', isView: false, mapper: _table_newsMapper);
  }

  @override
  Stream<List<News>> getFavoriteNewsAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM table_news WHERE isFavorite = 1',
        queryableName: 'table_news',
        isView: false,
        mapper: _table_newsMapper);
  }

  @override
  Future<int> addNews(News news) {
    return _newsInsertionAdapter.insertAndReturnId(
        news, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateNews(News news) {
    return _newsUpdateAdapter.updateAndReturnChangedRows(
        news, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteNews(News news) {
    return _newsDeletionAdapter.deleteAndReturnChangedRows(news);
  }
}
