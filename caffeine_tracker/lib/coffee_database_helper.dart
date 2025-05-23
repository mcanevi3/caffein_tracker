import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class CoffeeDatabaseHelper {
  static final CoffeeDatabaseHelper instance = CoffeeDatabaseHelper._internal();
  factory CoffeeDatabaseHelper() => instance;
  CoffeeDatabaseHelper._internal();

  static Database? _db;

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'caffeine_tracker.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<Database> get database async {
    return _db ??= await _initDB();
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE coffees (
    uuid TEXT PRIMARY KEY,
    name TEXT,
    brand TEXT,
    caffeine INTEGER
    )
    ''');
  }

  Future<void> deleteAllCoffees() async {
    final db = await database;
    await db.delete("coffees");
    // final dbPath = await getDatabasesPath();
    // final path = join(dbPath, 'caffeine_tracker.db');

    // await deleteDatabase(path);
    // await _initDB();
  }

  Future<void> insertCoffee(String name, String brand, int caffeine) async {
    final db = await database;
    final uuid = const Uuid().v4();

    await db.insert('coffees', {
      'uuid': uuid,
      'name': name,
      'brand': brand,
      'caffeine': caffeine,
    });
  }

  Future<void> updateCoffee(
    String id,
    String name,
    String brand,
    int caffeine,
  ) async {
    final db = await database;

    await db.update(
      'coffees',
      {'name': name, 'brand': brand, 'caffeine': caffeine},
      where: 'uuid=?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCoffee(id) async {
    final db = await database;
    await db.delete('coffees', where: 'uuid=?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllCoffees() async {
    final db = await database;
    final path = join(await getDatabasesPath(), 'caffeine_tracker.db');
    print('DB Path: $path');
    return await db.query('coffees');
  }
}
