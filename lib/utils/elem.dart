enum ElemType { num, op }

class Elem {
  ElemType type;
  String value;

  Elem({this.type = ElemType.num, this.value = ''});

  static bool isOperand(String str) =>
      isAdd(str) || isSub(str) || isMul(str) || isDiv(str) || isPercent(str);

  static bool isDigit(String str) =>
      str.length == 1 && str.contains(RegExp('[0-9]'));

  static bool isNumber(String str) {
    int index = 0;
    if (isAdd(str[index]) || isSub(str[index])) index++; // + || -
    while (index < str.length)
      if (isDigit(str[index]) || isDot(str[index])) // [0-9] || .
        index++;
      else
        break;
    return index == str.length;
  }

  static bool isMul(String str) => str == '×' || str == '*';
  static bool isDiv(String str) => str == '÷' || str == '/';
  static bool isAdd(String str) => str == '+';
  static bool isSub(String str) => str == '−' || str == '-';
  static bool isPercent(String str) => str == '%';
  static bool isDot(String str) => str == '.';

  @override
  String toString() => value;
}
