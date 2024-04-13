import 'package:flutter/material.dart';
import 'package:noteapp/models/note.dart';

class NoteItem extends StatefulWidget {
  const NoteItem(
      {super.key,
      required this.title,
      required this.content,
      this.note,
      required this.onTap});
  final String title;
  final String content;
  final Note? note;
  final VoidCallback onTap;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(155, 65, 61, 99),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
          onTap: widget.onTap,
          onLongPress: () {
            setState(() {
              isCheck = true;
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Column(
            children: [
              Text(widget.title),
              Text(widget.content),
            ],
          )),
    );
  }
}
