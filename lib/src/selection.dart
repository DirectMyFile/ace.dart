part of ace;

class Selection {
  js.Proxy _proxy;
  
  bool get isBackwards => _proxy.isBackwards();
  bool get isEmpty => _proxy.isEmpty();
  bool get isMultiLine => _proxy.isMultiLine();
  
  Selection._(js.Proxy proxy) : _proxy = js.retain(proxy);
  
  void dispose() {
    assert(_proxy != null);
    js.release(_proxy);
    _proxy = null;
  }
  
  void mergeOverlappingRanges() => _proxy.mergeOverlappingRanges();
  void moveCursorBy(int rows, int columns) => 
      _proxy.moveCursorBy(rows, columns);
  void moveCursorDown() => _proxy.moveCursorDown();
  void moveCursorFileEnd() => _proxy.moveCursorFileEnd();
  void moveCursorFileStart() => _proxy.moveCursorFileStart();
  void moveCursorLeft() => _proxy.moveCursorLeft();
  void moveCursorLineEnd() => _proxy.moveCursorLineEnd();
  void moveCursorLineStart() => _proxy.moveCursorLineStart();
  void moveCursorLongWordLeft() => _proxy.moveCursorLongWordLeft();
  void moveCursorLongWordRight() => _proxy.moveCursorLongWordRight();
  void moveCursorRight() => _proxy.moveCursorRight();
  void moveCursorShortWordLeft() => _proxy.moveCursorShortWordLeft();
  void moveCursorShortWordRight() => _proxy.moveCursorShortWordRight();
  void moveCursorTo(int row, int column, bool keepDesiredColumn) =>
      _proxy.moveCursorTo(row, column, keepDesiredColumn);
}
