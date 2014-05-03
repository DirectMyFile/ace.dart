part of ace.proxy;

class _EditSessionProxy extends HasProxy implements EditSession {

  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;
  
  final _onChangeAnnotation = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeAnnotation => _onChangeAnnotation.stream;
  
  final _onChangeBackMarker = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeBackMarker => _onChangeBackMarker.stream;
  
  final _onChangeBreakpoint = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeBreakpoint => _onChangeBreakpoint.stream;
  
  final _onChangeFold = new StreamController<FoldChangeEvent>.broadcast();
  Stream<FoldChangeEvent> get onChangeFold => _onChangeFold.stream;
  
  final _onChangeFrontMarker = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeFrontMarker => _onChangeFrontMarker.stream;
  
  final _onChangeOverwrite = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeOverwrite => _onChangeOverwrite.stream;
  
  final _onChangeScrollLeft = new StreamController<int>.broadcast();
  Stream<int> get onChangeScrollLeft => _onChangeScrollLeft.stream;
  
  final _onChangeScrollTop = new StreamController<int>.broadcast();
  Stream<int> get onChangeScrollTop => _onChangeScrollTop.stream;
  
  final _onChangeTabSize = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeTabSize => _onChangeTabSize.stream;
  
  final _onChangeWrapLimit = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeWrapLimit => _onChangeWrapLimit.stream;
  
  final _onChangeWrapMode = new StreamController<Null>.broadcast();
  Stream<Null> get onChangeWrapMode => _onChangeWrapMode.stream;
  
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
  
  final bool _listen;
    
  _EditSessionProxy(Document document, Mode mode) 
  : this._(new js.JsObject(_context['ace']['EditSession'], 
      [(document as _DocumentProxy)._proxy, (mode as _ModeProxy)._mode]));
  
  _EditSessionProxy._(js.JsObject proxy, {bool listen: true}) 
  : super(proxy)
  , _listen = listen {
    if (listen) {
      call('on', ['change', (e,__) => _onChange.add(_delta(e['data']))]);
      call('on', ['changeAnnotation', (_,__) => _onChangeAnnotation.add(null)]);
      call('on', ['changeBackMarker', (_,__) => _onChangeBackMarker.add(null)]);
      call('on', ['changeBreakpoint', (_,__) => _onChangeBreakpoint.add(null)]);
      call('on', ['changeFold', (e,__) {
        _onChangeFold.add(new FoldChangeEvent(
            new _FoldProxy._(e['data']), e['action']));
      }]);
      call('on', ['changeFrontMarker', 
                  (_,__) => _onChangeFrontMarker.add(null)]);
      call('on', ['changeOverwrite', (_,__) => _onChangeOverwrite.add(null)]);
      call('on', ['changeScrollLeft', 
                  (e,__) => _onChangeScrollLeft.add(e.toInt())]);
      call('on', ['changeScrollTop', 
                  (e,__) => _onChangeScrollTop.add(e.toInt())]);
      call('on', ['changeTabSize', (_,__) => _onChangeTabSize.add(null)]);
      call('on', ['changeWrapLimit', (_,__) => _onChangeWrapLimit.add(null)]);
      call('on', ['changeWrapMode', (_,__) => _onChangeWrapMode.add(null)]);
    }
  }
  
  void _onDispose() {
    if (_listen) {
      _onChange.close();
      _onChangeAnnotation.close();
      _onChangeBackMarker.close();
      _onChangeBreakpoint.close();
      _onChangeFold.close();
      _onChangeFrontMarker.close();
      _onChangeOverwrite.close();
      _onChangeScrollLeft.close();
      _onChangeScrollTop.close();
      _onChangeTabSize.close();
      _onChangeWrapLimit.close();
      _onChangeWrapMode.close();
    }
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
