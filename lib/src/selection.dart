part of ace;

/// Encapsulates the current [cursor] position and the current text selection 
/// [range] of an [EditSession].
/// 
/// The positions (row and column) used in a selection are in [Document] 
/// coordinates representing the coordinates as they appear in the document 
/// before applying soft wrap and folding.
abstract class Selection extends _Disposable {
  
  /// The current position of the cursor.
  Point get cursor;
  
  bool get isBackwards;
  
  /// Returns `true` if this selection is empty.
  bool get isEmpty;
  
  /// Returns `true` if this selection is multi-line.
  bool get isMultiLine;  
  
  /// Fired whenever the [cursor] position changes.
  Stream get onChangeCursor;
  
  /// Fired whenever the cursor selection changes.
  Stream get onChangeSelection;
  
  /// The current [Range] of the selected text.
  Range get range;
  
  /// Creates a new [Selection] for the given [session].
  factory Selection(EditSession session) => new _SelectionProxy(session);
      
  void mergeOverlappingRanges();
  
  /// Moves the [cursor] position by the given number of [rows] and [columns]
  /// relative to its current position.
  /// 
  /// Negative values for [rows] or [columns] move the [cursor] backwards in the
  /// document.
  void moveCursorBy(int rows, int columns);
  
  /// Moves the [cursor] down one row.
  void moveCursorDown();
  
  /// Moves the [cursor] to the end of the document.
  void moveCursorFileEnd();
  
  /// Moves the [cursor] to the start of the document.
  void moveCursorFileStart();
  
  /// Moves the [cursor] left one column.
  void moveCursorLeft();
  
  /// Moves the [cursor] to the end of the current line.
  void moveCursorLineEnd();
  
  /// Moves the [cursor] to the start of the current line.
  void moveCursorLineStart();
  
  /// Moves the [cursor] right one column.
  void moveCursorRight();
  
  /// Moves the [cursor] to the given [row] and [column].
  /// 
  /// If [keepDesiredColumn] is `true`, the cursor move does not respect the
  /// previous column.
  void moveCursorTo(int row, int column, {bool keepDesiredColumn: false});
  
  /// Moves the [cursor] to the the given [row] and [column] in screen 
  /// coordinates.
  /// 
  /// If [keepDesiredColumn] is `true`, the cursor move does not respect the
  /// previous column.
  /// 
  /// The given screen [row] and [column] are converted to document coordinates
  /// with [EditSession.screenToDocumentPosition] before the [cursor] is moved.
  void moveCursorToScreen(int row, int column, {bool keepDesiredColumn: false});
  
  /// Moves the [cursor] up one row.
  void moveCursorUp();
  
  /// Moves the [cursor] to the start of the first word on the left.
  void moveCursorWordLeft();
  
  /// Moves the [cursor] to the start of the first word on the right.
  void moveCursorWordRight();
  
  /// Selects all the text in the document.
  void selectAll();
  
  /// Selects a word, including its right whitespace.
  void selectAWord();
  
  /// Selects down one row.
  void selectDown();
  
  /// Selects to the end of the document.
  void selectFileEnd();
  
  /// Selects to the start of the document.
  void selectFileStart();
  
  /// Selects to the left one column.
  void selectLeft();
  
  /// Selects the entire current line.
  void selectLine();
  
  /// Selects to the end of the current line.
  void selectLineEnd();
  
  /// Selects to the start of the current line.
  void selectLineStart();
  
  /// Selects to the right one column.
  void selectRight();
  
  /// Selects to the given [row] and [column].
  void selectTo(int row, int column);
  
  /// Selects up one row.
  void selectUp();
  
  /// Selects an entire word boundary.
  void selectWord();
  
  /// Selects the first word to the left and moves the [cursor] to the start of 
  /// the word.
  void selectWordLeft();
  
  /// Selects the first word to the right and moves the [cursor] to the end of
  /// the word.
  void selectWordRight();
  
  void setSelectionAnchor(int row, int column);
  
  void shiftSelection(int columns);
}
