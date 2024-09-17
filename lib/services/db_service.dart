import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_exam_nt/models/expense.dart';

class DbService {
  final String _tableName = "expenses";

  DbService._();

  static final DbService _dbService = DbService._();

  factory DbService() => _dbService;
  Database? _database;

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NUll, 
        title TEXT NOT NULL,
        amount REAR,
        date TEXT NOT NULL,
        comment TEXT NOT NULL
      )
    """);
  }

  Future<Database> _initialDatabase() async {
    final String dbPath = await getDatabasesPath();
    final path = "$dbPath/localDatabase.db";
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  // Future<Database> get database async {
  //   if (_database != null) {
  //     print("salom");

  //     return _database!;
  //   } else {
  //     _database = await _initialDatabase();
  //     return _database!;
  //   }
  // }

  // Future<List<Expenses>> getExpanses() async {
  //   final db = await database;
  //   final dbResponse = await db.rawQuery("SELECT * FROM $_tableName");
  //   List<Expenses> expanses = dbResponse.isNotEmpty
  //       ? dbResponse.map((e) => Expenses.fromMap(e)).toList()
  //       : [];
  //   return expanses;
  // }

  // Future<void> addExpenses({required Expenses expanses}) async {
  //   try {
  //     final db = await database;
  //     await db.insert(_tableName, {
  //       'category': expanses.category,
  //       'amount': expanses.amount,
  //       'date': expanses.date,
  //       'comment': expanses.comment,
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error while adding a contact: $e");
  //     }
  //   }
  // }
}
