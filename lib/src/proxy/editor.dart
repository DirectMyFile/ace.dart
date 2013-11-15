part of ace;

class _EditorProxy extends _HasProxy implements Editor {
  
  final _onBlur = new StreamController.broadcast();
  Stream get onBlur => _onBlur.stream;

  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;
  
  final _onChangeSession = 
      new StreamController<EditSessionChangeEvent>.broadcast();
  Stream<EditSessionChangeEvent> get onChangeSession => 
      _onChangeSession.stream;
  
  final _onCopy = new StreamController<String>.broadcast();
  Stream<String> get onCopy => _onCopy.stream;
  
  final _onFocus = new StreamController.broadcast();
  Stream get onFocus => _onFocus.stream;
  
  final _onPaste = new StreamController<String>.broadcast();
  Stream<String> get onPaste => _onPaste.stream;  
  
  String get copyText => call('getCopyText');
  
  Point get cursorPosition => new Point._(call('getCursorPosition'));
  
  int
    get dragDelay => call('getDragDelay');
    set dragDelay(int dragDelay) => call('setDragDelay', [dragDelay]);
  
  int get firstVisibleRow => call('getFirstVisibleRow');
  
  int
    get fontSize => call('getFontSize');
    set fontSize(int fontSize) => call('setFontSize', [fontSize]);
  
  bool
    get highlightActiveLine => call('getHighlightActiveLine');
    set highlightActiveLine(bool highlightActiveLine) =>
        call('setHighlightActiveLine', [highlightActiveLine]);
    
  bool
    get highlightGutterLine => call('getHighlightGutterLine');
    set highlightGutterLine(bool highlightGutterLine) =>
        call('setHighlightGutterLine', [highlightGutterLine]);
    
  bool
    get highlightSelectedWord => call('getHighlightSelectedWord');
    set highlightSelectedWord(bool highlightSelectedWord) =>
        call('setHighlightSelectedWord', [highlightSelectedWord]);
  
  bool get isFocused => call('isFocused');
  
  KeyBinding get keyBinding => new _KeyBindingProxy._(_proxy['keyBinding']);
  
  KeyboardHandler
    get keyboardHandler => 
        new _KeyboardHandlerProxy._(call('getKeyboardHandler'));
    set keyboardHandler(KeyboardHandler keyboardHandler) {
      assert(keyboardHandler is _KeyboardHandlerProxy);
      call('setKeyboardHandler', 
          [(keyboardHandler as _KeyboardHandlerProxy)._handler]);
    }
    
  bool
    get overwrite => call('getOverwrite');
    set overwrite(bool overwrite) => call('setOverwrite', [overwrite]);
  
  int
    get printMarginColumn => call('getPrintMarginColumn');
    set printMarginColumn(int printMarginColumn) => 
        call('setPrintMarginColumn', [printMarginColumn]);
  
  bool
    get readOnly => call('getReadOnly');
    set readOnly(bool readOnly) => call('setReadOnly', [readOnly]);
  
  VirtualRenderer get renderer => 
      new _VirtualRendererProxy._(_proxy['renderer']);
  
  int
    get scrollSpeed => call('getScrollSpeed');
    set scrollSpeed(int scrollSpeed) => call('setScrollSpeed', [scrollSpeed]);
    
  Selection get selection => new _SelectionProxy._(call('getSelection'));
  
  Range get selectionRange => new Range._(call('getSelectionRange'));
  
  EditSession
    get session => new _EditSessionProxy._(call('getSession'));
    set session(EditSession session) { 
      assert(session is _EditSessionProxy);
      call('setSession', [(session as _EditSessionProxy)._proxy]);
    }
  
  bool
    get showInvisibles => call('getShowInvisibles');
    set showInvisibles(bool showInvisibles) => 
        call('setShowInvisibles', [showInvisibles]);
  
  bool
    get showPrintMargin => call('getShowPrintMargin');
    set showPrintMargin(bool showPrintMargin) => 
        call('setShowPrintMargin', [showPrintMargin]);
    
  TextInput get textInput => new _TextInputProxy._(_proxy['textInput']);
    
