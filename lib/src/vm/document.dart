part of ace;

class _Document implements Document {
  final List<String> _lines = new List<String>();
  
  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;
  
  int get length => _lines.length;
  
  String get newLineCharacter => throw new UnimplementedError();
  
  String 
    get newLineMode => throw new UnimplementedError();
    set newLineMode(String newLineMode) => throw new UnimplementedError();
  
  String
    get value => getAllLines().join(newLineCharacter);
    set value(String text) {
      final len = length;
      remove(new Range(0, 0, len, getLine(len - 1).length));
      insert(const Point(0, 0), text);
    }
    
  _Document([String text = '']) {
    if (text.length == 0) {
      _lines.add('');
    } else {
      insert(const Point(0, 0), text);
    }
  }
    
  void dispose() {
    _onChange.close();
  }
  
  void applyDeltas(Iterable<Delta> deltas) => throw new UnimplementedError();
  
  Point _clipPosition(Point position) {
    final length = this.length;
    var row = position.row;
    var column = position.column;
    if (row >= length) {
      row = math.max(0, length - 1);
      column = getLine(length - 1).length;
    } else if (row < 0) {
      row = 0;
    }
    return new Point(row, column);
  }
  
  Anchor createAnchor(int row, int column) => throw new UnimplementedError();
  
  List<String> getAllLines() => _lines.toList(growable: false);
  
  List<String> getLines(int firstRow, int lastRow) => 
      _lines.getRange(firstRow, lastRow + 1).toList(growable: false);
  
  String getLine(int row) => throw new UnimplementedError();
  
  Point insert(Point position, String text) => throw new UnimplementedError();
  
  Point insertInLine(Point position, String text) {
    if (text.length == 0) return position;    
    var line = _lines[position.row];
    if (line == null) line = "";
    _lines[position.row] = 
        line.substring(0, position.column) + 
        text + 
        line.substring(position.column);
    final end = new Point(position.row, position.column + text.length);
    final delta = new InsertTextDelta._(
        new Range.fromPoints(position, end), text);    
    _onChange.add(delta);
    return end;
  }
  
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
  
  Point removeInLine(int row, int startColumn, int endColumn) {
    if (startColumn == endColumn) {
      return new Point(row, startColumn);
    }
    final range = new Range(row, startColumn, row, endColumn);
    final line = getLine(row);
    final removed = line.substring(startColumn, endColumn);
    final newLine = line.substring(0, startColumn) + 
        line.substring(endColumn, line.length);
    _lines.replaceRange(row, row + 1, [newLine]);    
    final delta = new RemoveTextDelta._(range, removed);
    _onChange.add(delta);
    return range.start;
  }
  
  List<String> removeLines(int startRow, int endRow) => 
      throw new UnimplementedError();
  
  void removeNewLine(int row) => throw new UnimplementedError();
  
  Point replace(Range range, String text) => throw new UnimplementedError();
  
  void revertDeltas(Iterable<Delta> deltas) => throw new UnimplementedError();
}
