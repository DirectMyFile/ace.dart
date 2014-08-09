part of ace;

/// The main entry point into the Ace functionality.
/// 
/// An [Editor] manages an [EditSession] (which in turn manages a [Document]), 
/// as well as the [VirtualRenderer], which draws everything to the screen.
/// Event sessions dealing with the mouse and keyboard are bubbled up from the
/// [Document] to the [Editor], which decides what to do with them.
abstract class Editor extends Disposable implements OptionsProvider {
  
  /// Fired whenever this editor has been blurred.
  Stream<Null> get onBlur;
  
  /// Fired whenever user has clicked on a linking identifier in code.
  Stream<LinkEvent> get onLinkClick;

  /// Fired whenever user has hovered over a linking identifier in code with
  /// appropriate modifier key down.
  Stream<LinkEvent> get onLinkHover;

  /// Fired whenever the [session.document] changes.
  Stream<Delta> get onChange;
  
  /// Fired whenever the [selection] changes.
  Stream<Null> get onChangeSelection;
  
  /// Fired whenever the [session] changes.
  Stream<EditSessionChangeEvent> get onChangeSession;
  
  /// Fired whenever text is copied.
  Stream<String> get onCopy;
  
  /// Fired whenever this editor comes into focus.
  Stream<Null> get onFocus;
  
  /// Fired whenever text is pasted.
  Stream<String> get onPaste;  
  
  /// The current [CommandManager] for this editor.
  CommandManager get commands;
  
  /// The string of text in the current [selectionRange].
  String get copyText;
  
  /// The current position of the cursor.
  Point get cursorPosition;
  
  /// The current mouse drag delay, in milliseconds.
  int dragDelay;

  /// Whether to fade in/out the fold widgets on mouse hover.
  bool fadeFoldWidgets;
  
  /// The index of the first visible row.
  int get firstVisibleRow;
  
  /// The index of the last visible row.
  int get lastVisibleRow;
  
  /// The font size in pixels for this editor's text.
  int fontSize;

  /// Whether or not the current line should be highlighted.
  bool highlightActiveLine;

  /// Whether or not the current line gutter should be highlighted.
  bool highlightGutterLine;

  /// Whether or not the current selected word should be highlighted.
  bool highlightSelectedWord;

  /// Returns _true_ if current [textInput] is in focus.
  bool get isFocused;
  
  KeyBinding get keyBinding;
  
  KeyboardHandler keyboardHandler;
  
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

  /// The current [Selection].
  Selection get selection;
  
  /// The [Selection.range] of the current [selection].
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
  
  /// The current [Theme] for this editor.
  Theme theme;
  
  /// Returns the current [session.value].
  String get value;
  
  factory Editor(VirtualRenderer renderer, EditSession session) =>
      implementation.createEditor(renderer, session);
  
  void alignCursors();
  
  /// Indents the current line by the current [session.tabSize].
  void blockIndent();
  
  /// Outdents the current line by the current [session.tabSize].
  void blockOutdent();
  
  /// Blurs the current [textInput].
  void blur();
  
  /// Centers the current [selection] on the screen.
  void centerSelection();
  
  /// Clears the current [selection].
  void clearSelection();
  
  /// Copies all of the lines in the current [selection] down one row.
  /// 
  /// This method copies entire rows, so the copied range may be larger than
  /// the current [selectionRange].
  int copyLinesDown();
  
  /// Copies all of the lines in the current [selection] up one row.
  /// 
  /// This method copies entire rows, so the copied range may be larger than
  /// the current [selectionRange].
  int copyLinesUp();
  
  void execCommand(String commandName);
  
  void exitMultiSelectMode();
  
  /// Brings the current [textInput] into focus.
  void focus();
  
  /// Moves the [cursorPosition] to the specified [lineNumber], and also into 
  /// the indiciated [column].
  void gotoLine(int lineNumber, [int column = 0, bool animate = false]);
  
  /// Scrolls the document down a page and updates the [cursorPosition].
  void gotoPageDown();
  
  /// Scrolls the document up a page and updates the [cursorPosition].
  void gotoPageUp();
  
  /// Indents the current line.
  void indent();
  
  /// Insert [text] at the current [cursorPosition].
  void insert(String text);
  
  /// Returns `true` if the given [row] is currently fully visible on the 
  /// screen.
  bool isRowFullyVisible(int row);
  
  /// Returns `true` if the given [row] is currently visible on the screen.
  bool isRowVisible(int row);
  
  /// Move the cursor down in the document the specified number of [times].
  /// 
  /// Note that this does de-select the current [selection].
  void navigateDown([int times = 1]);
  
