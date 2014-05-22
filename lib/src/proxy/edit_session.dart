part of ace.proxy;

class _EditSessionProxy extends HasProxy implements EditSession {

  _Event<Delta> _onChange;
  Stream<Delta> get onChange {
    if (_onChange == null) {
      _onChange = new _Event<Delta>(this, 'change', (e) => _delta(e['data']));
    }
    return _onChange.stream;
  }
  
  _Event<Null> _onChangeAnnotation;
  Stream<Null> get onChangeAnnotation {
    if (_onChangeAnnotation == null) {
      _onChangeAnnotation = new _Event<Null>(this, 'changeAnnotation');
    }
    return _onChangeAnnotation.stream;
  }
  
  _Event<Null> _onChangeBackMarker;
  Stream<Null> get onChangeBackMarker {
    if (_onChangeBackMarker == null) {
      _onChangeBackMarker = new _Event<Null>(this, 'changeBackMarker');
    }
    return _onChangeBackMarker.stream;
  }
  
  _Event<Null> _onChangeBreakpoint;
  Stream<Null> get onChangeBreakpoint {
    if (_onChangeBreakpoint == null) {
      _onChangeBreakpoint = new _Event<Null>(this, 'changeBreakpoint');
    }
    return _onChangeBreakpoint.stream;
  }
    
  _Event<FoldChangeEvent> _onChangeFold;
  Stream<FoldChangeEvent> get onChangeFold {
    if (_onChangeFold == null) {
      _onChangeFold = new _Event<FoldChangeEvent>(this, 'changeFold', (e) =>
          new FoldChangeEvent(new _FoldProxy._(e['data']), e['action']));
    }
    return _onChangeFold.stream;
  }
  
  _Event<Null> _onChangeFrontMarker;
  Stream<Null> get onChangeFrontMarker {
    if (_onChangeFrontMarker == null) {
      _onChangeFrontMarker = new _Event<Null>(this, 'changeFrontMarker');
    }
    return _onChangeFrontMarker.stream;
  }
  
  _Event<Null> _onChangeOverwrite;
  Stream<Null> get onChangeOverwrite {
    if (_onChangeOverwrite == null) {
      _onChangeOverwrite = new _Event<Null>(this, 'changeOverwrite');
    }
    return _onChangeOverwrite.stream;
  }
    
  _Event<int> _onChangeScrollLeft;
  Stream<int> get onChangeScrollLeft {
    if (_onChangeScrollLeft == null) {
      _onChangeScrollLeft = new _Event<int>(this, 'changeScrollLeft', (e) =>
          e.toInt());
    }
    return _onChangeScrollLeft.stream;
  }
  
  _Event<int> _onChangeScrollTop;
  Stream<int> get onChangeScrollTop {
    if (_onChangeScrollTop == null) {
      _onChangeScrollTop = new _Event<int>(this, 'changeScrollTop', (e) =>
          e.toInt());
    }
    return _onChangeScrollTop.stream;
  }
  
  _Event<Null> _onChangeTabSize;
  Stream<Null> get onChangeTabSize {
    if (_onChangeTabSize == null) {
      _onChangeTabSize = new _Event<Null>(this, 'changeTabSize');
    }
    return _onChangeTabSize.stream;
  }
  
  _Event<Null> _onChangeWrapLimit;
  Stream<Null> get onChangeWrapLimit {
    if (_onChangeWrapLimit == null) {
      _onChangeWrapLimit = new _Event<Null>(this, 'changeWrapLimit');
    }
    return _onChangeWrapLimit.stream;
  }
  
  _Event<Null> _onChangeWrapMode;
  Stream<Null> get onChangeWrapMode {
    if (_onChangeWrapMode == null) {
      _onChangeWrapMode = new _Event<Null>(this, 'changeWrapMode');
    }
    return _onChangeWrapMode.stream;
  }
  
  Document
    get document => new _DocumentProxy._(call('getDocument'));
    set document(Document document) {
      assert(document is _DocumentProxy);
      call('setDocument', [(document as _DocumentProxy)._proxy]);
    }

  int get length => call('getLength');
  
  Mode
    get mode {
      final mode = call('getMode');
      final proxy = (mode == js.JsObject) ? mode : null;
      return new _ModeProxy._(proxy, getOption('mode'));
    }
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
    set undoManager(UndoManager undoManager) {
      assert(undoManager is UndoManagerBase);
      call('setUndoManager', [(undoManager as UndoManagerBase)._proxy]);
    }
  
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
  
  int 
    get wrapLimit => call('getWrapLimit');
    set wrapLimit(int wrapLimit) => call('setWrapLimit', [wrapLimit]);
      
  _EditSessionProxy(Document document, Mode mode) 
  : this._(new js.JsObject(_context['ace']['EditSession'], 
      [(document as _DocumentProxy)._proxy, (mode as _ModeProxy)._mode]));
  
  _EditSessionProxy._(js.JsObject proxy) : super(proxy); 
  
  Future _onDispose() {
    final List<Future> f = new List<Future>();
    if (_onChange != null) f.add(_onChange.dispose());
    if (_onChangeAnnotation != null) f.add(_onChangeAnnotation.dispose());
    if (_onChangeBackMarker != null) f.add(_onChangeBackMarker.dispose());
    if (_onChangeBreakpoint != null) f.add(_onChangeBreakpoint.dispose());
    if (_onChangeFold != null) f.add(_onChangeFold.dispose());
    if (_onChangeFrontMarker != null) f.add(_onChangeFrontMarker.dispose());
    if (_onChangeOverwrite != null) f.add(_onChangeOverwrite.dispose());
    if (_onChangeScrollLeft != null) f.add(_onChangeScrollLeft.dispose());
    if (_onChangeScrollTop != null) f.add(_onChangeScrollTop.dispose());
    if (_onChangeTabSize != null) f.add(_onChangeTabSize.dispose());
    if (_onChangeWrapLimit != null) f.add(_onChangeWrapLimit.dispose());
    if (_onChangeWrapMode != null) f.add(_onChangeWrapMode.dispose());  
    return Future.wait(f);
  }
  
