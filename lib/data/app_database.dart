import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'category.dart';
import 'category_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Category])
abstract class AppDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
}