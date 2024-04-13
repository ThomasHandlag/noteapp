import 'package:flutter/material.dart';
import 'package:noteapp/models/note.dart';
import 'package:flutter_quill/flutter_quill.dart';

class MutationScreen extends StatefulWidget {
  const MutationScreen({super.key, this.note});
  final Note? note;
  @override
  State<MutationScreen> createState() => _MutationScreenState();
}

class _MutationScreenState extends State<MutationScreen> {
  late QuillController _controller;

  String title = "Untitled";
  String content = "";

  bool _enableAI = true;

  @override
  void initState() {
    _controller = QuillController.basic();
    if (widget.note != null) {
      _controller = QuillController(
          document: Document.fromJson(widget.note!.toJson()),
          selection: const TextSelection.collapsed(offset: 0));
    }

    _controller.document.changes.listen((event) {
      setState(() {
        content = _controller.document.toDelta().toJson().toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/images/sl_bg.png'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        )),
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
                        onPressed: () {},
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
                          options: const QuillToolbarToggleStyleButtonOptions(),
                          controller: _controller,
                          attribute: Attribute.bold,
                        ),
                        QuillToolbarToggleStyleButton(
                          options: const QuillToolbarToggleStyleButtonOptions(),
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
                        QuillToolbarCustomButton(controller: _controller, options: QuillToolbarCustomButtonOptions(
                          icon: const Icon(Icons.auto_awesome),
                          onPressed: () { debugPrint("Pressed"); },
                        ),) 
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
                height: MediaQuery.of(context).size.height * 0.4,
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
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
