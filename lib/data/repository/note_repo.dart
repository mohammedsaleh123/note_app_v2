import 'package:note_app_v2/data/cache_services/database_service.dart';
import 'package:note_app_v2/data/models/note_model.dart';

DatabaseService databaseService = DatabaseService();

class Repository {
  Future<void> createDatabase() async {
    try {
      await databaseService.createDatabase();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> insertData(
      String title, String content, String dateTime, String noteImage) async {
    try {
      await databaseService.insertData(title, content, dateTime, noteImage);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateData(int id, Map<String, dynamic> noteData) async {
    try {
      await databaseService.updateData(id, noteData);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteData(int id) async {
    try {
      await databaseService.deleteData(id);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<NoteModel>> getData() async {
    try {
      return await databaseService.getData();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
