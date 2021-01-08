import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextBox extends StatefulWidget {
  TextBox(
      {@required this.length,
      @required this.boxSize,
      this.onNoEmptyField,
      this.onTextIsEmpty});

  final int length;
  final double boxSize;
  final Function(String) onNoEmptyField;
  final Function() onTextIsEmpty;

  @override
  State<StatefulWidget> createState() {
    return _TextBoxState();
  }
}

class _TextBoxState extends State<TextBox> {
  List<String> strings;

  @override
  void initState() {
    super.initState();
    strings = List(widget.length);
    for (int i = 0; i < widget.length; i++) {
      strings[i] = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Container> boxes = List();
    List<FocusNode> focusNodes = List();
    for (int i = 0; i < widget.length; i++) {
      TextEditingController controller = new TextEditingController();
      controller.text = strings[i];
      setCursorToEnd(controller);
      FocusNode focusNode = FocusNode();
      focusNodes.add(focusNode);
      final box = Container(
        height: widget.boxSize,
        width: widget.boxSize,
        child: TextField(
          focusNode: focusNode,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(fontSize: widget.boxSize - 5, wordSpacing: 0),
          autocorrect: false,
          enableSuggestions: false,
          showCursor: false,
          toolbarOptions: ToolbarOptions(),
          controller: controller,
          onChanged: (text) {
            move(text, i, focusNodes);
            strings[i] = text;
            setCursorToEnd(controller);
            checkEmptyText(strings);
            onLastBoxNotEmpty(text, i, focusNodes);
          },
          onTap: () => setCursorToEnd(controller),
          onEditingComplete: () => focusNodes[i].unfocus(),
          inputFormatters: [
            OneCharTextFormatter(),
            UpperCaseTextFormatter(),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(),
          ),
        ),
      );

      boxes.add(box);
    }

    return Row(
      children: boxes,
      mainAxisSize: MainAxisSize.min,
    );
  }

  void onLastBoxNotEmpty(
      String text, int currentIndex, List<FocusNode> focusNodes) {
    if (currentIndex == focusNodes.length - 1 && text.isNotEmpty) {
      focusNodes.last.unfocus();
    }
  }

  void checkEmptyText(List<String> strings) {
    var loesungswort = "";
    for (var string in strings) {
      if (string.isEmpty) {
        widget.onTextIsEmpty();
        return;
      }
      loesungswort += string;
    }
    widget.onNoEmptyField(loesungswort.toLowerCase());
  }

  void setCursorToEnd(TextEditingController controller) {
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  void move(String text, int currentIndex, List<FocusNode> focusNodes) {
    if (text.isNotEmpty && currentIndex < widget.length - 1) {
      FocusNode currentFocus = focusNodes[currentIndex + 1];
      currentFocus.requestFocus();
    }
  }
}

class OneCharTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty || oldValue.text.isEmpty) {
      return newValue;
    }
    return TextEditingValue(
      text: newValue.text.substring(newValue.text.length - 1),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
