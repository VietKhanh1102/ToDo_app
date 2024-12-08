import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_login/model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._databaseHelper();
  static Database? _database;

  factory DatabaseHelper() => instance;

  DatabaseHelper._databaseHelper();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT NOT NULL,
          password TEXT NOT NULL,
          userName TEXT,
          city TEXT,
          phoneNumber TEXT, 
          imagePath TEXT
          )
          
          ''');
    });
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db
        .update('user', user.toMap(), where: 'id= ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
