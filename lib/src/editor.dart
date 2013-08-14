part of ace;

class Editor extends _HasProxy {
  js.Callback _jsOnBlur;
  js.Callback _jsOnChange;
  js.Callback _jsOnCopy;
  js.Callback _jsOnFocus;
  js.Callback _jsOnPaste;
  
  final _onBlur = new StreamController.broadcast();
  final _onChange = new StreamController<Delta>.broadcast();
  final _onCopy = new StreamController<String>.broadcast();
  final _onFocus = new StreamController.broadcast();
  final _onPaste = new StreamController<String>.broadcast();
  
  Stream get onBlur => _onBlur.stream;
  Stream<Delta> get onChange => _onChange.stream;
  Stream<String> get onCopy => _onCopy.stream;
  Stream get onFocus => _onFocus.stream;
  Stream<String> get onPaste => _onPaste.stream;  
  
  String get copyText => _proxy.getCopyText();
  
  Point get cursorPosition => new Point._fromProxy(_proxy.getCursorPosition());
  
  int
    get dragDelay => _proxy.getDragDelay();
    set dragDelay(int dragDelay) => _proxy.setDragDelay(dragDelay);
  
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
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
    
  bool get isFocused => _proxy.isFocused();
  
  bool
    get overwrite => _proxy.getOverwrite();
    set overwrite(bool overwrite) => _proxy.setOverwrite(overwrite);
  
  int
    get printMarginColumn => _proxy.getPrintMarginColumn();
    set printMarginColumn(int printMarginColumn) => 
        _proxy.setPrintMarginColumn(printMarginColumn);
    
  bool
    get readOnly => _proxy.getReadOnly();
    set readOnly(bool readOnly) => _proxy.setReadOnly(readOnly);
  
  int
    get scrollSpeed => _proxy.getScrollSpeed();
    set scrollSpeed(int scrollSpeed) => _proxy.setScrollSpeed(scrollSpeed);
    
  Selection get selection => new Selection._(_proxy.getSelection());
  Range get selectionRange => new Range._fromProxy(_proxy.getSelectionRange());
  
  EditSession _session;
  EditSession get session {
    if (_session == null) {
      _session = new EditSession._(_proxy.getSession());
    }
    return _session;
  }
  
  bool
    get showInvisibles => _proxy.getShowInvisibles();
    set showInvisibles(bool showInvisibles) => 
        _proxy.setShowInvisibles(showInvisibles);
  
  String
    get theme => _proxy.getTheme();
    set theme(String theme) => _proxy.setTheme(theme);
  
  String get value => _proxy.getValue();
    
  Editor._(js.Proxy proxy) : super(proxy) {
    _jsOnBlur = new js.Callback.many((_,__) => _onBlur.add(this));
    _jsOnChange = new js.Callback.many((e,__) {
      Delta delta = new Delta._for(e.data);
      _onChange.add(delta); 
    });
    _jsOnCopy = new js.Callback.many((e,__) => _onCopy.add(e));
    _jsOnFocus = new js.Callback.many((_,__) => _onFocus.add(this));
    _jsOnPaste = new js.Callback.many((e,__) => _onPaste.add(e));
    _proxy.on('blur', _jsOnBlur);
    _proxy.on('change', _jsOnChange);
    _proxy.on('copy', _jsOnCopy);
    _proxy.on('focus', _jsOnFocus);
    _proxy.on('paste', _jsOnPaste);
  }
  
  void _onDispose() {
    if (_session != null) _session.dispose();
    _onBlur.close();
    _onChange.close();
    _onCopy.close();
    _onFocus.close();
    _onPaste.close();
    _jsOnBlur.dispose();
    _jsOnChange.dispose();
    _jsOnCopy.dispose();
    _jsOnFocus.dispose();
    _jsOnPaste.dispose();
    _proxy.destroy();
  }
  
  void alignCursors() => _proxy.alignCursors();
  void blockIndent() => _proxy.blockIndent();
  void blockOutdent() => _proxy.blockOutdent();
  void blur() => _proxy.blur();
  void centerSelection() => _proxy.centerSelection();
  void clearSelection() => _proxy.clearSelection();
  int copyLinesDown() => _proxy.copyLinesDown();
  int copyLinesUp() => _proxy.copyLinesUp();
  void exitMultiSelectMode() => _proxy.exitMultiSelectMode();
  void focus() => _proxy.focus();
  void gotoPageDown() => _proxy.gotoPageDown();
  void gotoPageUp() => _proxy.gotoPageUp();
  void indent() => _proxy.indent();
  /// Insert [text] at the current [cursorPosition].
  void insert(String text) => _proxy.insert(text);
  bool isRowFullyVisible(int row) => _proxy.isRowFullyVisible(row);
  bool isRowVisible(int row) => _proxy.isRowVisible(row);
  void navigateFileEnd() => _proxy.navigateFileEnd();
  void navigateFileStart() => _proxy.navigateFileStart();
  void navigateLeft(int times) => _proxy.navigateLeft(times);
  /// Move the [cursorPosition] to the end of the current line.
  /// Note that this does de-select the current [selection].
  void navigateLineEnd() => _proxy.navigateLineEnd();
  void navigateLineStart() => _proxy.navigateLineStart();
  void navigateRight(int times) => _proxy.navigateRight(times);
  void navigateTo(int row, int column) => _proxy.navigateTo(row, column);
  void navigateUp(int times) => _proxy.navigateUp(times);
  void navigateWordLeft() => _proxy.navigateWordLeft();
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
  void toggleOverwrite() => _proxy.toggleOverwrite();
  void toLowerCase() => _proxy.toLowerCase();
  void toUpperCase() => _proxy.toUpperCase();
  void transposeLetters() => _proxy.transposeLetters();
  void updateSelectionMarkers() => _proxy.updateSelectionMarkers();
}
