import 'package:flutter/material.dart';
import 'package:noteapp/components/note_item.dart';
import 'package:noteapp/models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onPress});

  final ValueChanged<Note?> onPress;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        padding: const EdgeInsets.all(10.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return NoteItem(
            title: "Note $index",
            content: "Content $index",
            onTap: () {
              widget.onPress(Note.empty);
            },
          );
        });
  }
}
