import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  final String _tableName = "expenses";

  DbService._();

  static final DbService _dbService = DbService._();

  factory DbService() => _dbService;
  Database? _database;

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $_tableName(
        category Text NOT NUll, 
        title TEXT NOT NULL,
        amount REAR,
        date TEXT NOT NULL
      )
    """);
  }

  Future<Database> _initialDatabase() async {
    final String dbPath = await getDatabasesPath();
    final path = "$dbPath/localDatabase.db";
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initialDatabase();
      return _database!;
    }
  }

  Future<List<Expanses>> getExpanses() async {
    final db = await database;
    final dbResponse = await db.rawQuery("SELECT * FROM $_tableName");
    List<Expanses> contacts = dbResponse.isNotEmpty
        ? dbResponse.map((e) => getExpanses.fromJson(e)).toList()
        : [];
    return contacts;
  }

  Future<void> addContact({
    required String title,
    required String phoneNumber,
  }) async {
    try {
      final db = await database;
      await db.insert(_tableName, {
        'title': title,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error while adding a contact: $e");
      }
    }
  }

  Future<void> deleteContact(int id) async {
    try {
      final db = await database;
      await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      if (kDebugMode) {
        print("Error while deleting contact: $e");
      }
    }
  }

  Future<void> editExpenses({
    required int id,
    required String newTitle,
    required String newPhone,
  }) async {
    try {
      final db = await database;
      await db.update(
        _tableName,
        {
          "title": newTitle,
          "phoneNumber": newPhone,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error while editing a contact: $e");
      }
    }
  }
}
