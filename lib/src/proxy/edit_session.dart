part of ace;

class _EditSessionProxy extends _HasProxy implements EditSession {

  js.Callback _jsOnChange;
  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;
  
  js.Callback _jsOnChangeBreakpoint;
  final _onChangeBreakpoint = new StreamController.broadcast();
  Stream get onChangeBreakpoint => _onChangeBreakpoint.stream;
  
  js.Callback _jsOnChangeOverwrite;
  final _onChangeOverwrite = new StreamController.broadcast();
  Stream get onChangeOverwrite => _onChangeOverwrite.stream;
  
  js.Callback _jsOnChangeScrollLeft;
  final _onChangeScrollLeft = new StreamController<int>.broadcast();
  Stream<int> get onChangeScrollLeft => _onChangeScrollLeft.stream;
  
  js.Callback _jsOnChangeScrollTop;
  final _onChangeScrollTop = new StreamController<int>.broadcast();
  Stream<int> get onChangeScrollTop => _onChangeScrollTop.stream;
  
  js.Callback _jsOnChangeTabSize;
  final _onChangeTabSize = new StreamController.broadcast();
  Stream get onChangeTabSize => _onChangeTabSize.stream;
  
  js.Callback _jsOnChangeWrapLimit;
  final _onChangeWrapLimit = new StreamController.broadcast();
  Stream get onChangeWrapLimit => _onChangeWrapLimit.stream;
  
  js.Callback _jsOnChangeWrapMode;
  final _onChangeWrapMode = new StreamController.broadcast();
  Stream get onChangeWrapMode => _onChangeWrapMode.stream;
  
  Map<int, String> get breakpoints => _list(_proxy.getBreakpoints()).asMap();
  
  Document
    get document => new _DocumentProxy._(_proxy.getDocument());
    set document(Document document) {
      assert(document is _DocumentProxy);
      _proxy.setDocument((document as _DocumentProxy)._proxy);
    }

  int get length => _proxy.getLength();
  
  Mode
    get mode => new _ModeProxy._(_proxy.getMode());
    set mode(Mode mode) {
      assert(mode is _ModeProxy);
      _proxy.setMode((mode as _ModeProxy)._mode);
    }
    
  String
    get newLineMode => _proxy.getNewLineMode();
    set newLineMode(String newLineMode) => _proxy.setNewLineMode(newLineMode);
  
  bool
    get overwrite => _proxy.getOverwrite();
    set overwrite(bool overwrite) => _proxy.setOverwrite(overwrite);
  
  int get screenLength => _proxy.getScreenLength();

  int get screenWidth => _proxy.getScreenWidth();
  
  int
    get scrollLeft => _proxy.getScrollLeft().toInt();
    set scrollLeft(int scrollLeft) => _proxy.setScrollLeft(scrollLeft);  

  int
    get scrollTop => _proxy.getScrollTop().toInt();
    set scrollTop(int scrollTop) => _proxy.setScrollTop(scrollTop);

  int
    get tabSize => _proxy.getTabSize();
    set tabSize(int tabSize) => _proxy.setTabSize(tabSize);

  String get tabString => _proxy.getTabString();
  
  UndoManager
    get undoManager => new _UndoManagerProxy._(_proxy.getUndoManager());
    set undoManager(UndoManager undoManager) => throw new UnimplementedError();
  
  bool
    get undoSelect => _proxy.$undoSelect;
    set undoSelect(bool enable) => _proxy.setUndoSelect(enable);

  bool
    get useSoftTabs => _proxy.getUseSoftTabs();
    set useSoftTabs(bool useSoftTabs) => _proxy.setUseSoftTabs(useSoftTabs);
  
  bool
    get useWorker => _proxy.getUseWorker();
    set useWorker(bool useWorker) => _proxy.setUseWorker(useWorker);
  
