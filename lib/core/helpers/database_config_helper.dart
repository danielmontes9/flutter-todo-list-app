import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConfigHelper {
  static final DatabaseConfigHelper _instance =
      DatabaseConfigHelper._internal();
  static Database? _database;

  factory DatabaseConfigHelper() {
    return _instance;
  }

  DatabaseConfigHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'config.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE config (
            dark_mode BOOLEAN,
            language TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertConfig(String theme, String language) async {
    final db = await database;

    Map<String, dynamic> configMapped = {
      'dark_mode': theme,
      'language': language,
    };

    return await db.insert('config', configMapped);
  }

  Future<Map<String, dynamic>?> getConfig() async {
    final db = await database;

    List<Map<String, dynamic>> result = await db.query('config');
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> updateConfig(String theme, String language) async {
    final db = await database;

    Map<String, dynamic> configMapped = {
      'dark_mode': theme,
      'language': language,
    };

    return await db.update('config', configMapped);
  }
}
