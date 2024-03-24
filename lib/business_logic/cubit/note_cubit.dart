import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_v2/data/models/note_model.dart';
import 'package:note_app_v2/data/repository/note_repo.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController editTitleController = TextEditingController();
  TextEditingController editContentController = TextEditingController();

  NoteRepo noteRepo = NoteRepo();
  List<NoteModel> noteList = [];

  void createDataBase() {
    noteRepo.createDataBase().then((value) => emit(NoteInitial()));
  }

  List<NoteModel> getData() {
    noteRepo.getData(noteList).then((value) => emit(NoteLoaded()));
    return noteList;
  }

  void insertData() {
    noteRepo
        .insertData(titleController.text, contentController.text,
            DateTime.now().toString(), '')
        .then((value) {
      emit(NoteLoaded());
      getData();
    });
  }

  void updateData(int id) {
    noteRepo
        .updateData(id, titleController.text, contentController.text,
            DateTime.now().toString(), '')
        .then((value) {
      emit(NoteLoaded());
      getData();
    });
  }

  void deleteData(int id) {
    noteRepo.deleteData(id).then((value) {
      emit(NoteLoaded());
      getData();
    });
  }
}
