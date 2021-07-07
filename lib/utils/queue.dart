class Queue<E> {
  static const _SIZE = 100;
  List<E> _buf;
  int _head, _tail;

  Queue()
      : _buf = [],
        _head = 0,
        _tail = 0;

  bool get isEmpty => _head == _tail;

  bool get _full => _next(_tail) == _head;

  void enqueue(E e) {
    if (_full) {
      _buf = toList();
      // update infos
      _head = 0;
      _tail = _buf.length;

      // add new elements space
      _buf.addAll(List<E>.filled(_SIZE, e));
    }
    _buf[_tail] = e;
    _tail = _next(_tail);
  }

  E dequeue() {
    if (isEmpty) throw Exception('Stack is Empty');
    E e = front;
    _head = _next(_head);
    return e;
  }

  E get front {
    if (isEmpty)
      throw Exception('Stack is Empty');
    else
      return _buf[_head];
  }

  int get length =>
      _head <= _tail ? _tail - _head : _buf.length - _head + _tail;

  int _next(int curr) => _buf.length > 0 ? (curr + 1) % _buf.length : 0;

  List<E> toList() {
    final List<E> list = [];
    for (int i = _head; i != _tail; i = _next(i)) list.add(_buf[i]);
    return list;
  }

  @override
  String toString() {
    return toList().toString();
  }
}
