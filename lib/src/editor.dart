part of ace;

/// The main entry point into the Ace functionality.
/// 
/// An [Editor] manages an [EditSession] (which in turn manages a [Document]), 
/// as well as the [VirtualRenderer], which draws everything to the screen.
/// Event sessions dealing with the mouse and keyboard are bubbled up from the
/// [Document] to the [Editor], which decides what to do with them.
abstract class Editor extends _Disposable {
  
  /// Fired whenever this editor has been blurred.
  Stream get onBlur;
  
  /// Fired whenever the [session.document] changes.
  Stream<Delta> get onChange;
  
  /// Fired whenever the [session] changes.
  Stream<EditSessionChangeEvent> get onChangeSession;
  
  /// Fired whenever text is copied.
  Stream<String> get onCopy;
  
  /// Fired whenever this editor comes into focus.
  Stream get onFocus;
  
  /// Fired whenever text is pasted.
  Stream<String> get onPaste;  
  
  /// The string of text in the current [selectionRange].
  String get copyText;
  
  /// The current position of the cursor.
  Point get cursorPosition;
  
  /// The current mouse drag delay, in milliseconds.
  int dragDelay;

  /// The index of the first visible row.
  int get firstVisibleRow;
  
  /// The font size in pixels for this editor's text.
  int fontSize;

  /// Whether or not the current line should be highlighted.
  bool highlightActiveLine;

  bool highlightGutterLine;

  bool highlightSelectedWord;

  /// Returns _true_ if current [textInput] is in focus.
  bool get isFocused;
  
  /// The current [session.overwrite].
  bool overwrite;
  
  /// The column number of where the print margin is.
  int printMarginColumn;

  /// Whether or not this editor is set to read-only mode.
  /// 
  /// If `true` then this editor can not be modified.
  bool readOnly;

  VirtualRenderer get renderer;
  
  /// The current mouse scroll speed, in milliseconds.
  int scrollSpeed;

  Selection get selection;
  
  Range get selectionRange;
  
  /// The current [EditSession] being used; setting a new session fires an 
  /// [onChangeSession] event.
  EditSession session;
  
  /// Whether or not invisible characters such as the space character and new 
  /// line character are shown in this editor.
  bool showInvisibles;

  /// Whether or not the [printMarginColumn] is shown in this editor.
  bool showPrintMargin;

  TextInput get textInput;
    
  Theme theme;
  
  /// Returns the current [session.value].
  String get value;
  
  void alignCursors();
  
  /// Indents the current line by the current [session.tabSize].
  void blockIndent();
  
  /// Outdents the current line by the current [session.tabSize].
  void blockOutdent();
  
  /// Blurs the current [textInput].
  void blur();
  
  void centerSelection();
  
  void clearSelection();
  
  int copyLinesDown();
  
  int copyLinesUp();
  
  void exitMultiSelectMode();
  
  /// Brings the current [textInput] into focus.
  void focus();
  
  void gotoPageDown();
  
  void gotoPageUp();
  
  void indent();
  
  /// Insert [text] at the current [cursorPosition].
  void insert(String text);
  
  bool isRowFullyVisible(int row);
  
  bool isRowVisible(int row);
  
  /// Move the cursor down in the document the specified number of times.
  /// Note that this does de-select the current [selection].
  void navigateDown(int times);
  
  /// Move the cursor to the end of the current document.
  /// Note that this does de-select the current [selection].
  void navigateFileEnd();
  
  /// Move the cursor to the start of the current document.
  /// Note that this does de-select the current [selection].
  void navigateFileStart();
  
  /// Move the cursor left in the document the specified number of times.
  /// Note that this does de-select the current [selection].
  void navigateLeft(int times);
  
  /// Move the [cursorPosition] to the end of the current line.
  /// Note that this does de-select the current [selection].
  void navigateLineEnd();
  
  /// Move the [cursorPosition] to the start of the current line.
  /// Note that this does de-select the current [selection].
  void navigateLineStart();
  
  /// Move the [cursorPosition] right in the document the specified number of 
  /// times.  Note that this does de-select the current [selection].
  void navigateRight(int times);
  
  /// Move the [cursorPosition] to the specified [row] and [column].
  /// Note that this does de-select the current selection.
  void navigateTo(int row, int column);
  
  /// Move the [cursorPosition] up in the document the specified number of 
  /// times.  Note that this does de-select the current [selection].
  void navigateUp(int times);
  
  /// Move the [cursorPosition] to the word immediately to its left. 
  /// Note that this does de-select the current [selection].
  void navigateWordLeft();
  
  /// Move the [cursorPosition] to the word immediately to its right. 
  /// Note that this does de-select the current [selection].
  void navigateWordRight();
  
  /// Remove all of the words to the right of the current [selection], until the 
  /// end of the line.
  void removeToLineEnd();
  
  /// Removes all of the words to the left of the current [selection], until the 
  /// start of the line.
  void removeToLineStart();
  
  /// Remove the word directly to the left of the current [selection].
  void removeWordLeft();
  
  /// Remove the word directly to the right of the current [selection].
  void removeWordRight();  
  
  void resize(bool force);
  
  String setValue(String val, int cursorPos);
  
  /// Sets the value of [overwrite] to the opposite of its current value.
  void toggleOverwrite();
  
  /// Converts the current [selection] entirely into lowercase characters.
  void toLowerCase();
  
  /// Converts the current [selection] entirely into uppercase characters.
  void toUpperCase();
  
  void transposeLetters();
  
  void updateSelectionMarkers();
}

class EditSessionChangeEvent {
  
  /// The old [EditSession].
  final EditSession oldSession;  
  
  /// The new [EditSession].
  final EditSession newSession;  
  
  EditSessionChangeEvent._(this.oldSession, this.newSession);
}
