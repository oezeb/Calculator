import 'queue.dart';
import 'stack.dart';
import 'elem.dart';
import 'stream.dart';

class Calculator {
  static num eval(String string) {
    Queue<Elem> queue = reversePolish(string);
    Stack<num> stk = new Stack();
    while (!queue.isEmpty) {
      Elem elem = queue.dequeue();
      if (elem.type == ElemType.num) {
        stk.push(parseNum(elem.value));
      } else if (stk.length >= 2) {
        num num2 = stk.pop();
        num num1 = stk.pop();
        stk.push(calculate(num1, num2, elem.value));
      } else {
        throw Exception();
      }
    }

    if (stk.length != 1) throw Exception();

    return stk.pop();
  }

  static Queue<Elem> reversePolish(String string) {
    return _reversePolish(Stream(string));
  }

  static Queue<Elem> _reversePolish(Stream stream) {
    Stack<Elem> stk = Stack();
    Queue<Elem> queue = new Queue();

    while (stream.hasNext) {
      Elem elem = stream.next;
      if (elem.value == '%') {
        queue.enqueue(Elem(type: ElemType.num, value: '100'));
        queue.enqueue(Elem(type: ElemType.op, value: '÷'));
      } else if (elem.type == ElemType.num) {
        queue.enqueue(elem);

        if (!stk.isEmpty) {
          String sym = stk.top.value;
          if (sym == '×' || sym == '*' || sym == '÷' || sym == '/')
            queue.enqueue(stk.pop());
        }
      } else {
        stk.push(elem);
      }
    }

    stk.toList().forEach((elem) {
      queue.enqueue(elem);
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
