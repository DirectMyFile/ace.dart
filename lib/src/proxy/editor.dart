part of ace.proxy;

class _EditorProxy extends HasProxy implements Editor {
  
  _Event<Null> _onBlur;
  Stream<Null> get onBlur {
    if (_onBlur == null) {
      _onBlur = new _Event<Null>(this, 'blur');
    }
    return _onBlur.stream;
  }
  
  _Event<LinkEvent> _onLinkClick;
  Stream<LinkEvent> get onLinkClick {
    if (_onLinkClick == null) {
      _onLinkClick = new _Event<LinkEvent>(this, 'linkClick', _linkEvent);
    }
    return _onLinkClick.stream;
  }
  
  _Event<LinkEvent> _onLinkHover;
  Stream<LinkEvent> get onLinkHover {
    if (_onLinkHover == null) {
      _onLinkHover = new _Event<LinkEvent>(this, 'linkHover', _linkEvent);
    }
    return _onLinkHover.stream;
  }
  
  _Event<Delta> _onChange;
  Stream<Delta> get onChange {
    if (_onChange == null) {
      _onChange = new _Event<Delta>(this, 'change', (e) => _delta(e['data']));
    }
    return _onChange.stream;
  }
  
  _Event<Null> _onChangeSelection;
  Stream<Null> get onChangeSelection {
    if (_onChangeSelection == null) {
      _onChangeSelection = new _Event<Null>(this, 'changeSelection');
    }
    return _onChangeSelection.stream;
  }
  
  _Event<EditSessionChangeEvent> _onChangeSession;
  Stream<EditSessionChangeEvent> get onChangeSession { 
    if (_onChangeSession == null) {
      _onChangeSession = new _Event<EditSessionChangeEvent>(this, 
          'changeSession', (e) => new EditSessionChangeEvent(
              new _EditSessionProxy._(e['oldSession']),
              new _EditSessionProxy._(e['session'])));
    }
    return _onChangeSession.stream;
  }
  
  _Event<String> _onCopy;
  Stream<String> get onCopy {
    if (_onCopy == null) {
      _onCopy = new _Event<String>(this, 'copy', (e) => e);
    }
    return _onCopy.stream;
  }
  
  _Event<Null> _onFocus;
  Stream<Null> get onFocus {
    if (_onFocus == null) {
      _onFocus = new _Event<Null>(this, 'focus');
    }
    return _onFocus.stream;
  }
  
  _Event<String> _onPaste;
  Stream<String> get onPaste {
    if (_onPaste == null) {
      _onPaste = new _Event<String>(this, 'paste', (e) => e['text']);
    }
    return _onPaste.stream;  
  }
  
  CommandManager get commands => new _CommandManagerProxy._(_proxy['commands']);
  
  String get copyText => call('getCopyText');
  
  Point get cursorPosition => _point(call('getCursorPosition'));
  
  int
    get dragDelay => call('getDragDelay');
    set dragDelay(int dragDelay) => call('setDragDelay', [dragDelay]);
  
  bool
    get fadeFoldWidgets => call('getFadeFoldWidgets');
    set fadeFoldWidgets(bool value) => call('setFadeFoldWidgets', [value]);
  
  bool
    get showFoldWidgets => call('getShowFoldWidgets');
    set showFoldWidgets(bool value) => call('setShowFoldWidgets', [value]);
  
  int get firstVisibleRow => call('getFirstVisibleRow');
  
  int get lastVisibleRow => call('getLastVisibleRow');
  
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
  
  Range get selectionRange => _range(call('getSelectionRange'));
  
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
  
  _EditorProxy(_VirtualRendererProxy renderer, _EditSessionProxy session) 
    : this._(new js.JsObject(_modules['ace/editor']['Editor'],
        [renderer.jsProxy, session.jsProxy]));
  
  _EditorProxy._(js.JsObject proxy) : super(proxy) {
    // TODO: suppress warning: https://github.com/rmsmith/ace.dart/issues/53
    proxy[r'$blockScrolling'] = double.INFINITY;
  }
  
  Future _onDispose() {    
    final List<Future> f = new List<Future>();
    if (_onBlur != null) f.add(_onBlur.dispose());
    if (_onLinkClick != null) f.add(_onLinkClick.dispose());
    if (_onLinkHover != null) f.add(_onLinkHover.dispose());
    if (_onChange != null) f.add(_onChange.dispose());
    if (_onChangeSelection != null) f.add(_onChangeSelection.dispose());
    if (_onChangeSession != null) f.add(_onChangeSession.dispose());
    if (_onCopy != null) f.add(_onCopy.dispose());
    if (_onFocus != null) f.add(_onFocus.dispose());
    if (_onPaste != null) f.add(_onPaste.dispose());
    return Future.wait(f);
  }
  
  void alignCursors() => call('alignCursors');
  
  void blockIndent() => call('blockIndent');
  
  void blockOutdent() => call('blockOutdent');
  
  void blur() => call('blur');
  
  void centerSelection() => call('centerSelection');
  
  void clearSelection() => call('clearSelection');
  
  int copyLinesDown() => call('copyLinesDown');
  
  int copyLinesUp() => call('copyLinesUp');
  
  void destroy() => call('destroy');
  
  void execCommand(String commandName) => call('execCommand', [commandName]);
  
  void exitMultiSelectMode() => call('exitMultiSelectMode');
  
  void focus() => call('focus');  
  
  getOption(String name) => call('getOption', [name]);
  
  Map<String, dynamic> getOptions(List<String> optionNames) =>
      _map(call('getOptions', [_jsArray(optionNames)]));  
  
  void gotoLine(int lineNumber, [int column = 0, bool animate = false]) =>
      call('gotoLine', [lineNumber, column, animate]);
  
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
  
  void paste(String text) => call('onPaste', [text]);
  
  void redo() => call('redo');
  
  void removeToLineEnd() => call('removeToLineEnd');
  
  void removeToLineStart() => call('removeToLineStart');
  
  void removeWordLeft() => call('removeWordLeft');
  
  void removeWordRight() => call('removeWordRight');  
  
  void resize(bool force) => call('resize', [force]);
  
  void scrollPageDown() => call('scrollPageDown');
  
  void scrollPageUp() => call('scrollPageUp');
  
  void scrollToLine(int line, {bool center: false, bool animate: false}) =>
    call('scrollToLine', [line, center, animate]);
  
  void scrollToRow(int row) => call('scrollToRow', [row]);
  
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
