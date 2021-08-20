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

    Elem elem = Elem(_buffer[_index]);
    if (elem.isSub) {
      // is -
      if (_index > 0) {
        elem = Elem(_buffer[_index - 1]);
        if (!elem.isMul && !elem.isDiv) {
          // not * or /
          _stack.addFirst(_nextNum);
          return '+';
        }
      }
      return _nextNum;
    } else if (elem.isAdd || elem.isMul || elem.isDiv) {
      // is + or * or /
      return _buffer[_index++];
    } else {
      return _nextNum;
    }
  }

  String get _nextNum {
    StringBuffer val = new StringBuffer('');

    Elem elem = Elem(_buffer[_index]);
    if (elem.isSub) val.write(_buffer[_index++]);

    while (_index < _buffer.length) {
      elem = Elem(_buffer[_index]);
      if (elem.isDigit || elem.isDot) {
        val.write(_buffer[_index++]);
      } else {
        if (elem.isPercent) val.write(_buffer[_index++]);
        break;
      }
    }

    return val.toString();
  }
}
