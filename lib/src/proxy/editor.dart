part of ace;

class _EditorProxy extends _HasProxy implements Editor {
  
  js.Callback _jsOnBlur;
  js.Callback _jsOnChange;
  js.Callback _jsOnChangeSession;
  js.Callback _jsOnCopy;
  js.Callback _jsOnFocus;
  js.Callback _jsOnPaste;
  
  final _onBlur = new StreamController.broadcast();
  final _onChange = new StreamController<Delta>.broadcast();
  final _onChangeSession = 
      new StreamController<EditSessionChangeEvent>.broadcast();
  final _onCopy = new StreamController<String>.broadcast();
  final _onFocus = new StreamController.broadcast();
  final _onPaste = new StreamController<String>.broadcast();
  
  Stream get onBlur => _onBlur.stream;
  
  Stream<Delta> get onChange => _onChange.stream;
  
  Stream<EditSessionChangeEvent> get onChangeSession => 
      _onChangeSession.stream;
  
  Stream<String> get onCopy => _onCopy.stream;
  
  Stream get onFocus => _onFocus.stream;
  
  Stream<String> get onPaste => _onPaste.stream;  
  
  String get copyText => _proxy.getCopyText();
  
  Point get cursorPosition => new Point._(_proxy.getCursorPosition());
  
  int
    get dragDelay => _proxy.getDragDelay();
    set dragDelay(int dragDelay) => _proxy.setDragDelay(dragDelay);
  
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
  int
    get fontSize => _proxy.getFontSize();
    set fontSize(int fontSize) => _proxy.setFontSize(fontSize);
  
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
  
  VirtualRenderer get renderer => new _VirtualRendererProxy._(_proxy.renderer);
  
  int
    get scrollSpeed => _proxy.getScrollSpeed();
    set scrollSpeed(int scrollSpeed) => _proxy.setScrollSpeed(scrollSpeed);
    
  Selection get selection => new _SelectionProxy._(_proxy.getSelection());
  
  Range get selectionRange => new Range._(_proxy.getSelectionRange());
  
  EditSession
    get session => new _EditSessionProxy._(_proxy.getSession());
    set session(EditSession session) { 
      assert(session is _EditSessionProxy);
      _proxy.setSession((session as _EditSessionProxy)._proxy);
    }
  
  bool
    get showInvisibles => _proxy.getShowInvisibles();
    set showInvisibles(bool showInvisibles) => 
        _proxy.setShowInvisibles(showInvisibles);
  
  bool
    get showPrintMargin => _proxy.getShowPrintMargin();
    set showPrintMargin(bool showPrintMargin) => 
        _proxy.setShowPrintMargin(showPrintMargin);
    
  TextInput get textInput => new _TextInputProxy._(_proxy.textInput);
    
  Theme
    get theme => new _ThemeProxy(_proxy.getTheme());
    set theme(Theme theme) {
      assert(theme is _ThemeProxy);
      _proxy.setTheme((theme as _ThemeProxy)._theme);
    }
  
  String get value => _proxy.getValue();
    
  _EditorProxy._(js.Proxy proxy) : super(proxy) {
    _jsOnBlur = new js.Callback.many((_,__) => _onBlur.add(this));
    _jsOnChange = new js.Callback.many((e,__) =>
        _onChange.add(new Delta._forProxy(e.data)));
    _jsOnChangeSession = new js.Callback.many((e,__) {
      _onChangeSession.add(new EditSessionChangeEvent._(
          new _EditSessionProxy._(e.oldSession),
          new _EditSessionProxy._(e.session))); 
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
  
  void insert(String text) => _proxy.insert(text);
  
  bool isRowFullyVisible(int row) => _proxy.isRowFullyVisible(row);
  
  bool isRowVisible(int row) => _proxy.isRowVisible(row);
  
  void navigateDown([int times = 1]) => _proxy.navigateDown(times);
  
  void navigateFileEnd() => _proxy.navigateFileEnd();
  
  void navigateFileStart() => _proxy.navigateFileStart();
  
  void navigateLeft([int times = 1]) => _proxy.navigateLeft(times);
  
  void navigateLineEnd() => _proxy.navigateLineEnd();
  
  void navigateLineStart() => _proxy.navigateLineStart();
  
  void navigateRight([int times = 1]) => _proxy.navigateRight(times);
  
  void navigateTo(int row, int column) => _proxy.navigateTo(row, column);
  
  void navigateUp([int times = 1]) => _proxy.navigateUp(times);
  
  void navigateWordLeft() => _proxy.navigateWordLeft();
  
  void navigateWordRight() => _proxy.navigateWordRight();
  
  void redo() => _proxy.redo();
  
  void removeToLineEnd() => _proxy.removeToLineEnd();
  
  void removeToLineStart() => _proxy.removeToLineStart();
  
  void removeWordLeft() => _proxy.removeWordLeft();
  
  void removeWordRight() => _proxy.removeWordRight();  
  
  void resize(bool force) => _proxy.resize(force);
  
  void selectAll() => _proxy.selectAll();
  
  String setValue(String value, [int cursorPosition = 0]) {
    assert(cursorPosition >= -1 && cursorPosition <= 1);
    return _proxy.setValue(value, cursorPosition);
  }
  
  void toggleOverwrite() => _proxy.toggleOverwrite();
  
  void toLowerCase() => _proxy.toLowerCase();
  
  void toUpperCase() => _proxy.toUpperCase();
  
  void transposeLetters() => _proxy.transposeLetters();
  
  void undo() => _proxy.undo();
  
  void updateSelectionMarkers() => _proxy.updateSelectionMarkers();
}
