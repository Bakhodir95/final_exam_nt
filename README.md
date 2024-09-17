# final_exam_nt
import 'package:db_sqfl/contact.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  final String _tableName = "contacts";

  DbService._();

  static final DbService _dbService = DbService._();

  factory DbService() => _dbService;
  Database? _database;

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT NOT NULL,
        phoneNumber TEXT NOT NULL   
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

  Future<List<Contact>> getContacts() async {
    final db = await database;
    final dbResponse = await db.rawQuery("SELECT * FROM $_tableName");
    List<Contact> contacts = dbResponse.isNotEmpty
        ? dbResponse.map((e) => Contact.fromJson(e)).toList()
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

  Future<void> editContact({
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

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Database Service
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tasks.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tasks');
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    return await db.insert('tasks', task);
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    final db = await database;
    return await db.update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}

Model
class Task {
  int? id;
  String title;
  bool isCompleted;

  Task({this.id, required this.title, this.isCompleted = false});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}

Event
abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final int id;
  DeleteTask(this.id);
}

import 'package:equatable/equatable.dart';
import '../models/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {}

State 

import 'package:equatable/equatable.dart';
import '../models/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}


class TaskError extends TaskState {}

Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';
import '../data/database_helper.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper databaseHelper;

  TaskBloc(this.databaseHelper) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasksData = await databaseHelper.getTasks();
        final tasks = tasksData.map((task) => Task.fromMap(task)).toList();
        emit(TaskLoaded(tasks));
      } catch (_) {
        emit(TaskError());
      }
    });

    on<AddTask>((event, emit) async {
      try {
        await databaseHelper.insertTask(event.task.toMap());
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        await databaseHelper.updateTask(event.task.toMap());
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await databaseHelper.deleteTask(event.id);
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });
  }
}
UI
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../models/task.dart';

class TasksPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      context.read<TaskBloc>().add(UpdateTask(Task(
                          id: task.id,
                          title: task.title,
                          isCompleted: value ?? false)));
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTask(task.id!));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Error loading tasks'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Task Title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final task = Task(title: _controller.text);
                context.read<TaskBloc>().add(AddTask(task));
                Navigator.pop(context);
                _controller.clear();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}

main
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/database_helper.dart';
import 'bloc/task_bloc.dart';
import 'pages/tasks_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sqflite BLoC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => TaskBloc(DatabaseHelper())..add(LoadTasks()),
        child: TasksPage(),
      ),
    );
  }
}
