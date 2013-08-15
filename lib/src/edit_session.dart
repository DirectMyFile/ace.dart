part of ace;

/// Encapsulates the state of an [Editor].
/// 
/// An instance of [EditSession] stores all of the data about an [Editor]'s 
/// state, thus providing a means to change editor state dynamically.
/// 
/// An instance of [EditSession] may be attached to only one [Document].  An
/// instance of [Document] may be attached to more than one [EditSession].
class EditSession extends _HasProxy {
  js.Callback _jsOnChangeTabSize;
  js.Callback _jsOnChangeWrapLimit;
  js.Callback _jsOnChangeWrapMode;
  
  final _onChangeTabSize = new StreamController.broadcast();
  final _onChangeWrapLimit = new StreamController.broadcast();
  final _onChangeWrapMode = new StreamController.broadcast();
  
  /// Fired whenever the [tabSize] changes.
  Stream get onChangeTabSize => _onChangeTabSize.stream;
  
  /// Fired whenever the [wrapLimit] changes.
  Stream get onChangeWrapLimit => _onChangeWrapLimit.stream;
  
  /// Fired whenever the [useWrapMode] changes.
  Stream get onChangeWrapMode => _onChangeWrapMode.stream;
  
  Document
    get document => new Document._(_proxy.getDocument());
    set document(Document document) => throw new UnimplementedError();
  
  /// Returns the current [document.length].
  int get length => _proxy.getLength();
  
  Mode
    get mode => new Mode._(_proxy.getMode());
    set mode(Mode mode) => throw new UnimplementedError();
  
  String
    get newLineMode => _proxy.getNewLineMode();
    set newLineMode(String newLineMode) => _proxy.setNewLineMode(newLineMode);
  
  bool
    get overwrite => _proxy.getOverwrite();
    set overwrite(bool overwrite) => _proxy.setOverwrite(overwrite);
  
  int get screenWidth => _proxy.getScreenWidth();
  
  int
    get scrollLeft => _proxy.getScrollLeft();
    set scrollLeft(int scrollLeft) => _proxy.setScrollLeft(scrollLeft);  
    
  int
    get scrollTop => _proxy.getScrollTop();
    set scrollTop(int scrollTop) => _proxy.setScrollTop(scrollTop);
    
  /// The number of spaces that define a soft tab.
  /// 
  /// For example, a tab size of `4` combined with [useSoftTabs] will transform
  /// the soft tabs to be equivalent to four spaces.  This method also fires an 
  /// [onChangeTabSize] event.
  int
    get tabSize => _proxy.getTabSize();
    set tabSize(int tabSize) => _proxy.setTabSize(tabSize);
    
  /// Returns the current value for tabs.
  /// 
  /// If the [useSoftTabs] is `true`, this will be a series of [tabSize] spaces; 
  /// otherwise it is equal to `'\t'`.
  String get tabString => _proxy.getTabString();
    
  /// Whether or not to use soft tabs.  
  /// 
  /// A _true_ value means soft tabs are being used.  Using soft tabs means to
  /// use spaces instead of the tab character `\t`.
  bool
    get useSoftTabs => _proxy.getUseSoftTabs();
    set useSoftTabs(bool useSoftTabs) => _proxy.setUseSoftTabs(useSoftTabs);
    
  /// Whether or not this EditSession uses a worker.
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
    _jsOnChangeTabSize = 
        new js.Callback.many((_,__) => _onChangeTabSize.add(this));
    _jsOnChangeWrapLimit = 
        new js.Callback.many((_,__) => _onChangeWrapLimit.add(this));
    _jsOnChangeWrapMode = 
        new js.Callback.many((_,__) => _onChangeWrapMode.add(this));
    _proxy.on('changeTabSize', _jsOnChangeTabSize);
    _proxy.on('changeWrapLimit', _jsOnChangeWrapLimit);
    _proxy.on('changeWrapMode', _jsOnChangeWrapMode);
  }
  
  void _onDispose() {
    _onChangeTabSize.close();
    _onChangeWrapLimit.close();
    _onChangeWrapMode.close();
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
      new Range._fromProxy(_proxy.getAWordRange(row, column));
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
  
  void toggleOverwrite() => _proxy.toggleOverwrite();
  String toString() => _proxy.toString();
}
