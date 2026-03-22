import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';

abstract class BaseDao<T> {
  String get tableName;
  String get primaryKey;
  Map<String, dynamic> toMap(T entity);
  T fromMap(Map<String, dynamic> map);

  Future<Database> get db => DatabaseHelper.database;

  Future<int> insert(T entity) async {
    final database = await db;
    return database.insert(tableName, toMap(entity), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<T>> getAll({String? orderBy, int? limit}) async {
    final database = await db;
    final maps = await database.query(tableName, orderBy: orderBy, limit: limit);
    return maps.map(fromMap).toList();
  }

  Future<int> deleteById(String id) async {
    final database = await db;
    return database.delete(tableName, where: '$primaryKey = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final database = await db;
    return database.delete(tableName);
  }
}