  bool
    get useWrapMode => _proxy.getUseWrapMode();
    set useWrapMode(bool useWrapMode) => _proxy.setUseWrapMode(useWrapMode);
  
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);
  
  int get wrapLimit => _proxy.getWrapLimit();

  Map get wrapLimitRange => _map(_proxy.getWrapLimitRange());
  
  _EditSessionProxy(Document document, Mode mode) 
  : this._(
      new js.Proxy(_context.ace.EditSession, 
          (document as _DocumentProxy)._proxy, (mode as _ModeProxy)._mode));
  
  _EditSessionProxy._(js.Proxy proxy) : super(proxy) {    
    _jsOnChange = new js.Callback.many((e,__) => 
        _onChange.add(new Delta._forProxy(e.data)));
    _jsOnChangeBreakpoint =
        new js.Callback.many((_,__) => _onChangeBreakpoint.add(this));
    _jsOnChangeOverwrite = 
        new js.Callback.many((_,__) => _onChangeOverwrite.add(this));
    _jsOnChangeScrollLeft = 
        new js.Callback.many((e,__) => _onChangeScrollLeft.add(e.toInt()));
    _jsOnChangeScrollTop = 
        new js.Callback.many((e,__) => _onChangeScrollTop.add(e.toInt()));
    _jsOnChangeTabSize = 
        new js.Callback.many((_,__) => _onChangeTabSize.add(this));
    _jsOnChangeWrapLimit = 
        new js.Callback.many((_,__) => _onChangeWrapLimit.add(this));
    _jsOnChangeWrapMode = 
        new js.Callback.many((_,__) => _onChangeWrapMode.add(this));
    _proxy.on('change', _jsOnChange);
    _proxy.on('changeBreakpoint', _jsOnChangeBreakpoint);
    _proxy.on('changeOverwrite', _jsOnChangeOverwrite);
    _proxy.on('changeScrollLeft', _jsOnChangeScrollLeft);
    _proxy.on('changeScrollTop', _jsOnChangeScrollTop);
    _proxy.on('changeTabSize', _jsOnChangeTabSize);
    _proxy.on('changeWrapLimit', _jsOnChangeWrapLimit);
    _proxy.on('changeWrapMode', _jsOnChangeWrapMode);
  }
  
  void _onDispose() {
    _onChange.close();
    _onChangeBreakpoint.close();
    _onChangeOverwrite.close();
    _onChangeScrollLeft.close();
    _onChangeScrollTop.close();
    _onChangeTabSize.close();
    _onChangeWrapLimit.close();
    _onChangeWrapMode.close();   
    _jsOnChange.dispose();
    _jsOnChangeBreakpoint.dispose();
    _jsOnChangeOverwrite.dispose();
    _jsOnChangeScrollLeft.dispose();
    _jsOnChangeScrollTop.dispose();
    _jsOnChangeTabSize.dispose();
    _jsOnChangeWrapLimit.dispose();
    _jsOnChangeWrapMode.dispose();
  }
  
  void addGutterDecoration(int row, String className) =>
      _proxy.addGutterDecoration(row, className);
  
  bool adjustWrapLimit(int desiredLimit, int printMargin) =>
      _proxy.adjustWrapLimit(desiredLimit, printMargin);
  
  void clearBreakpoint(int row) => _proxy.clearBreakpoint(row);
  
  void clearBreakpoints() => _proxy.clearBreakpoints();
  
  int documentToScreenColumn(int row, int column) =>
      _proxy.documentToScreenColumn(row, column);
  
  int documentToScreenRow(int row, int column) => 
      _proxy.documentToScreenRow(row, column);
  
  int duplicateLines(int firstRow, int lastRow) =>
      _proxy.duplicateLines(firstRow, lastRow);
  
  Range getAWordRange(int row, int column) =>
      new Range._(_proxy.getAWordRange(row, column));
  
  String getLine(int row) => _proxy.getLine(row);
  
  int getRowLength(int row) => _proxy.getRowLength(row);
  
  String getTextRange(Range range) => _proxy.getTextRange(range._toProxy());
  
  Range getWordRange(int row, int column) => 
      new Range._(_proxy.getWordRange(row, column));      

  void indentRows(int startRow, int endRow, String indentString) =>
      _proxy.indentRows(startRow, endRow, indentString);
  
  Point insert(Point position, String text) =>
      new Point._(_proxy.insert(position._toProxy(), text));
  
  bool isTabStop(Point position) => _proxy.isTabStop(position._toProxy());
  
  int moveLinesDown(int firstRow, int lastRow) =>
      _proxy.moveLinesDown(firstRow, lastRow);
  
  int moveLinesUp(int firstRow, int lastRow) =>
      _proxy.moveLinesUp(firstRow, lastRow);
  
  Point remove(Range range) => new Point._(_proxy.remove(range._toProxy()));
  
  void removeGutterDecoration(int row, String className) =>
      _proxy.removeGutterDecoration(row, className);
  
  Point replace(Range range, String text) => 
      new Point._(_proxy.replace(range._toProxy(), text));
  
  Point screenToDocumentPosition(int row, int column) =>
      new Point._(_proxy.screenToDocumentPosition(row, column));
  
  void setBreakpoint(int row, {String className: 'ace_breakpoint'}) =>
      _proxy.setBreakpoint(row, className);
  
  void setBreakpoints(List<int> rows) => _proxy.setBreakpoints(js.array(rows));
  
  void setWrapLimitRange({int min, int max}) => 
      _proxy.setWrapLimitRange(min, max);
  
  void toggleOverwrite() => _proxy.toggleOverwrite();
  
  String toString() => _proxy.toString();
}
