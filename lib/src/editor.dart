part of ace;

// TODO(rms): investigate the errors when using this event class:
//class EditSessionChangeEvent {
//  /// The old [EditSession].
//  final EditSession oldSession;  
//  /// The new [EditSession].
//  final EditSession newSession;  
//  EditSessionChangeEvent._(this.oldSession, this.newSession);
//}

/// The main entry point into the Ace functionality.
/// 
/// An [Editor] manages an [EditSession] (which in turn manages a [Document]), 
/// as well as the [VirtualRenderer], which draws everything to the screen.
/// Event sessions dealing with the mouse and keyboard are bubbled up from the
/// [Document] to the [Editor], which decides what to do with them.
class Editor extends _HasProxy {
  js.Callback _jsOnBlur;
  js.Callback _jsOnChange;
  js.Callback _jsOnChangeSession;
  js.Callback _jsOnCopy;
  js.Callback _jsOnFocus;
  js.Callback _jsOnPaste;
  
  final _onBlur = new StreamController.broadcast();
  final _onChange = new StreamController<Delta>.broadcast();
  final _onChangeSession = 
      new StreamController/*<EditSessionChangeEvent>*/.broadcast();
  final _onCopy = new StreamController<String>.broadcast();
  final _onFocus = new StreamController.broadcast();
  final _onPaste = new StreamController<String>.broadcast();
  
  /// Fired whenever this editor has been blurred.
  Stream get onBlur => _onBlur.stream;
  
  /// Fired whenever the [session.document] changes.
  Stream<Delta> get onChange => _onChange.stream;
  
  /// Fired whenever the [session] changes.
  Stream/*<EditSessionChangeEvent>*/ get onChangeSession => 
      _onChangeSession.stream;
  
  /// Fired whenever text is copied.
  Stream<String> get onCopy => _onCopy.stream;
  
  /// Fired whenever this editor comes into focus.
  Stream get onFocus => _onFocus.stream;
  
  /// Fired whenever text is pasted.
  Stream<String> get onPaste => _onPaste.stream;  
  
  /// The string of text in the current [selectionRange].
  String get copyText => _proxy.getCopyText();
  
  /// The current position of the cursor.
  Point get cursorPosition => new Point._(_proxy.getCursorPosition());
  
  /// The current mouse drag delay, in milliseconds.
  int
    get dragDelay => _proxy.getDragDelay();
    set dragDelay(int dragDelay) => _proxy.setDragDelay(dragDelay);
  
  /// The index of the first visible row.
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
  /// Whether or not the current line should be highlighted.
  bool
    get highlightActiveLine => _proxy.getHighlightActiveLine();
    set highlightActiveLine(bool highlightActiveLine) =>
        _proxy.setHighlightActiveLine(highlightActiveLine);
    
  bool
    get highlightGutterLine => _proxy.getHighlightGutterLine();
    set highlightGutterLine(bool highlightGutterLine) =>
        _proxy.setHighlightGutterLine(highlightGutterLine);
    
  bool
    get highlightSelectedWord => _proxy.getHighlightSelectedWord();
    set highlightSelectedWord(bool highlightSelectedWord) =>
        _proxy.setHighlightSelectedWord(highlightSelectedWord);
    
  /// Returns _true_ if current [textInput] is in focus.
  bool get isFocused => _proxy.isFocused();
  
  /// The current [session.overwrite].
  bool
    get overwrite => _proxy.getOverwrite();
    set overwrite(bool overwrite) => _proxy.setOverwrite(overwrite);
  
  /// The column number of where the print margin is.
  int
    get printMarginColumn => _proxy.getPrintMarginColumn();
    set printMarginColumn(int printMarginColumn) => 
        _proxy.setPrintMarginColumn(printMarginColumn);
    
  bool
    get readOnly => _proxy.getReadOnly();
    set readOnly(bool readOnly) => _proxy.setReadOnly(readOnly);
  
  VirtualRenderer get renderer => new VirtualRenderer._(_proxy.renderer);
  
  /// The current mouse scroll speed, in milliseconds.
  int
    get scrollSpeed => _proxy.getScrollSpeed();
    set scrollSpeed(int scrollSpeed) => _proxy.setScrollSpeed(scrollSpeed);
    
  Selection get selection => new Selection._(_proxy.getSelection());
  Range get selectionRange => new Range._(_proxy.getSelectionRange());
  
  /// The current [EditSession] being used; setting a new session fires an 
  /// [onChangeSession] event.
  EditSession
    get session => new EditSession._(_proxy.getSession());
    set session(EditSession session) => _proxy.setSession(session._proxy);
  
  bool
    get showInvisibles => _proxy.getShowInvisibles();
    set showInvisibles(bool showInvisibles) => 
        _proxy.setShowInvisibles(showInvisibles);
  
  TextInput get textInput => new TextInput._(_proxy.textInput);
    
  Theme
    get theme => new Theme._(_proxy.getTheme());
    set theme(Theme theme) => _proxy.setTheme(theme._theme);
  
  /// Returns the current [session.value].
  String get value => _proxy.getValue();
    
