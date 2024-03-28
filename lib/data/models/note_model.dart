import 'package:flutter/foundation.dart' show immutable;

const String tasksTable = 'tasks';

class TasksFields {
  static final List<String> values = [
    id,
    title,
    content,
    dateTime,
    noteImage,
  ];

  // Column names for task tables
  static const id = 'id';
  static const title = 'title';
  static const content = 'content';
  static const dateTime = 'dateTime';
  static const noteImage = 'noteImage';
}

@immutable
class Task {
  final int? id;
  final String title;
  final String content;
  final String dateTime;
  final String noteImage;

  const Task({
    this.id,
    required this.title,
    required this.content,
    required this.dateTime,
    required this.noteImage,
  });

  Task copy({
    int? id,
    String? title,
    String? content,
    String? dateTime,
    String? noteImage,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        dateTime: dateTime ?? this.dateTime,
        noteImage: noteImage ?? this.noteImage,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TasksFields.id: id,
      TasksFields.title: title,
      TasksFields.content: content,
      TasksFields.dateTime: dateTime,
      TasksFields.noteImage: noteImage,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[TasksFields.id] != null ? map[TasksFields.id] as int : null,
      title: map[TasksFields.title] as String,
      content: map[TasksFields.content] as String,
      dateTime: map[TasksFields.dateTime] as String,
      noteImage: map[TasksFields.noteImage] as String,
    );
  }
}
