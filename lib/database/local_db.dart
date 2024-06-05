import 'package:noteapp/models/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteAppLocalDatabase {
  factory NoteAppLocalDatabase() => instance;
  NoteAppLocalDatabase.init(this._db);
  static late NoteAppLocalDatabase instance;

  final Database _db;

  Future<Note> insertNote(Note note) async {
    final id = await _db.insert('notes', note.toMap());
    return note.copyWith(id: id);
  }

  Future<Note> updateNote(Note note) async {
    await _db
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    return note;
  }

  Future<void> deleteNote(Note note) async {
    await _db.delete('notes', where: 'id = ?', whereArgs: [note.id]);
  }
}

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<Note> saveNote(Note note);
  Future<void> deleteNote(Note note);
}

class NotesLocalRepository implements NotesRepository {
  @override
  Future<List<Note>> getNotes() async {
    final maps = await NoteAppLocalDatabase()._db.query('notes');
    return maps.map((map) => Note.fromMap(map)).toList();
  }

  @override
  Future<void> deleteNote(Note note) {
    return NoteAppLocalDatabase().deleteNote(note);
  }

  @override
  Future<Note> saveNote(Note note) {
    return NoteAppLocalDatabase().insertNote(note);
  }
}