  Fold addFold(Fold fold) => new _FoldProxy._(
      call('addFold', [(fold as _FoldProxy)._proxy]));
  
  void addGutterDecoration(int row, String className) =>
      call('addGutterDecoration', [row, className]);
  
  int addMarker(Range range, String className, 
      { String type: Marker.LINE, bool inFront: false }) =>
      call('addMarker', [_jsRange(range), className, type, inFront]);
  
  bool adjustWrapLimit(int desiredLimit, int printMargin) =>
      call('adjustWrapLimit', [desiredLimit, printMargin]);
  
  void clearAnnotations() => call('clearAnnotations');
  
  void clearBreakpoint(int row) => call('clearBreakpoint', [row]);
  
  void clearBreakpoints() => call('clearBreakpoints');
  
  int documentToScreenColumn(int row, int column) =>
      call('documentToScreenColumn', [row, column]);
  
  int documentToScreenRow(int row, int column) => 
      call('documentToScreenRow', [row, column]);
  
  int duplicateLines(int firstRow, int lastRow) =>
      call('duplicateLines', [firstRow, lastRow]);
  
  List<Fold> getAllFolds() {
    final proxies = call('getAllFolds');
    return new List<Fold>.generate(proxies['length'], 
        (i) => new _FoldProxy._(proxies[i]));
  }
  
  List<Annotation> getAnnotations() {
    final proxies = call('getAnnotations');
    return new List<Annotation>.generate(proxies['length'], 
        (i) => _annotation(proxies[i]));
  }
        
  Range getAWordRange(int row, int column) =>
      _range(call('getAWordRange', [row, column]));
  
  Map<int, String> getBreakpoints() => _list(call('getBreakpoints')).asMap();
  
  Fold getFoldAt(int row, int column, {int side}) {
    final proxy = call('getFoldAt', [row, column, side]);
    return proxy == null ? null : new _FoldProxy._(proxy);
  }
  
  String getLine(int row) => call('getLine', [row]);
  
  Map<int, Marker> getMarkers({ bool inFront: false }) {
    final markers = _map(call('getMarkers', [inFront]));
    markers.forEach((k, v) {
      markers[k] = _marker(v);
    });
    return markers;
  }
  
  getOption(String name) => call('getOption', [name]);
  
  Map<String, dynamic> getOptions(List<String> optionNames) =>
      _map(call('getOptions', [_jsArray(optionNames)]));
  
  int getRowLength(int row) => call('getRowLength', [row]);
  
  String getTextRange(Range range) => call('getTextRange', [_jsRange(range)]);
  
  Token getTokenAt(int row, [int column]) => 
      _token(call('getTokenAt', [row, column]));
  
  List<Token> getTokens(int row) {
    final proxies = call('getTokens', [row]);
    return new List<Token>.generate(proxies['length'], 
        (i) => _token(proxies[i]));
  }
  
  Range getWordRange(int row, int column) => 
      _range(call('getWordRange', [row, column]));      

  WrapLimitRange getWrapLimitRange() {
    final proxy = call('getWrapLimitRange');
    return new WrapLimitRange(proxy['max'], proxy['min']);
  }
  
  void indentRows(int startRow, int endRow, String indentString) =>
      call('indentRows', [startRow, endRow, indentString]);
  
  Point insert(Point position, String text) =>
      _point(call('insert', [_jsPoint(position), text]));
  
  bool isTabStop(Point position) => call('isTabStop', [_jsPoint(position)]);
  
  int moveLinesDown(int firstRow, int lastRow) =>
      call('moveLinesDown', [firstRow, lastRow]);
  
  int moveLinesUp(int firstRow, int lastRow) =>
      call('moveLinesUp', [firstRow, lastRow]);
  
  Point remove(Range range) => _point(call('remove', [_jsRange(range)]));
  
  void removeFold(Fold fold) => 
      call('removeFold', [(fold as _FoldProxy)._proxy]);
  
  void removeGutterDecoration(int row, String className) =>
      call('removeGutterDecoration', [row, className]);
  
  void removeMarker(int markerId) => call('removeMarker', [markerId]);
  
  Point replace(Range range, String text) => 
      _point(call('replace', [_jsRange(range), text]));
  
  Point screenToDocumentPosition(int row, int column) =>
      _point(call('screenToDocumentPosition', [row, column]));
  
  void setAnnotations(List<Annotation> annotations) => call('setAnnotations', 
      [_jsArray(annotations.map(_jsAnnotation))]);
  
  void setBreakpoint(int row, {String className: 'ace_breakpoint'}) =>
      call('setBreakpoint', [row, className]);
  
  void setBreakpoints(List<int> rows) => 
      call('setBreakpoints', [_jsArray(rows)]);
  
  void setOption(String name, value) => call('setOption', [name, value]);
  
  void setOptions(Map<String, dynamic> options) => 
      call('setOptions', [_jsify(options)]);
  
  void setWrapLimitRange({int min, int max}) => 
      call('setWrapLimitRange', [min, max]);
  
  void toggleOverwrite() => call('toggleOverwrite');
  
  String toString() => call('toString');
}
