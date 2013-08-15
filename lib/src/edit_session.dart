part of ace;

/// Encapsulates the state of an [Editor].
/// 
/// An instance of [EditSession] stores all of the data about an [Editor]'s 
/// state, thus providing a means to change editor state dynamically.
/// 
/// An instance of [EditSession] may be attached to only one [Document].  An
/// instance of [Document] may be attached to more than one [EditSession].
class EditSession extends _HasProxy {
  js.Callback _jsOnChangeOverwrite;
  js.Callback _jsOnChangeScrollLeft;
  js.Callback _jsOnChangeScrollTop;
  js.Callback _jsOnChangeTabSize;
  js.Callback _jsOnChangeWrapLimit;
  js.Callback _jsOnChangeWrapMode;
    
  final _onChangeOverwrite = new StreamController.broadcast();
  final _onChangeScrollLeft = new StreamController<int>.broadcast();
  final _onChangeScrollTop = new StreamController<int>.broadcast();
  final _onChangeTabSize = new StreamController.broadcast();
  final _onChangeWrapLimit = new StreamController.broadcast();
  final _onChangeWrapMode = new StreamController.broadcast();
      
  /// Fired whenever the [overwrite] changes.
  Stream get onChangeOverwrite => _onChangeOverwrite.stream;
  
  /// Fired whenever the [scrollLeft] changes.
  Stream<int> get onChangeScrollLeft => _onChangeScrollLeft.stream;
  
  /// Fired whenever the [scrollTop] changes.
  Stream<int> get onChangeScrollTop => _onChangeScrollTop.stream;
  
  /// Fired whenever the [tabSize] changes.
  Stream get onChangeTabSize => _onChangeTabSize.stream;
  
  /// Fired whenever the [wrapLimit] changes.
  Stream get onChangeWrapLimit => _onChangeWrapLimit.stream;
  
  /// Fired whenever the [useWrapMode] changes.
  Stream get onChangeWrapMode => _onChangeWrapMode.stream;
  
  /// The current [Document] associated with this session.
  Document
    get document => new Document._(_proxy.getDocument());
    set document(Document document) => _proxy.setDocument(document._proxy);
  
  /// Returns the current [document.length].
  int get length => _proxy.getLength();
  
  Mode
    get mode => new Mode._(_proxy.getMode());
    set mode(Mode mode) => throw new UnimplementedError();
  
  String
    get newLineMode => _proxy.getNewLineMode();
    set newLineMode(String newLineMode) => _proxy.setNewLineMode(newLineMode);
  
  /// Whether or not overwrite is enabled in this session.
  /// 
  /// A _true_ value means overwrite is enabled.  Any text that is entered will
  /// write over any text after it.  Setting this to a new value fires an
  /// [onChangeOverwrite] event.
  bool
    get overwrite => _proxy.getOverwrite();
    set overwrite(bool overwrite) => _proxy.setOverwrite(overwrite);
  
  int get screenWidth => _proxy.getScreenWidth();
  
  /// The value of the distance between the left of the editor and the leftmost 
  /// part of the visible content.  Setting this to a new value fires an
  /// [onChangeScrollLeft] event.
  int
    get scrollLeft => _proxy.getScrollLeft();
    set scrollLeft(int scrollLeft) => _proxy.setScrollLeft(scrollLeft);  
    
  /// The value of the distance between the top of the editor and the topmost 
  /// part of the visible content.  Setting this to a new value fires an
  /// [onChangeScrollTop] event.
  int
    get scrollTop => _proxy.getScrollTop();
    set scrollTop(int scrollTop) => _proxy.setScrollTop(scrollTop);
    
  /// The number of spaces that define a soft tab.
  /// 
  /// For example, a tab size of `4` combined with [useSoftTabs] will transform
  /// the soft tabs to be equivalent to four spaces.  Setting this to a new
  /// value fires an [onChangeTabSize] event.
  int
    get tabSize => _proxy.getTabSize();
    set tabSize(int tabSize) => _proxy.setTabSize(tabSize);
    
  /// Returns the current value for tabs.
  /// 
  /// If the [useSoftTabs] is `true`, this will be a series of [tabSize] spaces; 
  /// otherwise it is equal to `'\t'`.
  String get tabString => _proxy.getTabString();
  
  /// The current [UndoManager].
  UndoManager
    get undoManager => new UndoManager._(_proxy.getUndoManager());
    set undoManager(UndoManager undoManager) => throw new UnimplementedError();
  
  /// Whether or not to use soft tabs.  
  /// 
  /// A _true_ value means soft tabs are being used.  Using soft tabs means to
  /// use spaces instead of the tab character `\t`.
  bool
    get useSoftTabs => _proxy.getUseSoftTabs();
    set useSoftTabs(bool useSoftTabs) => _proxy.setUseSoftTabs(useSoftTabs);
    
  /// Whether or not this session uses a worker.
  /// 
  /// A _true_ value means to use a worker.
  bool
    get useWorker => _proxy.getUseWorker();
    set useWorker(bool useWorker) => _proxy.setUseWorker(useWorker);
    
  /// Whether or not line wrapping is enabled. 
  /// 
  /// A _true_ value means to line wrap.  Setting a new value fires an 
  /// [onChangeWrapMode] event.
  bool
    get useWrapMode => _proxy.getUseWrapMode();
    set useWrapMode(bool useWrapMode) => _proxy.setUseWrapMode(useWrapMode);
    
