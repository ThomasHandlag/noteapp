import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteapp/bloc/note_bloc.dart';
import 'package:noteapp/components/note_item.dart';
import 'package:noteapp/layouts/mutation_screen.dart';
import 'package:noteapp/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' show log;

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NoteBloc noteBloc;

  bool _selectionMode = false;
  bool _selectAll = false;
  List<bool> selectionList = [];

  void onEditNote(Note? note) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
     return MutationScreen(
        note: note,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    noteBloc = NoteBloc();
    noteBloc.add(LoadNotes());
  }

  @override
  void dispose() {
    noteBloc.close();
    super.dispose();
  }

  int countSelected = 0;

  void countSelectedItem() {
    int number = 0;
    for (int i = 0; i < selectionList.length; i++) {
      if (selectionList[i]) {
        number++;
      }
    }
    setState(() {
      countSelected = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, List<Note>>(
        builder: (context, state) {
          for (int i = 0; i < state.length; i++) {
            selectionList.add(false);
          }
          return Column(
            children: [
              _selectionMode
                  ? Container(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _selectionMode = false;
                                });
                              },
                              icon: const Icon(Icons.close),
                              label: const Text("Cancel")),
                          TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outline),
                              label: Text(_selectionMode
                                  ? "Remove $countSelected item"
                                  : "Remove all")),
                          Row(
                            children: [
                              const Text("Select all"),
                              Checkbox(
                                  value: _selectAll,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectAll = value!;
                                    });
                                    setState(() {
                                      selectionList = List<bool>.generate(selectionList.length, (index) => value!);
                                    });
                                  })
                            ],
                          )
                        ],
                      ))
                  : Container(),
              Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      itemCount: noteBloc.state.length,
                      itemBuilder: (context, index) {
                        return NoteItem(
                          index: index,
                          onChange: () {
                            countSelectedItem();
                          },
                          selectionList: selectionList,
                          selectionMode: _selectionMode,
                          title: noteBloc.state.toList()[index].title ?? "",
                          content: noteBloc.state.toList()[index].content ?? "",
                          onSelectionChange: (value) {
                            setState(() {
                              _selectionMode = value;
                            });
                          },
                          onTap: () {
                            onEditNote(noteBloc.state.toList()[index]);
                          },
                          note: noteBloc.state.toList()[index],
                        );
                      }))
            ],
          );
        },
        bloc: noteBloc);
  }
}
