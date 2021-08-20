import 'dart:collection';

import 'elem.dart';

class Stream {
  String _buffer;
  int _index;
  Queue<String> _stack;

  Stream(String string)
      : _buffer = string,
        _index = 0,
        _stack = Queue();

  bool get hasNext => _index < _buffer.length || _stack.isNotEmpty;

  String get next {
    if (!hasNext) throw new Exception("End Of Stream");

    if (_stack.isNotEmpty) return _stack.removeFirst();

    if (Elem(_buffer[_index]).isSub) {
      // is -
      if (_index > 0) {
        String str = _buffer[_index - 1];
        if (!Elem(str).isMul && !Elem(str).isDiv) {
          // not * or /
          _stack.addFirst(_nextNum);
          return '+';
        }
      }
      return _nextNum;
    } else if (Elem(_buffer[_index]).isOperand) {
      // is + or * or / or %
      return _buffer[_index++];
    } else {
      return _nextNum;
    }
  }

  String get _nextNum {
    StringBuffer val = new StringBuffer('');

    if (Elem(_buffer[_index]).isSub) val.write(_buffer[_index++]);

    while (_index < _buffer.length)
      if (Elem(_buffer[_index]).isDigit || Elem(_buffer[_index]).isDot)
        val.write(_buffer[_index++]);
      else
        break;

    return val.toString();
  }
}
