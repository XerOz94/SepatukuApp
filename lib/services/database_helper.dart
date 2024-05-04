import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final tableName = 'favorites';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'favorites_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, name TEXT, image TEXT, description TEXT, price TEXT, merk TEXT, rilis TEXT, material TEXT, shop TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertFavorite(Map<String, dynamic> favorite) async {
    final Database db = await database;
    await db.insert(
      tableName,
      favorite,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteFavorite(int id) async {
    final Database db = await database;
    await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final Database db = await database;
    return db.query(tableName);
  }

  static Future<Map<String, dynamic>?> getFavoriteById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  static Future<bool> isFavorite(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return results.isNotEmpty;
  }

  // tambahkan metode lain sesuai kebutuhan, seperti menghapus item favorit
}
