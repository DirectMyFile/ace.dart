part of ace;

/// Encapsulates the text of a document. 
/// 
/// At its core, a [Document] is just an array of strings where the index of the
/// array points to a row in the document.
/// 
/// An instance of [Document] may be attached to more than one [EditSession].
class Document extends _HasProxy {
  js.Callback _jsOnChange;
  final _onChange = new StreamController<Delta>.broadcast();
  /// Fired whenever this document changes.
  Stream<Delta> get onChange => _onChange.stream;
  
  /// The number of rows in this document.
  int get length => _proxy.getLength();
  
  /// The current newline character, based on the current [newLineMode].
  String get newLineCharacter => _proxy.getNewLineCharacter();
      
  /// The new line mode.  May be one of `windows`, `unix` or `auto`.
  // TODO(rms): enum
  String 
    get newLineMode => _proxy.getNewLineMode();
    set newLineMode(String newLineMode) => _proxy.setNewLineMode(newLineMode);
    
  /// All the lines in this document as a single string, split by the 
  /// [newLineCharacter].  
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);

  /// Creates a new Document with the given [text], if any, or else it is empty.
  Document([String text = '']) : this._(
      new js.Proxy(_context.ace.define.modules['ace/document'].Document, text));
    
  Document._(js.Proxy proxy) : super(proxy) {
    _jsOnChange = new js.Callback.many((e,__) => 
        _onChange.add(new Delta._for(e.data)));
    _proxy.on('change', _jsOnChange);
  }
  
  void _onDispose() {
    _onChange.close();
    _jsOnChange.dispose();
  }
  
  /// Applies all of the given [deltas] to this document in the order given.
  void applyDeltas(Iterable<Delta> deltas) =>
      _proxy.applyDeltas(js.array(deltas.map((delta) => delta._toProxy())));
  
  /// Creates a new [Anchor] to define a floating point in this document.
  Anchor createAnchor(int row, int column) =>
      new Anchor._(_proxy.createAnchor(row, column));
  
  /// Returns a copy of all the lines in this document.
  List<String> getAllLines() => _list(_proxy.getAllLines());
  
  /// Returns a copy of the lines between [firstRow] and [lastRow], inclusive.
  List<String> getLines(int firstRow, int lastRow) => 
      _list(_proxy.getLines(firstRow, lastRow));
  
  /// Returns a verbatim copy of the given line [row] as it is in this document.
  String getLine(int row) => _proxy.getLine(row);
  
  /// Inserts a block of [text] at the given [position] and returns a point at
  /// the end of the inserted text.  This method also fires an [onChange] event.
  Point insert(Point position, String text) =>
      new Point._(_proxy.insert(position._toProxy(), text));
  
  /// Inserts [text] into the [position] at the current row and returns a point
  /// at the end of the inserted text.  This method also fires an [onChange]
  /// event.
  Point insertInLine(Point position, String text) =>
      new Point._(_proxy.insertInLine(position._toProxy(), text));
  
  /// Inserts the given [lines] into the document, starting at the given [row]
  /// and returns a point at the end of the inserted lines.  This method also 
  /// fires an [onChange] event.
  Point insertLines(int row, Iterable<String> lines) =>
      new Point._(_proxy.insertLines(row, js.array(lines)));
  
  /// Inserts a [newLineCharacter] into this document at the current row's 
  /// position and returns a point at the end of the insertion.  This method 
  /// also fires an [onChange] event.
  Point insertNewLine(Point position) =>
      new Point._(_proxy.insertNewLine(position._toProxy()));
  
  /// Returns `true` if [text] is a newline character.  That is, one of `\r\n`, 
  /// `\r` or `\n`.
  bool isNewLine(String text) => _proxy.isNewLine(text);      
  
  /// Converts the given [position] in this document to the character's index.
  /// 
  /// Index refers to the "absolute position" of a character in this document.
  /// For example:
  ///     var x = 0; // 10 characters, plus one for newline
  ///     var y = -1;
  /// Here, `y` has an index of `15`; `10` characters for the first row, a
  /// newline character, and `5` characters until `y` in the second row. 
  /// 
  /// The optional [startRow] defaults to `0` and represents the row from which 
  /// to start the conversion.
  int positionToIndex(Point position, {int startRow: 0}) =>
      _proxy.positionToIndex(position._toProxy(), startRow);
  
  /// Removes the given [range] from this document.
  Point remove(Range range) => new Point._(_proxy.remove(range._toProxy()));
  
  /// Removes the range specified by [row/startColumn] -> [row/endColumn] and 
  /// returns the removed [range.start] point.  This method also fires an
  /// [onChange] event.
  Point removeInLine(int row, int startColumn, int endColumn) =>
      new Point._(_proxy.removeInLine(row, startColumn, endColumn));
  
  /// Removes the range of lines from the given [startRow] -> [endRow] and
  /// returns the removed lines.  This method also fires an [onChange] event.
  List<String> removeLines(int startRow, int endRow) => 
      _list(_proxy.removeLines(startRow, endRow));
  
  /// Removes the [newLineCharacter] between the given [row] and the row 
  /// immediately following it.  This method also fires an [onChange] event.
  void removeNewLine(int row) => _proxy.removeNewLine(row);
  
  /// Replaces a given [range] in this document with the new [text] and returns
  /// a point at the end of the new text.
  Point replace(Range range, String text) => 
      new Point._(_proxy.replace(range._toProxy(), text));
  
  /// Reverts all of the given [deltas] to this document in reverse of the 
  /// order given.
  void revertDeltas(Iterable<Delta> deltas) => 
      _proxy.revertDeltas(js.array(deltas.map((delta) => delta._toProxy())));
}
