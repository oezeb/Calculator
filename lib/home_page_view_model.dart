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
        ansCtrl.text = eval(opCtrl.text);
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

  append(String string) {
    Elem curr = Elem(string);
    int pos = opCtrl.selection.start;
    String operation = opCtrl.text;
    if (operation.isEmpty || pos == 0) {
      if (curr.isNumber) {
        operation = curr.value + operation;
        pos++;
      }
    } else {
      Elem prev = Elem(operation[pos - 1]);
      if (prev.isOperand) {
        if (curr.isOperand) {
          if (curr.isSub && (prev.isMul || prev.isDiv)) {
            operation = operation.replaceRange(pos, pos, curr.value);
            pos++;
          } else {
            operation = operation.replaceRange(pos - 1, pos, curr.value);
          }
        } else {
          operation = operation.replaceRange(pos, pos, curr.value);
          pos++;
        }
      } else {
        operation = operation.replaceRange(pos, pos, curr.value);
        pos++;
      }
    }

    opCtrl.text = operation;
    opCtrl.selection = TextSelection(baseOffset: pos, extentOffset: pos);
    ansCtrl.text = eval(opCtrl.text);
  }

  backspace() {
    int pos = opCtrl.selection.start;
    if (pos > 0) {
      opCtrl.text = opCtrl.text.replaceRange(pos - 1, pos, '');
      pos--;
    }
    opCtrl.selection = TextSelection(baseOffset: pos, extentOffset: pos);
    ansCtrl.text = eval(opCtrl.text);
  }

  showResult() {
    if (ansCtrl.text.isNotEmpty) {
      opCtrl.text = ansCtrl.text;
      opCtrl.selection = TextSelection(
          baseOffset: ansCtrl.text.length, extentOffset: ansCtrl.text.length);
      ansCtrl.text = '';
    }
  }

  static String eval(String operation) {
    if (operation.isNotEmpty) {
      int start = 0;
      int end = operation.length - 1;
      String op;
      if (Elem(operation[end]).isOperand) end--;
      if (Elem(operation[0]).isPercent) start++;
      op = operation.substring(start, end + 1);
      if (op.isNotEmpty) {
        try {
          if (!Elem(op).isNumber || Elem(op[op.length - 1]).isPercent) {
            num res = Calculator.eval(op);
            if (res - res.toInt() == 0.0) res = res.toInt();
            if (res < 0)
              return '−' + res.abs().toString();
            else
              return res.toString();
          }
        } catch (e) {
          print(e);
          return 'Error';
        }
      }
    }
    return '';
  }

  clear() {
    opCtrl.text = '';
    opCtrl.selection = TextSelection(baseOffset: 0, extentOffset: 0);
    ansCtrl.text = '';
  }
}
