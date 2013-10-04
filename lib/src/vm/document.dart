part of ace;

class _Document implements Document {
  final List<String> _lines = new List<String>();
  
  Stream<Delta> get onChange => throw new UnimplementedError();
  
  int get length => _lines.length;
  
  String get newLineCharacter => throw new UnimplementedError();
  
  String 
    get newLineMode => throw new UnimplementedError();
    set newLineMode(String newLineMode) => throw new UnimplementedError();
  
  String
    get value => throw new UnimplementedError();
    set value(String text) => throw new UnimplementedError();
    
  _Document([String text = '']) {
    if (text.length == 0) {
      _lines.add('');
    } else {
      insert(const Point(0, 0), text);
    }
  }
    
  void dispose() => throw new UnimplementedError();
  
  void applyDeltas(Iterable<Delta> deltas) => throw new UnimplementedError();
  
  Anchor createAnchor(int row, int column) => throw new UnimplementedError();
  
  List<String> getAllLines() => throw new UnimplementedError();
  
  List<String> getLines(int firstRow, int lastRow) => 
      throw new UnimplementedError();
  
  String getLine(int row) => throw new UnimplementedError();
  
  Point insert(Point position, String text) => throw new UnimplementedError();
  
  Point insertInLine(Point position, String text) => 
      throw new UnimplementedError();
  
  Point insertLines(int row, Iterable<String> lines) => 
      throw new UnimplementedError();
  
  Point insertNewLine(Point position) => throw new UnimplementedError();
  
  bool isNewLine(String text) => throw new UnimplementedError();
  
  int positionToIndex(Point position, {int startRow: 0}) {
    final newlineLength = newLineCharacter.length;
    var index = 0;
    final row = math.min(position.row, _lines.length);
    for (int i = startRow; i < row; i++) {
      index += _lines[i].length + newlineLength;
    }
    return index + position.column;
  }
  
  Point remove(Range range) => throw new UnimplementedError();
  
  Point removeInLine(int row, int startColumn, int endColumn) => 
      throw new UnimplementedError();
  
  List<String> removeLines(int startRow, int endRow) => 
      throw new UnimplementedError();
  
  void removeNewLine(int row) => throw new UnimplementedError();
  
  Point replace(Range range, String text) => throw new UnimplementedError();
  
  void revertDeltas(Iterable<Delta> deltas) => throw new UnimplementedError();
}
