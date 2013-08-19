part of ace;

/// Encapsulates the current [cursor] position and the text selection of an 
/// [EditSession].
/// 
/// The positions (row and column) used in a selection are in [Document] 
/// coordinates representing the coordinates as they appear in the document 
/// before applying soft wrap and folding.
class Selection extends _HasProxy {
  js.Callback _jsOnChangeCursor;
  js.Callback _jsOnChangeSelection;
  
  final _onChangeCursor = new StreamController.broadcast();
  final _onChangeSelection = new StreamController.broadcast();
  
  /// The current position of the cursor.
  Point get cursor => new Point._(_proxy.getCursor());
  
  bool get isBackwards => _proxy.isBackwards();
  
  /// Returns `true` if this selection is empty.
  bool get isEmpty => _proxy.isEmpty();
  
  /// Returns `true` if this selection is multi-line.
  bool get isMultiLine => _proxy.isMultiLine();  
  
  /// Fired whenever the [cursor] position changes.
  Stream get onChangeCursor => _onChangeCursor.stream;
  
  /// Fired whenever the cursor selection changes.
  Stream get onChangeSelection => _onChangeSelection.stream;
  
  Range get range => new Range._(_proxy.getRange());
  
  /// Creates a new [Selection] for the given [session].
  Selection(EditSession session) 
    : this._(new js.Proxy(
        _context.ace.define.modules['ace/selection'].Selection, 
        session._proxy));
  
  Selection._(js.Proxy proxy) : super(proxy) {
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
