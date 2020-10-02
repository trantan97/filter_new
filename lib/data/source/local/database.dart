import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:filter_news/data/model/news.dart';
import 'package:filter_news/data/source/local/dao/news_dao.dart';
import 'package:floor/floor.dart';

part 'database.g.dart';

const String DB_NAME = "news_database";

@Database(version: 1, entities: [News])
abstract class DatabaseProvider extends FloorDatabase {
  static DatabaseProvider _database;

  static Future<DatabaseProvider> get databaseProvider async {
    _database ??= await $FloorDatabaseProvider.databaseBuilder(DB_NAME).build();
    return _database;
  }

  NewsDao get newsDao;
}
