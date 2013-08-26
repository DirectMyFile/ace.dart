part of ace;

/// Encapsulates the state of an [Editor].
/// 
/// An instance of [EditSession] stores all of the data about an [Editor]'s 
/// state, thus providing a means to change editor state dynamically.
/// 
/// An instance of [EditSession] may be attached to only one [Document].  An
/// instance of [Document] may be attached to more than one [EditSession].
class EditSession extends _HasProxy {
  js.Callback _jsOnChange;
  js.Callback _jsOnChangeBreakpoint;
  js.Callback _jsOnChangeOverwrite;
  js.Callback _jsOnChangeScrollLeft;
  js.Callback _jsOnChangeScrollTop;
  js.Callback _jsOnChangeTabSize;
  js.Callback _jsOnChangeWrapLimit;
  js.Callback _jsOnChangeWrapMode;
    
  final _onChange = new StreamController<Delta>.broadcast();
  final _onChangeBreakpoint = new StreamController.broadcast();
  final _onChangeOverwrite = new StreamController.broadcast();
  final _onChangeScrollLeft = new StreamController<int>.broadcast();
  final _onChangeScrollTop = new StreamController<int>.broadcast();
  final _onChangeTabSize = new StreamController.broadcast();
  final _onChangeWrapLimit = new StreamController.broadcast();
  final _onChangeWrapMode = new StreamController.broadcast();
  
  /// Fired whenever the [document] changes.
  Stream<Delta> get onChange => _onChange.stream;
  
  /// Fired whenever the gutter changes, either by setting or removing
  /// breakpoints, or when the gutter decorations change.
  // TODO(rms): why isn't this called onChangeGutter then?
  Stream get onChangeBreakpoint => _onChangeBreakpoint.stream;
  
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
  
  /// A map from row index to CSS class name for all of the breakpoints in the 
  /// current [document].
  /// 
  /// A value of _null_ for any given row index indicates that no breakpoint is
  /// set for that row.
  Map<int, String> get breakpoints =>
      json.parse(_context.JSON.stringify(_proxy.getBreakpoints())).asMap();
  
  /// The current [Document] associated with this session.
  Document
    get document => new Document._(_proxy.getDocument());
    set document(Document document) => _proxy.setDocument(document._proxy);
  
  /// Returns the current [document.length].
  int get length => _proxy.getLength();
  
  /// The current [Mode] of this session.
  Mode
    get mode => new Mode._(_proxy.getMode());
    set mode(Mode mode) => _proxy.setMode(mode._mode);
    
  /// The new line mode.  May be one of `windows`, `unix` or `auto`.
  // TODO(rms): enum
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
  
  /// Returns the length of the screen.
  int get screenLength => _proxy.getScreenLength();
    
  /// Returns the width of the screen.
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
  
  /// Whether or not the range of an undo or redo operation is selected.
  // TODO(rms) there is no `getUndoSelect()` in ace.js; send a pull request.
  set undoSelect(bool enable) => _proxy.setUndoSelect(enable);
    
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
  EditSession(Document document, Mode mode) : this._(
      new js.Proxy(_context.ace.EditSession, document._proxy, mode._mode));
  
