import 'package:flutter/cupertino.dart';

import 'utils/calculator.dart';
import 'utils/elem.dart';

class HomePageViewModel extends ChangeNotifier {
  String mem = '';
  String _memVal = '0';
  String answer = '';

  TextEditingController textEditingController = TextEditingController();

  memOp(String string) {
    String operation = textEditingController.text;
    switch (string) {
      case 'mc':
        mem = '';
        _memVal = '0';
        break;
      case 'm+':
        if (answer.isNotEmpty) {
          mem = 'M';
          _memVal = Calculator.eval(_memVal + '+' + answer).toString();
        } else if (operation.isNotEmpty) {
          mem = 'M';
          _memVal = Calculator.eval(_memVal + '+' + operation).toString();
        }
        break;
      case 'm−':
        if (answer.isNotEmpty) {
          mem = 'M';
          _memVal = Calculator.eval(_memVal + '−' + answer).toString();
        } else if (operation.isNotEmpty) {
          mem = 'M';
          _memVal = Calculator.eval(_memVal + '−' + operation).toString();
        }
        break;
      case 'mr':
        if (mem.isNotEmpty) {
          textEditingController.text = _memVal;
          textEditingController.selection = TextSelection(
              baseOffset: _memVal.length, extentOffset: _memVal.length);
        }
        break;
    }
    _result();
  }

  append(String curr) {
    int pos = textEditingController.selection.start;
    String operation = textEditingController.text;
    // scrollController.jumpTo(operation.length / 10);
    if (operation.isEmpty) {
      if (Elem.isNumber(curr)) {
        operation = curr;
        pos++;
      }
    } else {
      String prev = operation[pos - 1];
      if (!Elem.isPercent(prev) && Elem.isOperand(prev)) {
        if (!Elem.isPercent(curr) && Elem.isOperand(curr)) {
          if (Elem.isSub(curr) && (Elem.isMul(prev) || Elem.isDiv(prev))) {
            operation = operation.replaceRange(pos, pos, curr);
            pos++;
          } else {
            operation = operation.replaceRange(pos - 1, pos, curr);
          }
        } else {
          operation = operation.replaceRange(pos, pos, curr);
          pos++;
        }
      } else {
        operation = operation.replaceRange(pos, pos, curr);
        pos++;
      }
    }

    textEditingController.text = operation;
    textEditingController.selection =
        TextSelection(baseOffset: pos, extentOffset: pos);
    _result();
  }

  backspace() {
    int pos = textEditingController.selection.start;
    if (pos > 0) {
      textEditingController.text =
          textEditingController.text.replaceRange(pos - 1, pos, '');
      pos--;
    }
    textEditingController.selection =
        TextSelection(baseOffset: pos, extentOffset: pos);
    _result();
  }

  showResult() {
    if (answer.isNotEmpty) {
      textEditingController.text = answer;
      textEditingController.selection =
          TextSelection(baseOffset: answer.length, extentOffset: answer.length);
      answer = '';
    }
  }

  _result() {
    String operation = textEditingController.text;
    if (operation.isNotEmpty) {
      int start = 0;
      int end = operation.length - 1;
      String op;
      if (!Elem.isPercent(operation[end]) && Elem.isOperand(operation[end]))
        end--;
      if (Elem.isPercent(operation[0])) start++;
      op = operation.substring(start, end + 1);
      if (op.isNotEmpty) {
        try {
          if (Elem.isNumber(op))
            answer = '';
          else
            answer = Calculator.eval(op).toString();
        } catch (e) {
          answer = 'Error';
        }
      }
    }
  }

  clear() {
    textEditingController.text = '';
    textEditingController.selection =
        TextSelection(baseOffset: 0, extentOffset: 0);
    answer = '';
  }
}
