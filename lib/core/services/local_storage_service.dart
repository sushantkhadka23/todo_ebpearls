import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/data/models/task_model.dart';
import 'package:todo_ebpearls/core/constants/app_constants.dart';

class LocalStorageService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), AppConstants.dbName);
    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${AppConstants.tableName} (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            isCompleted INTEGER NOT NULL,
            createdAt TEXT NOT NULL,
            dueDate TEXT,
            priority TEXT NOT NULL
          )
        ''');
      },
    );
  }

  TaskModel _toTaskModel(Task task) => TaskModel.fromDomain(task);
  Task _toTask(TaskModel taskModel) => taskModel.toDomain();

  // add new task
  Future<void> addTask(Task task) async {
    final db = await database;
    final taskModel = _toTaskModel(task);
    await db.insert(AppConstants.tableName, taskModel.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // update a task
  Future<void> updateTask(Task task) async {
    final db = await database;
    final taskModel = _toTaskModel(task);
    await db.update(AppConstants.tableName, taskModel.toJson(), where: 'id = ?', whereArgs: [task.id]);
  }

  // delete a task
  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(AppConstants.tableName, where: 'id = ?', whereArgs: [id]);
  }

  // get all tasks
  Future<List<Task>> getTasks({bool sortByDueDate = false}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.tableName,
      orderBy: sortByDueDate ? 'dueDate ASC' : null,
    );
    return maps.map((map) => _toTask(TaskModel.fromJson(map))).toList();
  }

  // get single tasl
  Future<Task?> getTaskById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(AppConstants.tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TaskModel.fromJson(maps.first).toDomain();
    } else {
      return null;
    }
  }

  // toggle task completion
  Future<void> toggleTaskCompletion(String id, bool isCompleted) async {
    final db = await database;
    await db.update(AppConstants.tableName, {'isCompleted': isCompleted ? 1 : 0}, where: 'id = ?', whereArgs: [id]);
  }

  // close the database connection
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // delete whole db
  Future<void> deleteDb() async {
    final path = join(await getDatabasesPath(), AppConstants.dbName);
    await closeDatabase();
    await deleteDatabase(path);
  }
}
