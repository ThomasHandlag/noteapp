import 'dart:convert';

class Note {
  String? title;
  String? content;
  String? imgPath;
  String? audioPath;
  Note({this.title, this.content, this.imgPath, this.audioPath});

  static final empty = Note();
  bool get isEmpty => this == Note.empty;

  List toJson() {
    if (content != null) {
      return json.decode(content!);
    } else {
      return [];
    }
  }
}
