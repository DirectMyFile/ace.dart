part of ace;

/// Encapsulates the current [cursor] position and the current text selection 
/// [range] of an [EditSession].
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
  
  /// The current [Range] of the selected text.
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
  
  /// Moves the [cursor] position by the given number of [rows] and [columns]
  /// relative to its current position.
  /// 
  /// Negative values for [rows] or [columns] move the [cursor] backwards in the
  /// document.
  void moveCursorBy(int rows, int columns) => 
      _proxy.moveCursorBy(rows, columns);
  
  /// Moves the [cursor] down one row.
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
  
  /// Moves the cursor to the given [row] and [column].
  /// 
  /// If [keepDesiredColumn] is `true`, the cursor move does not respect the
  /// previous column.
  void moveCursorTo(int row, int column, {bool keepDesiredColumn: false}) =>
      _proxy.moveCursorTo(row, column, keepDesiredColumn);
  
  void moveCursorToScreen(int row, int column, 
                          {bool keepDesiredColumn: false}) =>
      _proxy.moveCursorToScreen(row, column, keepDesiredColumn);
  
  void moveCursorUp() => _proxy.moveCursorUp();
  void moveCursorWordLeft() => _proxy.moveCursorWordLeft();
  void moveCursorWordRight() => _proxy.moveCursorWordRight();
  
  /// Selects all the text in the document.
  void selectAll() => _proxy.selectAll();
  
  /// Selects a word, including its right whitespace.
  void selectAWord() => _proxy.selectAWord();
  
  /// Selects down one row.
  void selectDown() => _proxy.selectDown();
  
  /// Selects to the end of the document.
  void selectFileEnd() => _proxy.selectFileEnd();
  
  /// Selects to the start of the document.
  void selectFileStart() => _proxy.selectFileStart();
  
  /// Selects to the left one column.
  void selectLeft() => _proxy.selectLeft();
  
  /// Selects the entire current line.
  void selectLine() => _proxy.selectLine();
  
  /// Selects to the end of the current line.
  void selectLineEnd() => _proxy.selectLineEnd();
  
  /// Selects to the start of the current line.
  void selectLineStart() => _proxy.selectLineStart();
  
  /// Selects to the right one column.
  void selectRight() => _proxy.selectRight();
  
  /// Selects to the given [row] and [column].
  void selectTo(int row, int column) => _proxy.selectTo(row, column);
  
  /// Selects up one row.
  void selectUp() => _proxy.selectUp();
  
  /// Selects an entire word boundary.
  void selectWord() => _proxy.selectWord();
  
  /// Selects the first word to the left and moves the [cursor] to the start of 
  /// the word.
  void selectWordLeft() => _proxy.selectWordLeft();
  
  /// Selects the first word to the right and moves the [cursor] to the end of
  /// the word.
  void selectWordRight() => _proxy.selectWordRight();
  
  void setSelectionAnchor(int row, int column) =>
      _proxy.setSelectionAnchor(row, column);
  void shiftSelection(int columns) => _proxy.shiftSelection(columns);
}
