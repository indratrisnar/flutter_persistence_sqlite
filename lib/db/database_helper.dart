import 'dart:developer';

import 'package:flutter_persistence_sqlite/models/cat.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;

  Database? _db;
  Future<Database> get db async => _db ??= await _initDB();

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'pet.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
        CREATE TABLE cats(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          age INTEGER
        )
        ''');
        log('table cats created');
      },
    );
  }

  Future<List<Cat>> fetchCats() async {
    final dbClient = await db;
    final resutl = await dbClient.query('cats');
    log('fetchCats: ${resutl.length}');
    return resutl.map((e) => Cat.fromMap(e)).toList();
  }

  Future<int> insertCat(Cat cat) async {
    final dbClient = await db;
    final rowAffected = await dbClient.insert('cats', cat.toMapInsert());
    log('insertCat: $rowAffected');
    return rowAffected;
  }

  Future<int> updateCat(Cat cat) async {
    final dbClient = await db;
    final rowAffected = await dbClient.update(
      'cats',
      cat.toMapUpdate(),
      where: 'id = ?',
      whereArgs: [cat.id],
    );
    log('updateCat: $rowAffected');
    return rowAffected;
  }

  Future<int> deleteCat(int id) async {
    final dbClient = await db;
    final rowAffected = await dbClient.delete(
      'cats',
      where: 'id = ?',
      whereArgs: [id],
    );
    log('deleteCat: $rowAffected');
    return rowAffected;
  }
}
