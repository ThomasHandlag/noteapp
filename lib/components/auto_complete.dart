import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AutoCompeleteBlockEmbeded extends CustomBlockEmbed {
  const AutoCompeleteBlockEmbeded(String data) : super(fieldType, data);

  static const String fieldType = 'auto';

  static AutoCompeleteBlockEmbeded fromDocument(Document document) =>
      AutoCompeleteBlockEmbeded(json.encode(document.toDelta().toJson()));

  Document get document => Document.fromJson(json.decode(data));
}
class AutoCompleteEmbedBuilder extends EmbedBuilder {
  AutoCompleteEmbedBuilder({required this.addEditNote});

  Future<void> Function(BuildContext context, {Document? document}) addEditNote;

  @override
  String get key => 'notes';

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final notes = AutoCompeleteBlockEmbeded(node.value.data).document;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          notes.toPlainText().replaceAll('\n', ' '),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        leading: const Icon(Icons.notes),
        onTap: () => addEditNote(context, document: notes),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}