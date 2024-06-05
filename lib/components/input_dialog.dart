import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:developer' show log;

import 'package:noteapp/bloc/text_ai_bloc.dart';

class GenerateInputDialog extends StatefulWidget {
  const GenerateInputDialog({super.key, required this.textAIBloc});
  final TextAIBloc textAIBloc;
  // final VoidCallback callback;
  @override
  State<StatefulWidget> createState() => GenerateInputState();
}

class GenerateInputState extends State<GenerateInputDialog> {
  bool _isProcess = false;

  String _promptText = "";

  void generate() async {
    final model = Gemini.instance;
    log(_promptText);
    if (_promptText.isNotEmpty) {
     await model.text(_promptText).then((value) {
        widget.textAIBloc.add(GenerateEvent(value!.content!.parts!.last.text!));
        log(value.content!.parts!.last.text!);
        log("complete");
      }).catchError((error) {
        log(error.toString());
        log("error");
      }).whenComplete(() => setState(() {
            _isProcess = false;
            Navigator.pop(context);
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SearchBar(
        leading: const Icon(Icons.g_mobiledata),
        trailing: [
          _isProcess
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _isProcess = true;
                    });
                    generate();
                  },
                  icon: const Icon(Icons.arrow_circle_up))
        ],
        onChanged: (value) {
          setState(() {
            _promptText = value;
          });
        },
        hintText: "Type something",
      ),
    );
  }
}
