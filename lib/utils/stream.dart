import 'elem.dart';
import 'stack.dart';

class Stream {
  String _buffer;
  int _index;
  Stack<Elem> _stack;

  Stream(this._buffer)
      : _index = 0,
        _stack = Stack();

  bool get hasNext => _index < _buffer.length || !_stack.isEmpty;

  Elem get next {
    if (!hasNext) throw new Exception("End Of Stream");

    if (!_stack.isEmpty) return _stack.pop();

    if (Elem.isSub(_buffer[_index])) {
      // is -
      if (_index > 0) {
        String str = _buffer[_index - 1];
        if (!Elem.isMul(str) && !Elem.isDiv(str)) {
          // not * or /
          _stack.push(Elem(type: ElemType.num, value: _num));
          return Elem(type: ElemType.op, value: '+');
        }
      }
      return Elem(type: ElemType.num, value: _num);
    } else if (Elem.isOperand(_buffer[_index])) // is + or * or / or %
      return Elem(type: ElemType.op, value: _buffer[_index++]);
    else
      return Elem(type: ElemType.num, value: _num);
  }

  String get _num {
    StringBuffer val = new StringBuffer('');

    if (_buffer[_index] == '−') val.write(_buffer[_index++]);

    while (_index < _buffer.length)
      if (Elem.isDigit(_buffer[_index]) || _buffer[_index] == '.')
        val.write(_buffer[_index++]);
      else
        break;

    return val.toString();
  }
}
