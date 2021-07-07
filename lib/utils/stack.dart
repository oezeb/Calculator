class Stack<E> {
  static const _SIZE = 100;
  List<E> _buf;
  int length;

  Stack()
      : _buf = [],
        length = 0;

  bool get isEmpty => length <= 0;

  void push(E e) {
    if (length >= _buf.length) _buf.addAll(List<E>.filled(_SIZE, e));
    _buf[length++] = e;
  }

  E pop() {
    if (isEmpty)
      throw Exception('Stack is Empty');
    else
      return _buf[--length];
  }

  E get top {
    if (isEmpty)
      throw Exception('Stack is Empty');
    else
      return _buf[length - 1];
  }

  List<E> toList() {
    final List<E> list = [];
    for (int i = length - 1; i >= 0; i--) list.add(_buf[i]);
    return list;
  }

  @override
  String toString() {
    return _buf.sublist(0, length).reversed.toString();
  }
}
