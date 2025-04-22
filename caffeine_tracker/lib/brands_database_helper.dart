import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class BrandsDatabaseHelper {
  static final BrandsDatabaseHelper instance = BrandsDatabaseHelper._internal();
  factory BrandsDatabaseHelper() => instance;
  BrandsDatabaseHelper._internal();

  static Database? _db;

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'brands_tracker.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<Database> get database async {
    return _db ??= await _initDB();
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE brands (
    uuid TEXT PRIMARY KEY,
    name TEXT,
    logo TEXT,
    )
    ''');
  }

  Future<void> deleteAllBrands() async {
    final db = await database;
    await db.delete("brands");
  }

  Future<void> insertBrand(String name, String logo) async {
    final db = await database;
    final uuid = const Uuid().v4();

    await db.insert('brands', {'uuid': uuid, 'name': name, 'logo': logo});
  }

  Future<void> updateBrand(String id, String name, String logo) async {
    final db = await database;

    await db.update(
      'brands',
      {'name': name, 'logo': logo},
      where: 'uuid=?',
      whereArgs: [id],
    );
  }

  Future<void> deleteBrand(id) async {
    final db = await database;
    await db.delete('brands', where: 'uuid=?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllBrands() async {
    final db = await database;
    final path = join(await getDatabasesPath(), 'brands_tracker.db');
    print('DB Path: $path');
    return await db.query('brands');
  }
}
