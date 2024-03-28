import 'package:note_app_v2/data/cache_services/database_service.dart';
import 'package:note_app_v2/data/models/note_model.dart';

class Repository {
  Future<void> createDatabase() async {
    await TasksDatabase.instance.database;
  }

  Future<void> insertData(Task task) async {
    try {
      await TasksDatabase.instance.createTask(task);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateData(int id, Task task) async {
    try {
      await TasksDatabase.instance.updateTask(task);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteData(int id) async {
    try {
      await TasksDatabase.instance.deleteTask(id);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Task> getOneTask(int id) async {
    try {
      return await TasksDatabase.instance.readTask(id);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Task>> getData() async {
    try {
      return await TasksDatabase.instance.readAllTasks();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
