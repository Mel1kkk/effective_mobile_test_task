import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_tz/rick_and_morty/models/character.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cache.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE characters (
            id INTEGER PRIMARY KEY,
            name TEXT,
            status TEXT,
            species TEXT,
            image TEXT,
            page INTEGER
          )
        ''');
      },
    );
  }
  
  Future<void> saveCharacters(List<Character> characters, int page) async {
    final db = await database;
    final batch = db.batch();
    for (var char in characters) {
      batch.insert('characters', {
        'id': char.id,
        'name': char.name,
        'status': char.status,
        'species': char.species,
        'image': char.image,
        'page': page,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      if (kDebugMode) {
        debugPrint('🧠 Сохранён персонаж: ${char.name} | page: $page');
      }
    }
    await batch.commit(noResult: true);
  }


  /// Загружаем все кэшированные данные, отсортированные по странице и id.
  Future<List<Character>> loadCharacters() async {
    final db = await database;
    final maps = await db.query('characters', orderBy: "page ASC, id ASC");
    return maps.map((e) => Character.fromMap(e)).toList();
  }

  Future<void> clearCharacters() async {
    final db = await database;
    await db.delete('characters');
    if (kDebugMode) {
      debugPrint("🗑️ Кэш очищен");
    }
  }

}
