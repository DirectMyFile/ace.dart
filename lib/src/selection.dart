part of ace;

class Selection extends _HasProxy {
  
  bool get isBackwards => _proxy.isBackwards();
  bool get isEmpty => _proxy.isEmpty();
  bool get isMultiLine => _proxy.isMultiLine();  
  Range get range => new Range._(_proxy.getRange());
  
  Selection._(js.Proxy proxy) : super(proxy);
    
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
  void moveCursorToScreen(int row, int column, bool keepDesiredColumn) =>
      _proxy.moveCursorToScreen(row, column, keepDesiredColumn);
  void moveCursorUp() => _proxy.moveCursorUp();
  void moveCursorWordLeft() => _proxy.moveCursorWordLeft();
  void moveCursorWordRight() => _proxy.moveCursorWordRight();
  void selectAll() => _proxy.selectAll();
  void selectAWord() => _proxy.selectAWord();
  void selectDown() => _proxy.selectDown();
  void selectFileEnd() => _proxy.selectFileEnd();
  void selectFileStart() => _proxy.selectFileStart();
  void selectLeft() => _proxy.selectLeft();
  void selectLine() => _proxy.selectLine();
  void selectLineEnd() => _proxy.selectLineEnd();
  void selectLineStart() => _proxy.selectLineStart();
  void selectRight() => _proxy.selectRight();
  void selectTo(int row, int column) => _proxy.selectTo(row, column);
  void selectUp() => _proxy.selectUp();
  void selectWord() => _proxy.selectWord();
  void selectWordLeft() => _proxy.selectWordLeft();
  void selectWordRight() => _proxy.selectWordRight();
  void setSelectionAnchor(int row, int column) =>
      _proxy.setSelectionAnchor(row, column);
  void shiftSelection(int columns) => _proxy.shiftSelection(columns);
}
