part of ace;

class _EditSessionProxy extends _HasProxy implements EditSession {

  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;
  
  final _onChangeBreakpoint = new StreamController.broadcast();
  Stream get onChangeBreakpoint => _onChangeBreakpoint.stream;
  
  final _onChangeOverwrite = new StreamController.broadcast();
  Stream get onChangeOverwrite => _onChangeOverwrite.stream;
  
  final _onChangeScrollLeft = new StreamController<int>.broadcast();
  Stream<int> get onChangeScrollLeft => _onChangeScrollLeft.stream;
  
  final _onChangeScrollTop = new StreamController<int>.broadcast();
  Stream<int> get onChangeScrollTop => _onChangeScrollTop.stream;
  
  final _onChangeTabSize = new StreamController.broadcast();
  Stream get onChangeTabSize => _onChangeTabSize.stream;
  
  final _onChangeWrapLimit = new StreamController.broadcast();
  Stream get onChangeWrapLimit => _onChangeWrapLimit.stream;
  
  final _onChangeWrapMode = new StreamController.broadcast();
  Stream get onChangeWrapMode => _onChangeWrapMode.stream;
  
  Map<int, String> get breakpoints => _list(call('getBreakpoints')).asMap();
  
  Document
    get document => new _DocumentProxy._(call('getDocument'));
    set document(Document document) {
      assert(document is _DocumentProxy);
      call('setDocument', [(document as _DocumentProxy)._proxy]);
    }

  int get length => call('getLength');
  
  Mode
    get mode => new _ModeProxy._(call('getMode'));
    set mode(Mode mode) {
      assert(mode is _ModeProxy);
      call('setMode', [(mode as _ModeProxy)._mode]);
    }
    
  String
    get newLineMode => call('getNewLineMode');
    set newLineMode(String newLineMode) => 
        call('setNewLineMode', [newLineMode]);
  
  bool
    get overwrite => call('getOverwrite');
    set overwrite(bool overwrite) => call('setOverwrite', [overwrite]);
  
  int get screenLength => call('getScreenLength');

  int get screenWidth => call('getScreenWidth');
  
  int
    get scrollLeft => call('getScrollLeft').toInt();
    set scrollLeft(int scrollLeft) => call('setScrollLeft', [scrollLeft]);  

  int
    get scrollTop => call('getScrollTop').toInt();
    set scrollTop(int scrollTop) => call('setScrollTop',[scrollTop]);

  int
    get tabSize => call('getTabSize');
    set tabSize(int tabSize) => call('setTabSize', [tabSize]);

  String get tabString => call('getTabString');
  
  UndoManager
    get undoManager => new _UndoManagerProxy._(call('getUndoManager'));
    set undoManager(UndoManager undoManager) => throw new UnimplementedError();
  
  bool
    get undoSelect => _proxy[r'$undoSelect'];
    set undoSelect(bool undoSelect) => call('setUndoSelect', [undoSelect]);

  bool
    get useSoftTabs => call('getUseSoftTabs');
    set useSoftTabs(bool useSoftTabs) => call('setUseSoftTabs', [useSoftTabs]);
  
  bool
    get useWorker => call('getUseWorker');
    set useWorker(bool useWorker) => call('setUseWorker', [useWorker]);
  
  bool
    get useWrapMode => call('getUseWrapMode');
    set useWrapMode(bool useWrapMode) => call('setUseWrapMode', [useWrapMode]);
  
  String
    get value => call('getValue');
    set value(String text) => call('setValue', [text]);
  
  int get wrapLimit => call('getWrapLimit');

  Map get wrapLimitRange => _map(call('getWrapLimitRange'));
  
  _EditSessionProxy(Document document, Mode mode) 
  : this._(new js.JsObject(_context['ace']['EditSession'], 
      [(document as _DocumentProxy)._proxy, (mode as _ModeProxy)._mode]));
  
  _EditSessionProxy._(js.JsObject proxy) : super(proxy) {
    call('on', ['change', 
                (e,__) => _onChange.add(new Delta._forProxy(e['data']))]);
    call('on', ['changeBreakpoint', (_,__) => _onChangeBreakpoint.add(this)]);
    call('on', ['changeOverwrite', (_,__) => _onChangeOverwrite.add(this)]);
    call('on', ['changeScrollLeft', 
                (e,__) => _onChangeScrollLeft.add(e.toInt())]);
    call('on', ['changeScrollTop', 
                (e,__) => _onChangeScrollTop.add(e.toInt())]);
    call('on', ['changeTabSize', (_,__) => _onChangeTabSize.add(this)]);
    call('on', ['changeWrapLimit', (_,__) => _onChangeWrapLimit.add(this)]);
    call('on', ['changeWrapMode', (_,__) => _onChangeWrapMode.add(this)]);
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
  }
  
  void addGutterDecoration(int row, String className) =>
      call('addGutterDecoration', [row, className]);
  
  bool adjustWrapLimit(int desiredLimit, int printMargin) =>
      call('adjustWrapLimit', [desiredLimit, printMargin]);
  
  void clearBreakpoint(int row) => call('clearBreakpoint', [row]);
  
  void clearBreakpoints() => call('clearBreakpoints');
  
  int documentToScreenColumn(int row, int column) =>
      call('documentToScreenColumn', [row, column]);
  
  int documentToScreenRow(int row, int column) => 
      call('documentToScreenRow', [row, column]);
  
  int duplicateLines(int firstRow, int lastRow) =>
      call('duplicateLines', [firstRow, lastRow]);
  
  Range getAWordRange(int row, int column) =>
      new Range._(call('getAWordRange', [row, column]));
  
  String getLine(int row) => call('getLine', [row]);
  
  int getRowLength(int row) => call('getRowLength', [row]);
  
  String getTextRange(Range range) => call('getTextRange', [range._toProxy()]);
  
  Range getWordRange(int row, int column) => 
      new Range._(call('getWordRange', [row, column]));      

  void indentRows(int startRow, int endRow, String indentString) =>
      call('indentRows', [startRow, endRow, indentString]);
  
  Point insert(Point position, String text) =>
      new Point._(call('insert', [position._toProxy(), text]));
  
  bool isTabStop(Point position) => call('isTabStop', [position._toProxy()]);
  
  int moveLinesDown(int firstRow, int lastRow) =>
      call('moveLinesDown', [firstRow, lastRow]);
  
  int moveLinesUp(int firstRow, int lastRow) =>
      call('moveLinesUp', [firstRow, lastRow]);
  
  Point remove(Range range) => new Point._(call('remove', [range._toProxy()]));
  
  void removeGutterDecoration(int row, String className) =>
      call('removeGutterDecoration', [row, className]);
  
  Point replace(Range range, String text) => 
      new Point._(call('replace', [range._toProxy(), text]));
  
  Point screenToDocumentPosition(int row, int column) =>
      new Point._(call('screenToDocumentPosition', [row, column]));
  
  void setBreakpoint(int row, {String className: 'ace_breakpoint'}) =>
      call('setBreakpoint', [row, className]);
  
  void setBreakpoints(List<int> rows) => call('setBreakpoints', [_jsify(rows)]);
  
  void setWrapLimitRange({int min, int max}) => 
      call('setWrapLimitRange', [min, max]);
  
  void toggleOverwrite() => call('toggleOverwrite');
  
  String toString() => call('toString');
}
