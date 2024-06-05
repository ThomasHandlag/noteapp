import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noteapp/bloc/text_ai_bloc.dart';
import 'package:noteapp/models/note.dart';
import 'dart:developer' show log;

class NoteItem extends StatefulWidget {
  const NoteItem({
    super.key,
    required this.title,
    required this.index,
    required this.content,
    this.note,
    required this.onTap,
    required this.onSelectionChange,
    required this.selectionList,
    required this.selectionMode,
    required this.onChange,
  });
  final int index;
  final String title;
  final String content;
  final Note? note;
  final VoidCallback onTap;
  final VoidCallback onChange;
  final ValueChanged<bool> onSelectionChange;
  final bool selectionMode;
  final List<bool> selectionList;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late QuillController _controller;

  TextAIBloc textAIBloc = TextAIBloc();

  @override
  void initState() {
    _controller = QuillController(
        document: Document.fromJson(widget.note!.toJson()),
        selection: const TextSelection.collapsed(offset: 0));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getContent() {
    Note item = widget.note!;
    String outCont = "";
    String? content = item.content;
    final data = jsonDecode(content!);
    for (int i = 0; i < 3; i++) {
      outCont += data[i]["insert"];
      outCont += "\n";
    }
    outCont.substring(0, outCont.length ~/ 2);
    return outCont;
  }

  @override
  Widget build(BuildContext context) {
    getContent();
    return Card(
      color: const Color.fromARGB(255, 15, 21, 59),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
          onTap: widget.onTap,
          onLongPress: () {
            if (!widget.selectionMode) {
              setState(() {
                widget.selectionList[widget.index] = true;
              });
            }
            widget.onSelectionChange(true);
            widget.onChange();
          },
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                      Text(getContent(),
                          maxLines: 3, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  widget.selectionMode
                      ? Checkbox(
                          value: widget.selectionList[widget.index],
                          onChanged: (value) {
                            setState(() {
                              widget.selectionList[widget.index] = value!;
                              widget.onChange();
                            });
                          })
                      : Container()
                ],
              ))),
    );
  }
}
