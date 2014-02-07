part of ace;

/// Encapsulates the state of an [Editor].
/// 
/// An instance of [EditSession] stores all of the data about an [Editor]'s 
/// state, thus providing a means to change editor state dynamically.
/// 
/// An instance of [EditSession] may be attached to only one [Document].  An
/// instance of [Document] may be attached to more than one [EditSession].
abstract class EditSession extends Disposable 
    implements OptionsProvider, Folding {
  
  /// Fired whenever the [document] changes.
  Stream<Delta> get onChange;
  
  /// Fired whenever one of the [annotations] changes.
  Stream<Null> get onChangeAnnotation;
  
  /// Fired whenever a back marker changes.
  Stream<Null> get onChangeBackMarker;
  
  /// Fired whenever the gutter changes, either by setting or removing
  /// breakpoints, or when the gutter decorations change.
  Stream<Null> get onChangeBreakpoint;
  
  /// Fired whenever a code fold is added, removed or updated.
  Stream<FoldChangeEvent> get onChangeFold;
  
  /// Fired whenever a front marker changes.
  Stream<Null> get onChangeFrontMarker;
  
  /// Fired whenever the [overwrite] changes.
  Stream<Null> get onChangeOverwrite;
  
  /// Fired whenever the [scrollLeft] changes.
  Stream<int> get onChangeScrollLeft;
  
  /// Fired whenever the [scrollTop] changes.
  Stream<int> get onChangeScrollTop;
  
  /// Fired whenever the [tabSize] changes.
  Stream<Null> get onChangeTabSize;
  
  /// Fired whenever the [wrapLimit] changes.
  Stream<Null> get onChangeWrapLimit;
  
  /// Fired whenever the [useWrapMode] changes.
  Stream<Null> get onChangeWrapMode;

  /// The current [Document] associated with this session.
  Document document;
  
  /// Returns the current [document.length].
  int get length;
  
  /// The current [Mode] of this session.
  Mode mode;
    
  /// The new line mode.  May be one of `windows`, `unix` or `auto`.
  // TODO(rms): enum
  String newLineMode;

  /// Whether or not overwrite is enabled in this session.
  /// 
  /// A _true_ value means overwrite is enabled.  Any text that is entered will
  /// write over any text after it.  Setting this to a new value fires an
  /// [onChangeOverwrite] event.
  bool overwrite;

  /// Returns the length of the screen.
  int get screenLength;
    
  /// Returns the width of the screen.
  int get screenWidth;
  
  /// The value of the distance between the left of the editor and the leftmost 
  /// part of the visible content.  Setting this to a new value fires an
  /// [onChangeScrollLeft] event.
  int scrollLeft;
 
  /// The value of the distance between the top of the editor and the topmost 
  /// part of the visible content.  Setting this to a new value fires an
  /// [onChangeScrollTop] event.
  int scrollTop;
 
  /// The number of spaces that define a soft tab.
  /// 
  /// For example, a tab size of `4` combined with [useSoftTabs] will transform
  /// the soft tabs to be equivalent to four spaces.  Setting this to a new
  /// value fires an [onChangeTabSize] event.
  int tabSize;
  
  /// Returns the current value for tabs.
  /// 
  /// If the [useSoftTabs] is `true`, this will be a series of [tabSize] spaces; 
  /// otherwise it is equal to `'\t'`.
  String get tabString;
  
  /// The current [UndoManager].
  UndoManager undoManager;

  /// Whether or not the range of an undo or redo operation is selected.
  bool undoSelect;
    
  /// Whether or not to use soft tabs.  
  /// 
  /// A _true_ value means soft tabs are being used.  Using soft tabs means to
  /// use spaces instead of the tab character `\t`.
  bool useSoftTabs;

  /// Whether or not this session uses a worker.
  /// 
  /// A _true_ value means to use a worker.
  bool useWorker;

  /// Whether or not line wrapping is enabled. 
  /// 
  /// A _true_ value means to line wrap.  The default value is _false_ for no
  /// line wrapping.  Setting a new value fires an [onChangeWrapMode] event.
  bool useWrapMode;

  /// The current [document.value].
  String value;

  /// The current wrap limit.
  ///
  /// The wrap limit is calculated using the current value returned by 
  /// [getWrapLimitRange].  Setting this field to a new `value` is equivalent to 
  /// calling `setWrapLimitRange(min: value, max: value)` and does _not_ have an
  /// immediate effect on the current wrap limit; the wrap limit is only updated
  /// to a new value when [adjustWrapLimit] is called by the [VirtualRenderer].
  int wrapLimit;

  /// Creates a new EditSession and associates it with the given [document] and 
  /// text [mode].
  factory EditSession(Document document, Mode mode) => 
      implementation.createEditSessionFromDocument(document, mode);
    
  /// Adds the given CSS [className] to the given [row].
  void addGutterDecoration(int row, String className);
  
  /// Adds a new marker to the given [range] and returns the marker's id. 
  ///
  /// If [inFront] is `true`, a front marker is defined and an 
  /// [onChangeFrontMarker] event fires; otherwise, a back marker is defined 
  /// and an [onChangeBackMarker] event fires.
  int addMarker(Range range, String className, 
      { String type: Marker.LINE, bool inFront: false });
  
  /// Adjusts the [wrapLimit] using the given [desiredLimit], [printMargin] 
  /// and the current value returned by [getWrapLimitRange] and returns `true` 
  /// if the value of [wrapLimit] is changed.
  ///
  /// This method is called internally by the [VirtualRenderer] to update the
  /// [wrapLimit] as the available width changes and is not designed for calls
  /// from outside of this library.
  bool adjustWrapLimit(int desiredLimit, int printMargin);
  
  /// Clears all annotations for this session and fires an [onChangeAnnotation] 
  /// event.
  void clearAnnotations();
  
  /// Removes a breakpoint on the given [row] and fires an 
  /// [onChangeBreakPoint] event.
  void clearBreakpoint(int row);
  
  /// Removes all breakpoints on all rows and fires an [onChangeBreakPoint] 
  /// event.
  void clearBreakpoints();
  
  /// Returns the screen column for the given [row] and [column] of the current
  /// [document].
  int documentToScreenColumn(int row, int column);
  
  /// Returns the screen row for the given [row] and [column] of the current
  /// [document].
  int documentToScreenRow(int row, int column);
  
  /// Duplicates all of the text from [firstRow] to [lastRow], inclusive.
  int duplicateLines(int firstRow, int lastRow);
  
  /// Returns a copy of the current annotations for this session.
  List<Annotation> getAnnotations();
  
  /// Gets the [Range] of a word, including its right whitespace.
  /// 
  /// Start from the given [row] and [column].
  Range getAWordRange(int row, int column);
  
  /// Returns a map from row index to CSS class name for all of the breakpoints
  /// in the current [document].
  /// 
  /// A value of _null_ for any given row index indicates that no breakpoint is
  /// set for that row.
  Map<int, String> getBreakpoints();
  
  /// Returns a verbatim copy of the given line [row] as it is in the current 
  /// [document].
  String getLine(int row);
  
  /// Returns a map from marker id to [Marker] for all of the front markers if
  /// [inFront] is given as `true` or else all of the back markers.
  Map<int, Marker> getMarkers({ bool inFront: false });
  
  /// Returns the number of screen rows in a wrapped line for the given [row].
  int getRowLength(int row);
  
  /// Returns all of the text within the given [range] of the [document].
  String getTextRange(Range range);
  
  /// Returns the [Range] of the first word boundary it finds starting at the
  /// given [row] and [column].
  Range getWordRange(int row, int column);      
  
  /// Returns the current allowed range for the [wrapLimit].
  WrapLimitRange getWrapLimitRange();
  
  /// Indents all of the rows from [startRow] to [endRow], inclusive, by 
  /// prefixing each row with the given [indentString].
  void indentRows(int startRow, int endRow, String indentString);
  
  /// Inserts a block of [text] at the given [position] and returns a point at
  /// the end of the inserted text.  This method also fires an [onChange] event.
  Point insert(Point position, String text);
  
  /// Returns _true_ if the character at the given [position] is a tab stop.
  /// 
  /// The logic to determine a tab stop is equivalent to:
  ///     [useSoftTabs] && ([position.column] % [tabSize] == 0)
  bool isTabStop(Point position);
  
  /// Shifts all of the lines in the [document] from [firstRow] to [lastRow],
  /// inclusive, down one row.
  int moveLinesDown(int firstRow, int lastRow);
  
  /// Shifts all of the lines in the [document] from [firstRow] to [lastRow],
  /// inclusive, up one row.
  int moveLinesUp(int firstRow, int lastRow);
  
  /// Removes the given [range] from the current [document].
  Point remove(Range range);
  
  /// Removes the given CSS [className] from the given [row].
  void removeGutterDecoration(int row, String className);
  
  /// Removes the marker with the given [markerId]. 
  /// 
  /// If the marker was in front, this method fires an [onChangeFrontMarker] 
  /// event; if it was in the back then it fires an [onChangeBackMarker] event.
  void removeMarker(int markerId);
  
  /// Replaces a given [range] in the [document] with the new [text] and returns
  /// a point at the end of the new text.
  Point replace(Range range, String text);
  
  /// Converts screen coordinates to [document] coordinates. 
  /// 
  /// This takes into account code folding, word wrap, [tabSize], and any other 
  /// visual modifications.
  Point screenToDocumentPosition(int row, int column);
  
  /// Sets the annotations for this session and fires an [onChangeAnnotation] 
  /// event.
  void setAnnotations(List<Annotation> annotations);
  
  /// Sets a breakpoint on the given [row] using the optional CSS [className]
  /// and fires an [onChangeBreakPoint] event.
  void setBreakpoint(int row, {String className: 'ace_breakpoint'});
  
  /// Sets a breakpoint on all of the given [rows] and fires an 
  /// [onChangeBreakpoint] event.
  void setBreakpoints(List<int> rows);
  
  /// Sets the allowed range for the [wrapLimit]. 
  /// 
  /// Either value may be `null` to set an unconstrained wrap, or, they can be 
  /// the same number to pin the [wrapLimit].  The [min] wrap value specifies
  /// the left side wrap and the [max] wrap value specifies the right side wrap.
  /// If a new value for [min] or [max] is set then this method fires an 
  /// [onChangeWrapMode] event.
  void setWrapLimitRange({int min, int max});
  
  /// Sets the value of [overwrite] to the opposite of its current value.
  void toggleOverwrite();
}

class WrapLimitRange {

  final int max;
  
  final int min;

  WrapLimitRange(this.max, this.min);
  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! WrapLimitRange) return false; 
    final o = other;
    return max == o.max && min == o.min;
  }  
  
  int get hashCode => max.hashCode ^ min.hashCode;
}