  Theme
    get theme => new _ThemeProxy(call('getTheme'));
    set theme(Theme theme) {
      assert(theme is _ThemeProxy);
      call('setTheme', [(theme as _ThemeProxy)._theme]);
    }
  
  String get value => call('getValue');
    
  _EditorProxy._(js.JsObject proxy) : super(proxy) {
    call('on', ['blur', (_,__) => _onBlur.add(this)]);
    call('on', ['change', (e,__) =>
        _onChange.add(new Delta._forProxy(e['data']))]);
    call('on', ['changeSession', (e,__) {
      _onChangeSession.add(new EditSessionChangeEvent._(
          new _EditSessionProxy._(e['oldSession']),
          new _EditSessionProxy._(e['session']))); 
    }]);
    call('on', ['copy', (e,__) => _onCopy.add(e)]);
    call('on', ['focus', (_,__) => _onFocus.add(this)]);
    call('on', ['paste', (e,__) => _onPaste.add(e)]);
  }
  
  void _onDispose() {
    _onBlur.close();
    _onChange.close();
    _onChangeSession.close();
    _onCopy.close();
    _onFocus.close();
    _onPaste.close();
    call('destroy');
  }
  
  void alignCursors() => call('alignCursors');
  
  void blockIndent() => call('blockIndent');
  
  void blockOutdent() => call('blockOutdent');
  
  void blur() => call('blur');
  
  void centerSelection() => call('centerSelection');
  
  void clearSelection() => call('clearSelection');
  
  int copyLinesDown() => call('copyLinesDown');
  
  int copyLinesUp() => call('copyLinesUp');
  
  void exitMultiSelectMode() => call('exitMultiSelectMode');
  
  void focus() => call('focus');  
  
  getOption(String name) => call('getOption', [name]);
  
  Map<String, dynamic> getOptions(List<String> optionNames) =>
      _map(call('getOptions', [_jsify(optionNames)]));  
  
  void gotoPageDown() => call('gotoPageDown');
  
  void gotoPageUp() => call('gotoPageUp');
  
  void indent() => call('indent');
  
  void insert(String text) => call('insert', [text]);
  
  bool isRowFullyVisible(int row) => call('isRowFullyVisible', [row]);
  
  bool isRowVisible(int row) => call('isRowVisible', [row]);
  
  void navigateDown([int times = 1]) => call('navigateDown', [times]);
  
  void navigateFileEnd() => call('navigateFileEnd');
  
  void navigateFileStart() => call('navigateFileStart');
  
  void navigateLeft([int times = 1]) => call('navigateLeft', [times]);
  
  void navigateLineEnd() => call('navigateLineEnd');
  
  void navigateLineStart() => call('navigateLineStart');
  
  void navigateRight([int times = 1]) => call('navigateRight', [times]);
  
  void navigateTo(int row, int column) => call('navigateTo', [row, column]);
  
  void navigateUp([int times = 1]) => call('navigateUp', [times]);
  
  void navigateWordLeft() => call('navigateWordLeft');
  
  void navigateWordRight() => call('navigateWordRight');
  
  void redo() => call('redo');
  
  void removeToLineEnd() => call('removeToLineEnd');
  
  void removeToLineStart() => call('removeToLineStart');
  
  void removeWordLeft() => call('removeWordLeft');
  
  void removeWordRight() => call('removeWordRight');  
  
  void resize(bool force) => call('resize', [force]);
  
  void scrollPageDown() => call('scrollPageDown');
  
  void scrollPageUp() => call('scrollPageUp');
  
  void selectAll() => call('selectAll');
  
  void setOption(String name, value) => call('setOption', [name, value]);
  
  void setOptions(Map<String, dynamic> options) => 
      call('setOptions', [_jsify(options)]);
  
  String setValue(String value, [int cursorPosition = 0]) {
    assert(cursorPosition >= -1 && cursorPosition <= 1);
    return call('setValue', [value, cursorPosition]);
  }
  
  void toggleOverwrite() => call('toggleOverwrite');
  
  void toLowerCase() => call('toLowerCase');
  
  void toUpperCase() => call('toUpperCase');
  
  void transposeLetters() => call('transposeLetters');
  
  void undo() => call('undo');
  
  void updateSelectionMarkers() => call('updateSelectionMarkers');
}