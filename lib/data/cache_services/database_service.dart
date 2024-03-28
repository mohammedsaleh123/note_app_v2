import 'package:flutter/foundation.dart' show immutable;
import 'package:note_app_v2/data/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@immutable
class TasksDatabase {
  static const String _databaseName = 'tasks.db';
  static const int _databaseVersion = 1;

  const TasksDatabase._privateConstructor();
  static const TasksDatabase instance = TasksDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDB,
    );
  }

  Future _createDB(
    Database db,
    int version,
  ) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $tasksTable(
        ${TasksFields.id} $idType,
        ${TasksFields.title} $textType,
        ${TasksFields.content} $textType,
        ${TasksFields.dateTime} $textType,
        ${TasksFields.noteImage} $textType)
      """);
  }

  Future<Task> createTask(Task task) async {
    final db = await instance.database;
    final id = await db.insert(
      tasksTable,
      task.toMap(),
    );

    return task.copy(id: id);
  }

  Future<Task> readTask(int id) async {
    final db = await instance.database;

    final taskData = await db.query(
      tasksTable,
      columns: TasksFields.values,
      where: '${TasksFields.id} = ?',
      whereArgs: [id],
    );

    if (taskData.isNotEmpty) {
      return Task.fromMap(taskData.first);
    } else {
      throw Exception('Could not find a task with the given ID');
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;

    final result = await db.query(tasksTable);

    return result.map((taskData) => Task.fromMap(taskData)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;

    return await db.update(
      tasksTable,
      task.toMap(),
      where: '${TasksFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> markTaskAsCompleted({
    required int id,
    required Task task,
  }) async {
    final db = await instance.database;

    return await db.update(
      tasksTable,
      task.toMap(),
      where: '${TasksFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;

    return await db.delete(
      tasksTable,
      where: '${TasksFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
