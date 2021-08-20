import 'dart:collection';

import 'elem.dart';
import 'stream.dart';

class Calculator {
  static num eval(String string) {
    Queue<Elem> queue = reversePolish(string);
    Queue<num> stack = new Queue();
    while (queue.isNotEmpty) {
      Elem elem = queue.removeFirst();
      if (elem.type == ElemType.num) {
        stack.addFirst(parseNum(elem.value));
      } else if (stack.length >= 2) {
        num num2 = stack.removeFirst();
        num num1 = stack.removeFirst();
        stack.addFirst(calculate(num1, num2, elem.value));
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
      Elem elem = stream.next;
      if (elem.value == '%') {
        queue.addLast(Elem(type: ElemType.num, value: '100'));
        queue.addLast(Elem(type: ElemType.op, value: '÷'));
      } else if (elem.type == ElemType.num) {
        queue.addLast(elem);

        if (stack.isNotEmpty) {
          String sym = stack.first.value;
          if (sym == '×' || sym == '*' || sym == '÷' || sym == '/')
            queue.addLast(stack.removeFirst());
        }
      } else {
        stack.addFirst(elem);
      }
    }

    stack.toList().forEach((elem) {
      queue.addLast(elem);
    });

    return queue;
  }

  static num calculate(num num1, num num2, String sym) {
    switch (sym) {
      case '+':
        return num1 + num2;
      case '×':
      case '*':
        return num1 * num2;
      case '÷':
      case '/':
        return num1 / num2;
      default:
        throw new Exception("unknown symbol");
    }
  }

  static num parseNum(String string) {
    int start = string.length > 0 && string[0] == '−' ? 1 : 0;
    num ans = num.parse(string.substring(start));
    return start == 0 ? ans : -ans;
  }
}
