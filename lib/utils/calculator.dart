import 'dart:collection';

import 'elem.dart';
import 'stream.dart';

class Calculator {
  static num eval(String string) {
    Queue<Elem> queue = reversePolish(string);
    Queue<num> stack = new Queue();
    while (queue.isNotEmpty) {
      Elem elem = queue.removeFirst();
      if (stack.length >= 2 && (elem.isAdd || elem.isMul || elem.isDiv)) {
        num num2 = stack.removeFirst();
        num num1 = stack.removeFirst();
        stack.addFirst(calculate(num1, num2, elem.value));
      } else if (elem.isNumber) {
        stack.addFirst(parseNum(elem.value));
      } else {
        throw Exception();
      }
    }

    if (stack.length != 1) throw Exception();

    return stack.removeFirst();
  }

  static Queue<Elem> reversePolish(String string) {
    return _reversePolish(Stream(string));
  }

  static Queue<Elem> _reversePolish(Stream stream) {
    Queue<Elem> stack = Queue();
    Queue<Elem> queue = Queue();

    while (stream.hasNext) {
      Elem elem = Elem(stream.next);
      if (elem.isAdd || elem.isMul || elem.isDiv) {
        stack.addFirst(elem);
      } else {
        queue.addLast(elem);

        if (stack.isNotEmpty) {
          if (stack.first.isMul || stack.first.isDiv)
            queue.addLast(stack.removeFirst());
        }
      }
    }

    stack.toList().forEach((e) {
      queue.addLast(e);
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
    try {
      return num.parse(string);
    } catch (err) {
      int len = string.length;
      if (len > 0) {
        if (Elem(string[0]).isSub) {
          return -parseNum(string.substring(1));
        }
        if (Elem(string[string.length - 1]).isPercent) {
          return parseNum(string.substring(0, string.length - 1)) / 100.0;
        }
      }
      throw err;
    }
  }
}
