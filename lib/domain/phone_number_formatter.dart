import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  int index = 4;

  String _replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String oldText = oldValue.text;
    if (newValue.text.length < oldValue.text.length) {
      if (index == 4) {
        return TextEditingValue(
          text: oldText,
          selection: TextSelection.collapsed(offset: index),
        );
      }
      index--;
      int deleteIndex = index;
      if (index == 8) {
        deleteIndex = 6;
        index = 6;
      }
      if (index == 12) {
        deleteIndex = 11;
        index = 11;
      }
      if (index == 15) {
        deleteIndex = 14;
        index = 14;
      }
      String text = _replaceCharAt(oldText, deleteIndex, '*');
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: index),
      );
    }
    if (index == 18) {
      return TextEditingValue(
        text: oldText,
        selection: TextSelection.collapsed(offset: index),
      );
    }
    int pos = index;
    index++;
    if (index == 7) {
      index = 9;
    }
    if (index == 12) {
      index = 13;
    }
    if (index == 15) {
      index = 16;
    }
    int selPos = pos;
    if (newValue.selection.baseOffset == 19) {
      selPos = 18;
    }
    String text = _replaceCharAt(oldText, pos, newValue.text[selPos]);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: index),
    );
  }
}