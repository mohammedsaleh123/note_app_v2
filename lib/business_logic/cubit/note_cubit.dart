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
  TextEditingController editTitleController = TextEditingController();
  TextEditingController editContentController = TextEditingController();
  final Repository repository = Repository();
  List<Task> notes = [];
  String imageChoose = '';
  String imageTitle = '';
  String buttonTitle = 'Save';
  int index = 0;

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

  Future<void> createDatabase() async {
    await repository.createDatabase().then((value) => emit(NoteInitial()));
  }

  Future<List<Task>> getData() async {
    try {
      notes = await repository.getData();
      emit(NoteLoaded());
      return notes;
    } on Exception catch (e) {
      emit(NoteError());
      throw Exception(e.toString());
    }
  }

  Future<Task> getOneTask(int id) async {
    try {
      emit(NoteLoaded());
      return await repository.getOneTask(id);
    } on Exception catch (e) {
      emit(NoteError());
      throw Exception(e.toString());
    }
  }

  void insertData(String noteImage) async {
    try {
      await repository.insertData(Task(
          title: titleController.text,
          content: contentController.text,
          dateTime: DateTime.now().toString(),
          noteImage: noteImage));
      notes = await repository.getData();
      emit(NoteLoaded());
      getData();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void updateData(int id) async {
    index = id;
    try {
      await repository.updateData(
        id,
        Task(
            id: id,
            title: editTitleController.text,
            content: editContentController.text,
            dateTime: DateTime.now().toString(),
            noteImage: imageChoose),
      );
      //emit(NoteLoaded());
      notes = await repository.getData();
      getData();
    } on Exception catch (e) {
      emit(NoteError());
      throw Exception(e.toString());
    }
  }

  Future<void> deleteData(int id) async {
    try {
      await repository.deleteData(id);
      notes = await repository.getData();
      emit(NoteLoaded());
      getData();
    } on Exception catch (e) {
      emit(NoteError());
      throw Exception(e.toString());
    }
  }

  void chooseImage(int index) {
    imageChoose = notesImages[index];
    imageTitle = notesTitles[index];
    emit(NoteLoaded());
  }

  void clearText() {
    titleController.clear();
    contentController.clear();
    emit(NoteLoaded());
  }

  void taskToEdit(Task task) {
    editTitleController.text = task.title;
    editContentController.text = task.content;
    imageChoose = task.noteImage;
    buttonTitle = 'Update';
    emit(NoteLoaded());
  }

  // void navigatorToAdd() {
  //   buttonTitle = 'Save';
  //   emit(NoteLoaded());
  // }
}
