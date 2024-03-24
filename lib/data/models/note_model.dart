class NoteModel {
  final String title;
  final String content;
  final String dateTime;
  final String noteImage;

  NoteModel({
    required this.title,
    required this.content,
    required this.dateTime,
    required this.noteImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'dateTime': dateTime,
      'noteImage': noteImage,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      content: map['content'] as String,
      dateTime: map['dateTime'] as String,
      noteImage: map['noteImage'] as String,
    );
  }
}
