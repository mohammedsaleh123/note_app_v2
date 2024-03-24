class NoteModel {
  final int id;
  final String title;
  final String content;
  final String dateTime;
  final String noteImage;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.dateTime,
    required this.noteImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime,
      'noteImage': noteImage,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      title: map['title'],
      content: map['content'],
      dateTime: map['dateTime'],
      noteImage: map['noteImage'],
    );
  }
}