  /// Move the cursor to the end of the current document.
  /// 
  /// Note that this does de-select the current [selection].
  void navigateFileEnd();
  
  /// Move the cursor to the start of the current document.
  /// 
  /// Note that this does de-select the current [selection].
  void navigateFileStart();
  
  /// Move the cursor left in the document the specified number of [times].
  /// 
  /// Note that this does de-select the current [selection].
  void navigateLeft([int times = 1]);
  
  /// Move the [cursorPosition] to the end of the current line.
  /// 
  /// Note that this does de-select the current [selection].
  void navigateLineEnd();
  
  /// Move the [cursorPosition] to the start of the current line.
  /// 
  /// Note that this does de-select the current [selection].
  void navigateLineStart();
  
  /// Move the [cursorPosition] right in the document the specified number of 
  /// [times].  
  /// 
  /// Note that this does de-select the current [selection].
  void navigateRight([int times = 1]);
  
  /// Move the [cursorPosition] to the specified [row] and [column].
  /// 
  /// Note that this does de-select the current selection.
  void navigateTo(int row, int column);
  
  /// Move the [cursorPosition] up in the document the specified number of 
  /// [times].
  /// 
  /// Note that this does de-select the current [selection].
  void navigateUp([int times = 1]);
  
  /// Move the [cursorPosition] to the word immediately to its left. 
  /// 
  /// Note that this does de-select the current [selection].
  void navigateWordLeft();
  
  /// Move the [cursorPosition] to the word immediately to its right. 
  /// 
  /// Note that this does de-select the current [selection].
  void navigateWordRight();
  
  /// Paste the given [text] into this editor.
  void paste(String text);
  
  /// Performs a redo operation on the current [EditSession.document], 
  /// reapplying the last change.
  /// 
  /// The current [session]'s [UndoManager.hasRedo] may be called to check if
  /// there are any redo operations to perform.
  void redo();
  
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
  
  /// Triggers a resize of this editor.
  /// 
  /// If [force] is `true` then the size is recomputed even if neither the 
  /// height nor width have changed.
  void resize(bool force);
  
  /// Scrolls the document down a page but does _not_ change the 
  /// [cursorPosition].
  void scrollPageDown();
  
  /// Scrolls the document up a page but does _not_ change the [cursorPosition].
  void scrollPageUp();
  
  /// Scrolls to the given [line] number.
  /// 
  /// If [center] is `true` the given line will be centered on the screen.
  /// If [animate] is `true` the scroll will be animated.
  void scrollToLine(int line, {bool center: false, bool animate: false});
  
  /// Scrolls to the given [row].
  void scrollToRow(int row);
  
  /// Selects all the text in this editor.
  void selectAll();
  
  /// Sets the current [EditSession.value] to the given [value].
  /// 
  /// The given [cursorPosition] will determine which of the following calls is
  /// made on this editor after setting the new [EditSession.value]:
  /// 
  /// * 0   : [selectAll]
  /// * 1   : [navigateFileEnd]
  /// * -1  : [navigateFileStart]
  /// 
  String setValue(String value, [int cursorPosition = 0]);
  
  /// Sets the value of [overwrite] to the opposite of its current value.
  void toggleOverwrite();
  
  /// Converts the current [selection] entirely into lowercase characters.
  void toLowerCase();
  
  /// Converts the current [selection] entirely into uppercase characters.
  void toUpperCase();
  
  /// Transposes two characters on either side of the current [cursorPosition].
  /// 
  /// When called at the end of a line, rather than transposing the last 
  /// character of the line with the newline, which would be useless, this 
  /// method transposes the last two characters on the line.
  /// 
  /// If the current [selection] is not empty or the current [cursorPosition]
  /// is at the beginning of a line then this method does nothing.
  void transposeLetters();
  
  /// Performs an undo operation on the current [EditSession.document], 
  /// reverting the last change. 
  /// 
  /// The current [session]'s [UndoManager.hasUndo] may be called to check if
  /// there are any undo operations to perform.
  void undo();
  
  void updateSelectionMarkers();
}

class LinkEvent {
  
  /// The document character position of the cursor at the time of this event.
  final Point position;

  /// The relevant token for this link event.
  final Token token;

  LinkEvent(this.position, this.token);
}

class EditSessionChangeEvent {
  
  /// The old [EditSession].
  final EditSession oldSession;  
  
  /// The new [EditSession].
  final EditSession newSession;  
  
  EditSessionChangeEvent(this.oldSession, this.newSession);
}