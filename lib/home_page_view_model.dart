import 'package:flutter/cupertino.dart';

import 'utils/calculator.dart';
import 'utils/elem.dart';

class HomePageViewModel {
  String mem = '';
  String _memVal = '0';

  TextEditingController opCtrl = TextEditingController();
  TextEditingController ansCtrl = TextEditingController();

  memOp(String string) {
    if (string == 'mr') {
      if (mem.isNotEmpty) {
        opCtrl.text = _memVal;
        opCtrl.selection = TextSelection(
          baseOffset: _memVal.length,
          extentOffset: _memVal.length,
        );
        _result();
      }
    } else if (string == 'mc') {
      mem = '';
      _memVal = '0';
    } else {
      String operation = opCtrl.text;
      if (ansCtrl.text.isNotEmpty) operation = ansCtrl.text;

      num a, b;
      try {
        a = Calculator.eval(_memVal);
        b = Calculator.eval(operation);
      } catch (err) {
        print(err);
        mem = 'Error';
        return;
      }

      switch (string) {
        case 'm+':
          _memVal = (a + b).toString();
          mem = 'M';
          break;
        case 'm−':
          _memVal = (a - b).toString();
          mem = 'M';
          break;
      }
    }
  }

  append(String curr) {
    int pos = opCtrl.selection.start;
    String operation = opCtrl.text;
    if (operation.isEmpty || pos == 0) {
      if (Elem(curr).isNumber) {
        operation = curr + operation;
        pos++;
      }
    } else {
      String prev = operation[pos - 1];
      if (!Elem(prev).isPercent && Elem(prev).isOperand) {
        if (!Elem(curr).isPercent && Elem(curr).isOperand) {
          if (Elem(curr).isSub && (Elem(prev).isMul || Elem(prev).isDiv)) {
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

    opCtrl.text = operation;
    opCtrl.selection = TextSelection(baseOffset: pos, extentOffset: pos);
    _result();
  }

  backspace() {
    int pos = opCtrl.selection.start;
    if (pos > 0) {
      opCtrl.text = opCtrl.text.replaceRange(pos - 1, pos, '');
      pos--;
    }
    opCtrl.selection = TextSelection(baseOffset: pos, extentOffset: pos);
    _result();
  }

  showResult() {
    if (ansCtrl.text.isNotEmpty) {
      opCtrl.text = ansCtrl.text;
      opCtrl.selection = TextSelection(
          baseOffset: ansCtrl.text.length, extentOffset: ansCtrl.text.length);
      ansCtrl.text = '';
    }
  }

  _result() {
    String operation = opCtrl.text;
    if (operation.isNotEmpty) {
      int start = 0;
      int end = operation.length - 1;
      String op;
      if (!Elem(operation[end]).isPercent && Elem(operation[end]).isOperand)
        end--;
      if (Elem(operation[0]).isPercent) start++;
      op = operation.substring(start, end + 1);
      if (op.isNotEmpty) {
        try {
          if (Elem(op).isNumber)
            ansCtrl.text = '';
          else
            ansCtrl.text = Calculator.eval(op).toString();
        } catch (e) {
          ansCtrl.text = 'Error';
        }
      }
    }
  }

  clear() {
    opCtrl.text = '';
    opCtrl.selection = TextSelection(baseOffset: 0, extentOffset: 0);
    ansCtrl.text = '';
  }
}
