import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noteapp/bloc/text_ai_bloc.dart';
import 'dart:developer' show log;

import 'package:noteapp/components/input_dialog.dart';

class AICompleteBlockEmbeded extends Embeddable {
  const AICompleteBlockEmbeded(
    String value,
  ) : super(aiblock, value);

  static const String aiblock = 'aiblock';

  static AICompleteBlockEmbeded fromDocument(Document document) =>
      AICompleteBlockEmbeded(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class AICompleteEmbedBuilderWidget extends EmbedBuilder {
  AICompleteEmbedBuilderWidget(this.textBloc) : super();

  TextAIBloc textBloc;

  @override
  String get key => 'aiblock';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return AIChat(textBloc: textBloc);
  }
}

class AIChat extends StatefulWidget {
  const AIChat({super.key, required this.textBloc});
  final TextAIBloc textBloc;
  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
  void showPrompt() {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            GenerateInputDialog(textAIBloc: _textAIBloc));
  }

  late TextAIBloc _textAIBloc;
  @override
  void initState() {
    super.initState();
    _textAIBloc = TextAIBloc();
  }

  @override
  void dispose() {
    _textAIBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextAIBloc, String>(
      builder: (blocContext, state) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 300,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Theme.of(context).colorScheme.background),
          child: Stack(children: [Text(state),
          InkWell(
            onTap: () {
              showPrompt();
            },
          )]),
        );
      },
      bloc: _textAIBloc,
    );
  }
}