  EditSession._(js.Proxy proxy) : super(proxy) {    
    _jsOnChange = new js.Callback.many((e,__) => 
        _onChange.add(new Delta._for(e.data)));
    _jsOnChangeBreakpoint =
        new js.Callback.many((_,__) => _onChangeBreakpoint.add(this));
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
  
  /// Adds the given CSS [className] to the given [row].
  void addGutterDecoration(int row, String className) =>
      _proxy.addGutterDecoration(row, className);
  
  // TODO(rms): undocumented and complex in ace.js, but a key ingredient in the
  // line wrapping code so we should deduce some documentation...
  bool adjustWrapLimit(int desiredLimit, int printMargin) =>
      _proxy.adjustWrapLimit(desiredLimit, printMargin);
  
  /// Removes a breakpoint on the given [row] and fires an 
  /// [onChangeBreakPoint] event.
  void clearBreakpoint(int row) => _proxy.clearBreakpoint(row);
  
  /// Removes all [breakpoints] on all rows and fires an [onChangeBreakPoint] 
  /// event.
  void clearBreakpoints() => _proxy.clearBreakpoints();
  
  /// Returns the screen column for the given [row] and [column] of the current
  /// [document].
  int documentToScreenColumn(int row, int column) =>
      _proxy.documentToScreenColumn(row, column);
  
  /// Returns the screen row for the given [row] and [column] of the current
  /// [document].
  int documentToScreenRow(int row, int column) => 
      _proxy.documentToScreenRow(row, column);
  
  /// Duplicates all of the text from [firstRow] to [lastRow], inclusive.
  int duplicateLines(int firstRow, int lastRow) =>
      _proxy.duplicateLines(firstRow, lastRow);
  
  /// Gets the [Range] of a word, including its right whitespace.
  /// 
  /// Start from the given [row] and [column].
  Range getAWordRange(int row, int column) =>
      new Range._(_proxy.getAWordRange(row, column));
  
  /// Returns a verbatim copy of the given line [row] as it is in the current 
  /// [document].
  String getLine(int row) => _proxy.getLine(row);
  
  /// Returns the number of screen rows in a wrapped line for the given [row].
  int getRowLength(int row) => _proxy.getRowLength(row);
  
  /// Returns all of the text within the given [range] of the [document].
  String getTextRange(Range range) => _proxy.getTextRange(range._toProxy());
  
  /// Returns the [Range] of the first word boundary it finds starting at the
  /// given [row] and [column].
  Range getWordRange(int row, int column) => 
      new Range._(_proxy.getWordRange(row, column));      
  
  /// Indents all of the rows from [startRow] to [endRow], inclusive, by 
  /// prefixing each row with the given [indentString].
  void indentRows(int startRow, int endRow, String indentString) =>
      _proxy.indentRows(startRow, endRow, indentString);
  
  /// Inserts a block of [text] at the given [position] and returns a point at
  /// the end of the inserted text.  This method also fires an [onChange] event.
  Point insert(Point position, String text) =>
      new Point._(_proxy.insert(position._toProxy(), text));
  
  /// Returns _true_ if the character at the given [position] is a tab stop.
  /// 
  /// The logic to determine a tab stop is equivalent to:
  ///     [useSoftTabs] && ([position.column] % [tabSize] == 0)
  bool isTabStop(Point position) => _proxy.isTabStop(position._toProxy());
  
  /// Shifts all of the lines in the [document] from [firstRow] to [lastRow],
  /// inclusive, down one row.
  int moveLinesDown(int firstRow, int lastRow) =>
      _proxy.moveLinesDown(firstRow, lastRow);
  
  /// Shifts all of the lines in the [document] from [firstRow] to [lastRow],
  /// inclusive, up one row.
  int moveLinesUp(int firstRow, int lastRow) =>
      _proxy.moveLinesUp(firstRow, lastRow);
  
  /// Removes the given [range] from the current [document].
  Point remove(Range range) => new Point._(_proxy.remove(range._toProxy()));
  
  /// Removes the given CSS [className] from the given [row].
  void removeGutterDecoration(int row, String className) =>
      _proxy.removeGutterDecoration(row, className);
  
  /// Replaces a given [range] in the [document] with the new [text] and returns
  /// a point at the end of the new text.
  Point replace(Range range, String text) => 
      new Point._(_proxy.replace(range._toProxy(), text));
  
  /// Sets a breakpoint on the given [row] using the optional CSS [className]
  /// and fires an [onChangeBreakPoint] event.
  void setBreakpoint(int row, {String className: 'ace_breakpoint'}) =>
      _proxy.setBreakpoint(row, className);
  
  /// Sets a breakpoint on all of the given [rows] and fires an 
  /// [onChangeBreakpoint] event.
  void setBreakpoints(List<int> rows) => _proxy.setBreakpoints(js.array(rows));
  
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
