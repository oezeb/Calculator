import 'dart:collection';

import 'elem.dart';
import 'stream.dart';

class Calculator {
  static num eval(String string) {
    Queue<String> queue = reversePolish(string);
    Queue<num> stack = new Queue();
    while (queue.isNotEmpty) {
      String str = queue.removeFirst();
      if (Elem(str).isOperand && stack.length >= 2) {
        num num2 = stack.removeFirst();
        num num1 = stack.removeFirst();
        stack.addFirst(calculate(num1, num2, str));
      } else if (Elem(str).isNumber) {
        stack.addFirst(parseNum(str));
      } else {
        throw Exception();
      }
    }

    if (stack.length != 1) throw Exception();

    return stack.removeFirst();
  }

  static Queue<String> reversePolish(String string) {
    return _reversePolish(Stream(string));
  }

  static Queue<String> _reversePolish(Stream stream) {
    Queue<String> stack = Queue();
    Queue<String> queue = Queue();

    while (stream.hasNext) {
      String next = stream.next;
      if (Elem(next).isPercent) {
        queue.addLast('100');
        queue.addLast('÷');
      } else if (Elem(next).isOperand) {
        stack.addFirst(next);
      } else {
        queue.addLast(next);

        if (stack.isNotEmpty) {
          if (Elem(stack.first).isMul || Elem(stack.first).isDiv)
            queue.addLast(stack.removeFirst());
        }
      }
    }

    stack.toList().forEach((elem) {
      queue.addLast(elem);
    });

    return queue;
  }

  static num calculate(num num1, num num2, String sym) {
    if (Elem(sym).isAdd) return num1 + num2;
    if (Elem(sym).isSub) return num1 - num2;
    if (Elem(sym).isMul) return num1 * num2;
    if (Elem(sym).isDiv) return num1 / num2;
    throw new Exception("unknown symbol");
  }

  static num parseNum(String string) {
    int start = string.length > 0 && Elem(string[0]).isSub ? 1 : 0;
    num ans = num.parse(string.substring(start));
    return start == 0 ? ans : -ans;
  }
}
