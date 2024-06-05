import 'package:bloc/bloc.dart';
import 'package:noteapp/database/local_db.dart';
import 'package:noteapp/models/note.dart';

abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final Note note;
  AddNote(this.note);
}

class DeleteNote extends NotesEvent {
  final Note note;
  DeleteNote(this.note);
}

class UpdateNote extends NotesEvent {
  final Note note;
  UpdateNote(this.note);
}

class NoteBloc extends Bloc<NotesEvent, List<Note>> {
  NoteBloc() : super([]) {
    on<LoadNotes>((event, emit) async {
      emit(await NotesLocalRepository().getNotes());
    });
    on<AddNote>((event, emit) async {
      await NoteAppLocalDatabase().insertNote(event.note);
      emit(await NotesLocalRepository().getNotes());
    });
    on<DeleteNote>((event, emit) async {
      await NoteAppLocalDatabase().deleteNote(event.note);
      emit(await NotesLocalRepository().getNotes());
    });
    on<UpdateNote>((event, emit) async {
      await NoteAppLocalDatabase().updateNote(event.note);
      emit(await NotesLocalRepository().getNotes());
    });
  }
}
