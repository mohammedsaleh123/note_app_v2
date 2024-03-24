import 'package:note_app_v2/data/cache_services/database_service.dart';
import 'package:note_app_v2/data/models/note_model.dart';

class NoteRepo {
  DatabaseService databaseService = DatabaseService();

  Future<void> createDataBase() async {
    try {
      await databaseService.createDataBase();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<NoteModel>> getData(List<NoteModel> noteList) async {
    try {
      await databaseService.getData().then((value) => noteList.addAll(value));
      return noteList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> insertData(
      String title, String content, String dateTime, String noteImage) async {
    try {
      await databaseService.insertData(title, content, dateTime, noteImage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateData(int id, String title, String content, String dateTime,
      String noteImage) async {
    try {
      Map<String, dynamic> noteData = NoteModel(
              title: title,
              content: content,
              dateTime: dateTime,
              noteImage: noteImage)
          .toMap();
      await databaseService.updateData(id, noteData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteData(int id) async {
    try {
      await databaseService.deleteData(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
