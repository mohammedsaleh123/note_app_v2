import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/data/models/note_model.dart';
import 'package:note_app_v2/data/repository/note_repo.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final Repository repository = Repository();
  List<NoteModel> notes = [];
  String imageChoose = '';
  String imageTitle = '';

  @override
  void onChange(Change<NoteState> change) {
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  // @override
  // Future<void> close() {
  //   return super.close();
  // }

  void createDatabase() {
    try {
      repository.createDatabase().then((value) => emit(NoteInitial()));
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void getData() async {
    try {
      notes = await repository.getData();
      emit(NoteLoaded());
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void insertData(String noteImage) async {
    try {
      await repository.insertData(titleController.text, contentController.text,
          DateTime.now().toString(), noteImage);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void updateData(int id, Map<String, dynamic> noteData) async {
    try {
      await repository.updateData(id, noteData);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void deleteData(int id) async {
    try {
      await repository.deleteData(id);
      getData();
      emit(NoteLoaded());
      notes = notes.where((note) => note.id != id).toList();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void chooseImage(int? index) {
    imageChoose = notesImages[index!];
    imageTitle = notesTitles[index];
    emit(NoteLoaded());
  }
}
