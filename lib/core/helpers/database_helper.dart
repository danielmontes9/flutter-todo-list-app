import 'package:flutter_todo_list_app/core/helpers/database_factory.dart';
import 'package:flutter_todo_list_app/features/todo/data/classes/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    print("HI! IAM HERE!");
    return await getDatabaseFactory().openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) {
          return db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            due_date TEXT,
            status TEXT
          )
        ''');
        },
      ),
    );
  }

  Future<int> insertTask(Todo task) async {
    final db = await database;

    Map<String, dynamic> taskMapped = {
      'title': task.title,
      'description': task.description,
      'due_date': task.dueDate,
      'status': task.status.toString(),
    };

    return await db.insert('tasks', taskMapped);
  }

  Future<List<Todo>> getTasks(
    String statusSelected,
    String? orderBySelected,
  ) async {
    final db = await database;

    if (statusSelected == 'pending') {
      List<Todo> tasks = await db
          .query(
            'tasks',
            where: 'status = ?',
            whereArgs: [statusSelected],
            orderBy: orderBySelected ?? orderBySelected,
          )
          .then((value) {
            return value.map((e) => Todo.fromMap(e)).toList();
          });
      return tasks;
    }

    if (statusSelected == 'completed') {
      List<Todo> tasks = await db
          .query(
            'tasks',
            where: 'status = ?',
            whereArgs: [statusSelected],
            orderBy: orderBySelected ?? orderBySelected,
          )
          .then((value) {
            return value.map((e) => Todo.fromMap(e)).toList();
          });
      return tasks;
    }

    if (statusSelected == 'archived') {
      List<Todo> tasks = await db
          .query('tasks', where: 'status = ?', whereArgs: [statusSelected])
          .then((value) {
            return value.map((e) => Todo.fromMap(e)).toList();
          });
      return tasks;
    }

    if (statusSelected == 'all') {
      List<Todo> tasks = await db.query('tasks').then((value) {
        return value.map((e) => Todo.fromMap(e)).toList();
      });
      return tasks;
    }

    return List<Todo>.empty();
  }

  Future<Todo?> getTaskById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteTask(String id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTask(Todo task) async {
    final db = await database;

    Map<String, dynamic> taskMapped = {
      'title': task.title,
      'description': task.description,
      'due_date': task.dueDate,
      'status': task.status.toString(),
    };

    return await db.update(
      'tasks',
      taskMapped,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
