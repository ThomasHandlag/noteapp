import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class TagEmbedd extends Embeddable {
  const TagEmbedd(
    String value,
  ) : super(tagType, value);

  static const String tagType = 'tag';

  static TagEmbedd fromDocument(Document document) =>
      TagEmbedd(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

enum Tags { primary, important, good, bad, todo, done, plan, doing }

class TagEmbeddBuilderWidget extends EmbedBuilder {
  @override
  String get key => 'tag';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  final List<Color> colors = [
    Colors.white70,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.brown,
    Colors.pink
  ];

  final List<Tags> tags = [
    Tags.primary,
    Tags.important,
    Tags.good,
    Tags.bad,
    Tags.todo,
    Tags.done,
    Tags.plan,
    Tags.doing
  ];

  final List<String> tagNames = [
    "Primary",
    "Important",
    "Good",
    "Bad",
    "Todo",
    "Done",
    "Plan",
    "Doing"
  ];

  int selectedIndex = 0;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: Theme.of(context).colorScheme.background),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                color: colors[selectedIndex]),
            child: Text(
              tagNames[selectedIndex],
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(5.0),
              child: Text(node.value.data as String,
                  style: TextStyle(color: Colors.blue, fontSize: 16.0)))
        ],
      ),
    );
  }
}