  Editor._(js.Proxy proxy) : super(proxy) {
    _jsOnBlur = new js.Callback.many((_,__) => _onBlur.add(this));
    _jsOnChange = new js.Callback.many((e,__) =>
        _onChange.add(new Delta._for(e.data)));
    _jsOnChangeSession = new js.Callback.many((e,__) {
      _onChangeSession.add(null);
//      _onChangeSession.add(new EditSessionChangeEvent._(
//          new EditSession._(e.oldSession),
//          new EditSession._(e.session))); 
    });
    _jsOnCopy = new js.Callback.many((e,__) => _onCopy.add(e));
    _jsOnFocus = new js.Callback.many((_,__) => _onFocus.add(this));
    _jsOnPaste = new js.Callback.many((e,__) => _onPaste.add(e));
    _proxy.on('blur', _jsOnBlur);
    _proxy.on('change', _jsOnChange);
    _proxy.on('changeSession', _jsOnChangeSession);
    _proxy.on('copy', _jsOnCopy);
    _proxy.on('focus', _jsOnFocus);
    _proxy.on('paste', _jsOnPaste);
  }
  
  void _onDispose() {
    _onBlur.close();
    _onChange.close();
    _onChangeSession.close();
    _onCopy.close();
    _onFocus.close();
    _onPaste.close();
    _jsOnBlur.dispose();
    _jsOnChange.dispose();
    _jsOnChangeSession.dispose();
    _jsOnCopy.dispose();
    _jsOnFocus.dispose();
    _jsOnPaste.dispose();
    _proxy.destroy();
  }
  
  void alignCursors() => _proxy.alignCursors();
  
  /// Indents the current line by the current [session.tabSize].
  void blockIndent() => _proxy.blockIndent();
  
  /// Outdents the current line by the current [session.tabSize].
  void blockOutdent() => _proxy.blockOutdent();
  
  /// Blurs the current [textInput].
  void blur() => _proxy.blur();
  
  void centerSelection() => _proxy.centerSelection();
  void clearSelection() => _proxy.clearSelection();
  int copyLinesDown() => _proxy.copyLinesDown();
  int copyLinesUp() => _proxy.copyLinesUp();
  void exitMultiSelectMode() => _proxy.exitMultiSelectMode();
  
  /// Brings the current [textInput] into focus.
  void focus() => _proxy.focus();
  
  void gotoPageDown() => _proxy.gotoPageDown();
  void gotoPageUp() => _proxy.gotoPageUp();
  void indent() => _proxy.indent();
  
  /// Insert [text] at the current [cursorPosition].
  void insert(String text) => _proxy.insert(text);
  
  bool isRowFullyVisible(int row) => _proxy.isRowFullyVisible(row);
  bool isRowVisible(int row) => _proxy.isRowVisible(row);
  
  /// Move the cursor down in the document the specified number of times.
  /// Note that this does de-select the current [selection].
  void navigateDown(int times) => _proxy.navigateDown(times);
  
  /// Move the cursor to the end of the current document.
  /// Note that this does de-select the current [selection].
  void navigateFileEnd() => _proxy.navigateFileEnd();
  
  /// Move the cursor to the start of the current document.
  /// Note that this does de-select the current [selection].
  void navigateFileStart() => _proxy.navigateFileStart();
  
  /// Move the cursor left in the document the specified number of times.
  /// Note that this does de-select the current [selection].
  void navigateLeft(int times) => _proxy.navigateLeft(times);
  
  /// Move the [cursorPosition] to the end of the current line.
  /// Note that this does de-select the current [selection].
  void navigateLineEnd() => _proxy.navigateLineEnd();
  
  /// Move the [cursorPosition] to the start of the current line.
  /// Note that this does de-select the current [selection].
  void navigateLineStart() => _proxy.navigateLineStart();
  
  /// Move the [cursorPosition] right in the document the specified number of 
  /// times.  Note that this does de-select the current [selection].
  void navigateRight(int times) => _proxy.navigateRight(times);
  
  /// Move the [cursorPosition] to the specified [row] and [column].
  /// Note that this does de-select the current selection.
  void navigateTo(int row, int column) => _proxy.navigateTo(row, column);
  
  /// Move the [cursorPosition] up in the document the specified number of 
  /// times.  Note that this does de-select the current [selection].
  void navigateUp(int times) => _proxy.navigateUp(times);
  
  /// Move the [cursorPosition] to the word immediately to its left. 
  /// Note that this does de-select the current [selection].
  void navigateWordLeft() => _proxy.navigateWordLeft();
  
  /// Move the [cursorPosition] to the word immediately to its right. 
  /// Note that this does de-select the current [selection].
  void navigateWordRight() => _proxy.navigateWordRight();
  
  /// Remove all of the words to the right of the current [selection], until the 
  /// end of the line.
  void removeToLineEnd() => _proxy.removeToLineEnd();
  
  /// Removes all of the words to the left of the current [selection], until the 
  /// start of the line.
  void removeToLineStart() => _proxy.removeToLineStart();
  
  /// Remove the word directly to the left of the current [selection].
  void removeWordLeft() => _proxy.removeWordLeft();
  
  /// Remove the word directly to the right of the current [selection].
  void removeWordRight() => _proxy.removeWordRight();  
  
  void resize(bool force) => _proxy.resize(force);
  String setValue(String val, int cursorPos) {
    assert(cursorPos >= -1 && cursorPos <= 1);
    return _proxy.setValue(val, cursorPos);
  }
  
  /// Sets the value of [overwrite] to the opposite of its current value.
  void toggleOverwrite() => _proxy.toggleOverwrite();
  
  void toLowerCase() => _proxy.toLowerCase();
  void toUpperCase() => _proxy.toUpperCase();
  void transposeLetters() => _proxy.transposeLetters();
  void updateSelectionMarkers() => _proxy.updateSelectionMarkers();
}
