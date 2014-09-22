part of ace.proxy;

class _SelectionProxy extends HasProxy implements Selection {

  Point get cursor => _point(call('getCursor'));
  
  bool get isBackwards => call('isBackwards');
  
  bool get isEmpty => call('isEmpty');
  
  bool get isMultiLine => call('isMultiLine');  
  
  _Event<Null> _onChangeCursor;
  Stream<Null> get onChangeCursor {
    if (_onChangeCursor == null) {
      _onChangeCursor = new _Event<Null>(this, 'changeCursor');
    }
    return _onChangeCursor.stream;
  }
  
  _Event<Null> _onChangeSelection;
  Stream<Null> get onChangeSelection {
    if (_onChangeSelection == null) {
      _onChangeSelection = new _Event<Null>(this, 'changeSelection');
    }
    return _onChangeSelection.stream;
  }
  
  Range get range => _range(call('getRange'));
  
  _SelectionProxy(_EditSessionProxy session) 
  : this._(new js.JsObject(_modules['ace/selection']['Selection'], 
      [session._proxy]));
  
  _SelectionProxy._(js.JsObject proxy) : super(proxy);
  
  Future _onDispose() {
    final List<Future> f = new List<Future>();
    if (_onChangeCursor != null) f.add(_onChangeCursor.dispose());
    if (_onChangeSelection != null) f.add(_onChangeSelection.dispose());
    return Future.wait(f);
  }
  
  Range getLineRange(int row, {bool excludeLastChar: false}) =>
      _range(call('getLineRange', [row, excludeLastChar]));
  
  void mergeOverlappingRanges() => call('mergeOverlappingRanges');
  
  void moveCursorBy(int rows, int columns) => 
      call('moveCursorBy', [rows, columns]);
  
  void moveCursorDown() => call('moveCursorDown');
  
  void moveCursorFileEnd() => call('moveCursorFileEnd');
  
  void moveCursorFileStart() => call('moveCursorFileStart');
  
  void moveCursorLeft() => call('moveCursorLeft');
  
  void moveCursorLineEnd() => call('moveCursorLineEnd');
  
  void moveCursorLineStart() => call('moveCursorLineStart');
  
  void moveCursorRight() => call('moveCursorRight');
  
  void moveCursorTo(int row, int column, {bool keepDesiredColumn: false}) =>
      call('moveCursorTo', [row, column, keepDesiredColumn]);
  
  void moveCursorToScreen(int row, int column, 
                          {bool keepDesiredColumn: false}) =>
      call('moveCursorToScreen', [row, column, keepDesiredColumn]);
  
  void moveCursorUp() => call('moveCursorUp');
  
  void moveCursorWordLeft() => call('moveCursorWordLeft');
  
  void moveCursorWordRight() => call('moveCursorWordRight');
  
  void selectAll() => call('selectAll');
  
  void selectAWord() => call('selectAWord');
  
  void selectDown() => call('selectDown');
  
  void selectFileEnd() => call('selectFileEnd');
  
  void selectFileStart() => call('selectFileStart');
  
  void selectLeft() => call('selectLeft');
  
  void selectLine() => call('selectLine');
  
  void selectLineEnd() => call('selectLineEnd');

  void selectLineStart() => call('selectLineStart');
  
  void selectRight() => call('selectRight');
  
  void selectTo(int row, int column) => call('selectTo', [row, column]);
  
  void selectUp() => call('selectUp');
  
  void selectWord() => call('selectWord');
  
  void selectWordLeft() => call('selectWordLeft');
  
  void selectWordRight() => call('selectWordRight');
  
  void setSelectionAnchor(int row, int column) =>
      call('setSelectionAnchor', [row, column]);
  
  void shiftSelection(int columns) => call('shiftSelection', [columns]);
}
