class Elem {
  final String _value;
  bool? _isNumber;

  Elem(String value)
      : _value = value,
        _isNumber = null;

  String get value => _value;

  bool get isDigit => _value.length == 1 && _value.contains(RegExp('[0-9]'));
  bool get isOperand => isAdd || isSub || isMul || isDiv;
  bool get isMul => _value == '×' || _value == '*';
  bool get isDiv => _value == '÷' || _value == '/';
  bool get isAdd => _value == '+';
  bool get isSub => _value == '−' || _value == '-';
  bool get isPercent => _value == '%';
  bool get isDot => _value == '.';
  bool get isNumber {
    if (_isNumber != null) return _isNumber!;

    int index = 0;
    // first element is + || -
    if (index < _value.length) {
      if (Elem(_value[index]).isAdd || Elem(_value[index]).isSub) index++;
    }
    // digits
    while (index < _value.length) {
      if (Elem(_value[index]).isDigit ||
          Elem(_value[index]).isDot) // [0-9] || .
        index++;
      else
        break;
    }
    // last element is %
    if (index < _value.length) {
      if (Elem(_value[index]).isPercent) index++;
    }

    _isNumber = index == _value.length;
    return _isNumber!;
  }

  @override
  String toString() => _value;
}
