import 'package:bloc/bloc.dart';
import 'dart:developer' as dev;

sealed class GenerateTextEvent {
  const GenerateTextEvent();
}

final class GenerateEvent extends GenerateTextEvent {
  const GenerateEvent(this.text);
  final String text;
}

class TextAIBloc extends Bloc<GenerateEvent, String> {
  TextAIBloc() : super('') {
    on<GenerateEvent>((event, emit) {
      emit(event.text);
    });
  }
}

