part of ace;

class _SelectionProxy extends _HasProxy implements Selection {

  Point get cursor => new Point._(call('getCursor'));
  
  bool get isBackwards => call('isBackwards');
  
  bool get isEmpty => call('isEmpty');
  
  bool get isMultiLine => call('isMultiLine');  
  
  final _onChangeCursor = new StreamController.broadcast();
  Stream get onChangeCursor => _onChangeCursor.stream;
  
  final _onChangeSelection = new StreamController.broadcast();
  Stream get onChangeSelection => _onChangeSelection.stream;
  
  Range get range => new Range._(call('getRange'));
  
  _SelectionProxy(EditSession session) 
  : this._(new js.JsObject(
        _modules['ace/selection'][Selection], 
        [(session as _EditSessionProxy)._proxy]));
  
  _SelectionProxy._(js.JsObject proxy) : super(proxy) {
    call('on', ['changeCursor', (_,__) => _onChangeCursor.add(this)]);
    call('on', ['changeSelection', (_,__) => _onChangeSelection.add(this)]);
  }
  
  void _onDispose() {
    _onChangeCursor.close();
    _onChangeSelection.close();
  }
  
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
