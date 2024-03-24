import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/data/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Future<void> createDataBase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseTableName);

    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY, title TEXT,content TEXT,dateTime Text,noteImage TEXT)');
    });
  }

  Future<List<NoteModel>> getData() async {
    var db = await openDatabase(databaseTableName);
    return await db.rawQuery('SELECT * FROM Notes') as List<NoteModel>;
  }

  Future<void> insertData(
      String title, String content, String dateTime, String noteImage) async {
    var db = await openDatabase(databaseTableName);

    await db.rawInsert(
        'INSERT INTO Notes(title,subTitle,time,color) VALUES(?,?,?,?)',
        [title, content, dateTime, noteImage]);
    db.close();
  }

  Future<void> updateData(int id, Map<String, dynamic> noteData) async {
    var db = await openDatabase(databaseTableName);

    await db.update('Notes', noteData, where: 'id = ?', whereArgs: [id]);
    getData();
    db.close();
  }

  Future<void> deleteData(int id) async {
    var db = await openDatabase(databaseTableName);
    await db.rawDelete('DELETE FROM Notes WHERE id = ?', [id]);
    getData();
    db.close();
  }
}
