part of ace;

class _SelectionProxy extends _HasProxy implements Selection {
  
  js.Callback _jsOnChangeCursor;
  js.Callback _jsOnChangeSelection;
  
  final _onChangeCursor = new StreamController.broadcast();
  final _onChangeSelection = new StreamController.broadcast();
  
  Point get cursor => new Point._(_proxy.getCursor());
  
  bool get isBackwards => _proxy.isBackwards();
  
  bool get isEmpty => _proxy.isEmpty();
  
  bool get isMultiLine => _proxy.isMultiLine();  
  
  Stream get onChangeCursor => _onChangeCursor.stream;
  
  Stream get onChangeSelection => _onChangeSelection.stream;
  
  Range get range => new Range._(_proxy.getRange());
  
  _SelectionProxy(EditSession session) 
  : this._(new js.Proxy(
        _context.ace.define.modules['ace/selection'].Selection, 
        (session as _EditSessionProxy)._proxy));
  
  _SelectionProxy._(js.Proxy proxy) : super(proxy) {
    _jsOnChangeCursor =
        new js.Callback.many((_,__) => _onChangeCursor.add(this));
    _jsOnChangeSelection =
        new js.Callback.many((_,__) => _onChangeSelection.add(this));
    _proxy.on('changeCursor', _jsOnChangeCursor);
    _proxy.on('changeSelection', _jsOnChangeSelection);
  }
  
  void _onDispose() {
    _onChangeCursor.close();
    _onChangeSelection.close();
    _jsOnChangeCursor.dispose();
    _jsOnChangeSelection.dispose();
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
  
  void moveCursorRight() => _proxy.moveCursorRight();
  
  void moveCursorTo(int row, int column, {bool keepDesiredColumn: false}) =>
      _proxy.moveCursorTo(row, column, keepDesiredColumn);
  
  void moveCursorToScreen(int row, int column, 
                          {bool keepDesiredColumn: false}) =>
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
