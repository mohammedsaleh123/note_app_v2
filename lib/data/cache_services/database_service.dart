import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/data/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Future<void> createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseTableName);

    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY, title TEXT,content TEXT,dateTime Text,noteImage Text)');
    });
  }

  Future<void> insertData(
      String title, String content, String dateTime, String noteImage) async {
    var db = await openDatabase(databaseTableName);
    await db.rawInsert(
      'INSERT INTO Notes(title,content,dateTime,noteImage) VALUES(?,?,?,?)',
      [title, content, dateTime, noteImage],
    );
  }

  Future<void> updateData(int id, Map<String, dynamic> noteData) async {
    var db = await openDatabase(databaseTableName);
    await db.update('Notes', noteData, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteData(int id) async {
    var db = await openDatabase(databaseTableName);
    await db.rawDelete('DELETE FROM Notes WHERE id = ?', [id]);
  }

  Future<List<NoteModel>> getData() async {
    var db = await openDatabase(databaseTableName);
    List<Map<String, dynamic>> maps = await db.query(databaseTableName);
    return List.generate(maps.length, (i) {
      return NoteModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        dateTime: maps[i]['dateTime'],
        noteImage: maps[i]['noteImage'],
      );
    });
  }
}
