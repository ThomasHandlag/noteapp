import 'dart:io';
import 'dart:convert' show jsonEncode;
import 'package:flutter/material.dart';
import 'package:noteapp/bloc/note_bloc.dart';
import 'package:noteapp/bloc/text_ai_bloc.dart';
import 'package:noteapp/components/auto_complete.dart';
import 'package:noteapp/components/tag_embed.dart';
import 'package:noteapp/models/note.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:developer' show log;

class MutationScreen extends StatefulWidget {
  const MutationScreen({super.key, this.note});
  final Note? note;

  @override
  State<MutationScreen> createState() => _MutationScreenState();
}

class _MutationScreenState extends State<MutationScreen> {
  late QuillController _controller;
  late TextAIBloc textAIBloc;
  String title = "Untitled";
  String content = "";

  final NoteBloc noteBloc = NoteBloc();

  bool isOnSaving = false;

  @override
  void initState() {
    textAIBloc = TextAIBloc();
    _controller = QuillController.basic();
    if (widget.note != null) {
      _controller = QuillController(
          document: Document.fromJson(widget.note!.toJson()),
          selection: const TextSelection.collapsed(offset: 0));
      title = widget.note!.title ?? "";
      content = widget.note!.content ?? "";
    }

    _controller.document.changes.listen((event) {
      setState(() {
        content =
            jsonEncode(_controller.document.toDelta().toJson()).toString();
      });
    });
    super.initState();
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          padding: const EdgeInsets.all(1.0),
          alignment: Alignment.center,
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saved!",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.check)
              ])),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * 0.5,
      backgroundColor: const Color.fromARGB(255, 23, 233, 30),
    ));
  }

  void onNewNote() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 150,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromARGB(215, 46, 40, 59),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Name your note"),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        controller: TextEditingController(text: title),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: isOnSaving,
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                noteBloc.add(AddNote(
                                    Note(title: title, content: content)));
                                setState(() {
                                  isOnSaving = true;
                                });

                                sleep(const Duration(seconds: 1));
                                if (isOnSaving) {
                                  isOnSaving = false;
                                  sleep(const Duration(milliseconds: 100));
                                  Navigator.of(context).pop();
                                }
                                showSnackbar();
                              },
                              child: const Text("Accept"))
                        ],
                      )
                    ],
                  )));
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    textAIBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: const AssetImage('assets/images/sl_bg.png'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
          )),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Theme.of(context).colorScheme.background,
                  alignment: Alignment.bottomCenter,
                  height: kToolbarHeight * 1.5,
                  child: Row(
                    children: [
                      const Text(
                        "Editor",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          tooltip: "Cancel",
                          icon: const Icon(Icons.close)),
                      IconButton(
                          tooltip: "Save",
                          onPressed: () {
                            if (widget.note != null) {
                              showSnackbar();
                              return;
                            }
                            onNewNote();
                          },
                          icon: const Icon(Icons.check)),
                    ],
                  )),
              Container(
                  color: Theme.of(context).colorScheme.background,
                  child: QuillToolbar(
                    configurations: const QuillToolbarConfigurations(
                      buttonOptions: QuillSimpleToolbarButtonOptions(
                        base: QuillToolbarBaseButtonOptions(
                          iconSize: 20,
                          iconButtonFactor: 1.4,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          QuillToolbarHistoryButton(
                            isUndo: true,
                            controller: _controller,
                          ),
                          QuillToolbarHistoryButton(
                            isUndo: false,
                            controller: _controller,
                          ),
                          QuillToolbarToggleStyleButton(
                            options:
                                const QuillToolbarToggleStyleButtonOptions(),
                            controller: _controller,
                            attribute: Attribute.bold,
                          ),
                          QuillToolbarToggleStyleButton(
                            options:
                                const QuillToolbarToggleStyleButtonOptions(),
                            controller: _controller,
                            attribute: Attribute.italic,
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.underline,
                          ),
                          QuillToolbarClearFormatButton(
                            controller: _controller,
                          ),
                          const VerticalDivider(),
                          QuillToolbarColorButton(
                            controller: _controller,
                            isBackground: false,
                          ),
                          const VerticalDivider(),
                          QuillToolbarFontFamilyButton(controller: _controller),
                          QuillToolbarColorButton(
                            controller: _controller,
                            isBackground: true,
                          ),
                          const VerticalDivider(),
                          QuillToolbarToggleCheckListButton(
                            controller: _controller,
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.ol,
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.ul,
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.inlineCode,
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.blockQuote,
                          ),
                          QuillToolbarIndentButton(
                            controller: _controller,
                            isIncrease: true,
                          ),
                          QuillToolbarIndentButton(
                            controller: _controller,
                            isIncrease: false,
                          ),
                          const VerticalDivider(),
                          QuillToolbarLinkStyleButton(controller: _controller),
                          QuillToolbarCustomButton(
                            controller: _controller,
                            options: QuillToolbarCustomButtonOptions(
                              icon: const Icon(Icons.auto_awesome),
                              onPressed: () {
                                _controller.document.insert(
                                  _controller.selection.extentOffset,
                                  const AICompleteBlockEmbeded(""),
                                );

                                _controller.updateSelection(
                                  TextSelection.collapsed(
                                    offset:
                                        _controller.selection.extentOffset + 2,
                                  ),
                                  ChangeSource.local,
                                );

                                _controller.document.insert(
                                    _controller.selection.extentOffset, '\n');

                                _controller.updateSelection(
                                  TextSelection.collapsed(
                                    offset:
                                        _controller.selection.extentOffset + 1,
                                  ),
                                  ChangeSource.local,
                                );
                              },
                            ),
                          ),
                          QuillToolbarCustomButton(
                            controller: _controller,
                            options: QuillToolbarCustomButtonOptions(
                                icon: const Icon(Icons.tag),
                                tooltip: "Tag",
                                onPressed: () {
                                  _controller.document.insert(
                                      _controller.selection.extentOffset, '\n');
                                  _controller.document.insert(
                                    _controller.selection.extentOffset,
                                    const TagEmbedd(
                                      "Complete Block",
                                    ),
                                  );

                                  _controller.updateSelection(
                                    TextSelection.collapsed(
                                      offset:
                                          _controller.selection.extentOffset +
                                              1,
                                    ),
                                    ChangeSource.local,
                                  );

                                  _controller.document.insert(
                                      _controller.selection.extentOffset, '\n');

                                  _controller.updateSelection(
                                    TextSelection.collapsed(
                                      offset:
                                          _controller.selection.extentOffset +
                                              1,
                                    ),
                                    ChangeSource.local,
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                        controller: _controller,
                        placeholder: "Start here",
                        customStyles: const DefaultStyles(
                          paragraph: DefaultTextBlockStyle(
                              TextStyle(color: Colors.white),
                              VerticalSpacing(1.0, 1.0),
                              VerticalSpacing(1.0, 1.0),
                              BoxDecoration(color: Colors.transparent)),
                        ),
                        embedBuilders: [
                          AICompleteEmbedBuilderWidget(textAIBloc),
                          TagEmbeddBuilderWidget()
                        ]),
                  ),
                ),
              )
            ],
          ))),
    );
  }
}