  /// The current [document.value].
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);
    
  /// The current wrap limit.
  int get wrapLimit => _proxy.getWrapLimit();
  // TODO(rms): there is a _proxy.setWrapLimit(limit) but it calls through to
  // `setWrapLimitRange(limit, limit)` which doesn't set the value of wrapLimit?
  
  /// Returns a map that defines the minimum and maximum of the [wrapLimit].
  /// 
  /// The map contains the keys `min` and `max`:
  ///     { min: wrapLimitRange_min, max: wrapLimitRange_max }
  // TODO(rms): define a class for this data.
  Map get wrapLimitRange => 
      json.parse(_context.JSON.stringify(_proxy.getWrapLimitRange()));
  
  /// Creates a new EditSession and associates it with the given [document] and 
  /// text [mode].
  EditSession(Document document, String mode) : this._(
      new js.Proxy(_context.ace.EditSession, document._proxy, mode));
  
  EditSession._(js.Proxy proxy) : super(proxy) {    
    _jsOnChangeOverwrite = 
        new js.Callback.many((_,__) => _onChangeOverwrite.add(this));
    _jsOnChangeScrollLeft = 
        new js.Callback.many((e,__) => _onChangeScrollLeft.add(e));
    _jsOnChangeScrollTop = 
        new js.Callback.many((e,__) => _onChangeScrollTop.add(e));
    _jsOnChangeTabSize = 
        new js.Callback.many((_,__) => _onChangeTabSize.add(this));
    _jsOnChangeWrapLimit = 
        new js.Callback.many((_,__) => _onChangeWrapLimit.add(this));
    _jsOnChangeWrapMode = 
        new js.Callback.many((_,__) => _onChangeWrapMode.add(this));
    _proxy.on('changeOverwrite', _jsOnChangeOverwrite);
    _proxy.on('changeScrollLeft', _jsOnChangeScrollLeft);
    _proxy.on('changeScrollTop', _jsOnChangeScrollTop);
    _proxy.on('changeTabSize', _jsOnChangeTabSize);
    _proxy.on('changeWrapLimit', _jsOnChangeWrapLimit);
    _proxy.on('changeWrapMode', _jsOnChangeWrapMode);
  }
  
  void _onDispose() {
    _onChangeOverwrite.close();
    _onChangeScrollLeft.close();
    _onChangeScrollTop.close();
    _onChangeTabSize.close();
    _onChangeWrapLimit.close();
    _onChangeWrapMode.close();   
    _jsOnChangeOverwrite.dispose();
    _jsOnChangeScrollLeft.dispose();
    _jsOnChangeScrollTop.dispose();
    _jsOnChangeTabSize.dispose();
    _jsOnChangeWrapLimit.dispose();
    _jsOnChangeWrapMode.dispose();
  }
      
  void addGutterDecoration(int row, String className) =>
      _proxy.addGutterDecoration(row, className);
  
  // TODO(rms): undocumented and complex in ace.js, but a key ingredient in the
  // line wrapping code so we should deduce some documentation...
  bool adjustWrapLimit(int desiredLimit, int printMargin) =>
      _proxy.adjustWrapLimit(desiredLimit, printMargin);
  
  void clearAnnotations() => _proxy.clearAnnotations();
  void clearBreakpoint(int row) => _proxy.clearBreakpoint(row);
  void clearBreakpoints() => _proxy.clearBreakpoints();
  int documentToScreenColumn(int docRow, int docColumn) =>
      _proxy.documentToScreenColumn(docRow, docColumn);
  int documentToScreenRow(int docRow, int docColumn) =>
      _proxy.documentToScreenRow(docRow, docColumn);
  int duplicateLines(int firstRow, int lastRow) =>
      _proxy.duplicateLines(firstRow, lastRow);
  Range getAWordRange(int row, int column) =>
      new Range._(_proxy.getAWordRange(row, column));
  String getLine(int row) => _proxy.getLine(row);
  int getRowLength(int row) => _proxy.getRowLength(row);
  void indentRows(int startRow, int endRow, String indentString) =>
      _proxy.indentRows(startRow, endRow, indentString);
  int moveLinesDown(int firstRow, int lastRow) =>
      _proxy.moveLinesDown(firstRow, lastRow);
  int moveLinesUp(int firstRow, int lastRow) =>
      _proxy.moveLinesUp(firstRow, lastRow);
  void setMode(String mode) => _proxy.setMode(mode);
  
  /// Sets the boundaries of line wrap. 
  /// 
  /// Either value can be `null` to have an unconstrained wrap, or, they can be 
  /// the same number to pin the [wrapLimit].  The [min] wrap value specifies
  /// the left side wrap and the [max] wrap value specifies the right side wrap.
  /// If a new value for [min] or [max] is set then this method fires an 
  /// [onChangeWrapMode] event.
  void setWrapLimitRange({int min, int max}) => 
      _proxy.setWrapLimitRange(min, max);
  
  /// Sets the value of [overwrite] to the opposite of its current value.
  void toggleOverwrite() => _proxy.toggleOverwrite();
  
  String toString() => _proxy.toString();
}
