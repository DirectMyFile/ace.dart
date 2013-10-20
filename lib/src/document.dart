part of ace;

/// Encapsulates the text of a document. 
/// 
/// At its core, a [Document] is just an array of strings where the index of the
/// array points to a row in the document.
/// 
/// An instance of [Document] may be attached to more than one [EditSession].
abstract class Document extends _Disposable {

  /// Fired whenever this document changes.
  Stream<Delta> get onChange;
  
  /// The number of rows in this document.
  int get length;
  
  /// The current newline character, based on the current [newLineMode].
  String get newLineCharacter;
      
  /// The new line mode.  May be one of `windows`, `unix` or `auto`.
  // TODO(rms): enum
  String newLineMode;
    
  /// All the lines in this document as a single string, split by the 
  /// [newLineCharacter].  
  String value;

  /// Creates a new Document with the given [text], if any, or else it is empty.
  /// 
  /// **WARNING** do not set [useExperimental] to `true` in production code; 
  /// this is an experimental flag to enable continuous integration testing of a 
  /// work-in-progress pure Dart implementation, and may be removed at any time.
  factory Document({ String text: '', bool useExperimental: false }) {
    if (useExperimental) {
      return new _Document(text);
    } else {
      return new _DocumentProxy(text);
    }
  }
  
  /// Applies all of the given [deltas] to this document in the order given.
  void applyDeltas(List<Delta> deltas);
  
  /// Creates a new [Anchor] to define a floating point in this document.
  Anchor createAnchor(int row, int column);
  
  /// Returns a copy of all the lines in this document.
  List<String> getAllLines();
  
  /// Returns a copy of the lines between [firstRow] and [lastRow], inclusive.
  List<String> getLines(int firstRow, int lastRow);
  
  /// Returns a verbatim copy of the given line [row] as it is in this document.
  String getLine(int row);
  
  /// Returns all of the text within the given [range] of this document as a 
  /// single string.
  String getTextRange(Range range);
  
  /// Converts the given character [index] in this document to a [Point].
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
  Point indexToPosition(int index, {int startRow: 0});
  
  /// Inserts a block of [text] at the given [position] and returns a point at
  /// the end of the inserted text.  This method also fires an [onChange] event.
  Point insert(Point position, String text);
  
  /// Inserts [text] into the [position] at the current row and returns a point
  /// at the end of the inserted text.  This method also fires an [onChange]
  /// event.
  Point insertInLine(Point position, String text);
  
  /// Inserts the given [lines] into the document, starting at the given [row]
  /// and returns a point at the end of the inserted lines.  This method also 
  /// fires an [onChange] event.
  Point insertLines(int row, List<String> lines);
  
  /// Inserts a [newLineCharacter] into this document at the current row's 
  /// position and returns a point at the end of the insertion.  This method 
  /// also fires an [onChange] event.
  Point insertNewLine(Point position);
  
  /// Returns `true` if [text] is a newline character.  That is, one of `\r\n`, 
  /// `\r` or `\n`.
  bool isNewLine(String text);
  
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
  int positionToIndex(Point position, {int startRow: 0});
  
  /// Removes the given [range] from this document.
  Point remove(Range range);
  
  /// Removes the range specified by [row/startColumn] -> [row/endColumn] and 
  /// returns the removed [range.start] point.  
  /// 
  /// This method also fires an [onChange] event.
  Point removeInLine(int row, int startColumn, int endColumn);
  
  /// Removes the range of lines from the given [startRow] -> [endRow], 
  /// inclusive, and returns the removed lines.  
  /// 
  /// This method also fires an [onChange] event.
  List<String> removeLines(int startRow, int endRow);
  
  /// Removes the [newLineCharacter] between the given [row] and the row 
  /// immediately following it.  This method also fires an [onChange] event.
  void removeNewLine(int row);
  
  /// Replaces a given [range] in this document with the new [text] and returns
  /// a point at the end of the new text.
  Point replace(Range range, String text);
  
  /// Reverts all of the given [deltas] to this document in reverse of the 
  /// order given.
  void revertDeltas(List<Delta> deltas);
}
