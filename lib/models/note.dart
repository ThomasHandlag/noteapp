import 'package:equatable/equatable.dart';
import 'dart:convert' show json;

class Note extends Equatable {
  final int? id;
  final String? title;
  final String? content;
  final String? imgPath;
  final String? audioPath;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  const Note(
      {this.id,
      this.title,
      this.content,
      this.imgPath,
      this.audioPath,
      this.createdAt,
      this.modifiedAt});

  static const empty = Note();
  bool get isEmpty => this == Note.empty;

  set content(String? value) => content = value ?? content;

  set id(int? id) => id = id;

  set imgPath(String? value) => imgPath = value ?? imgPath;

  set audioPath(String? value) => audioPath = value ?? audioPath;

  set modifiedAt(DateTime? value) => modifiedAt = value;

  set createdAt(DateTime? value) => createdAt = value;

  @override
  List<Object?> get props => [id, title, content, createdAt, modifiedAt];

  @override
  String toString() => 'Note(id: $id, title: $title, content: $content)';

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  List toJson() {
    if (content != null) {
      return json.decode(content!);
    } else {
      return [];
    }
  }

  Map<String, Object?> toMap() {
    var map = {
      'title': title ?? "Unnamed",
      'content': content ?? "",
      'imagePath': imgPath ?? "",
      'audioPath': audioPath ?? "",
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'modifiedAt': modifiedAt?.millisecondsSinceEpoch,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Note.fromMap(Map<String, Object?> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String?,
      content: map['content'] as String?,
      imgPath: map['imagePath'] as String?,
      audioPath: map['audioPath'] as String?,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      modifiedAt: map['modifiedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['modifiedAt'] as int),
    );
  }
}
