part of ace;

class _Document implements Document {
  
  static final _newLineRegExp = new RegExp(r"/^.*?(\r\n|\r|\n)/m");
  
  final List<String> _lines = new List<String>();
  String _autoNewLine = "\n";
  String _newLineMode = "auto";
    
  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;
  
  int get length => _lines.length;
  
  String get newLineCharacter {
    switch (_newLineMode) {
      case "windows":
        return "\r\n";
      case "unix":
        return "\n";
      default:
        return _autoNewLine;
    }
  }
  
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
  
  void _detectNewLine(String text) {
    var match = _newLineRegExp.firstMatch(text);
    _autoNewLine = match != null ? match : "\n";
  }
  
  List<String> getAllLines() => _lines.toList(growable: false);
  
  List<String> getLines(int firstRow, int lastRow) => 
      _lines.getRange(firstRow, lastRow + 1).toList(growable: false);
  
  String getLine(int row) {
    if (row < 0 || row >= length) return "";
    return _lines[row];
  }
  
  Point insert(Point position, String text) {
    if (text == null || text.length == 0) {
      return position;
    }
    position = _clipPosition(position);    
    if (length <= 1) {
      _detectNewLine(text);
    }      
    final lines = _split(text);
    final firstLine = lines.removeAt(0);
    final lastLine = lines.length == 0 ? null : lines.removeLast();
    position = insertInLine(position, firstLine);
    if (lastLine != null) {
      position = insertNewLine(position);
      position = _insertLines(position.row, lines);
      position = insertInLine(position, lastLine != null ? lastLine : "");
    }
    return position;
  }
  
  Point insertInLine(Point position, String text) {
    if (text.length == 0) return position;        
    final line = (position.row >= length) ? "" : _lines[position.row];    
    final lineText = 
        line.substring(0, position.column) + 
        text + 
        line.substring(position.column);
    if (position.row < length) {
      _lines[position.row] = lineText;
    } else {
      _lines.insert(position.row, lineText);
    }
    final end = new Point(position.row, position.column + text.length);
    final delta = new InsertTextDelta._(
        new Range.fromPoints(position, end), text);
    _onChange.add(delta);
    return end;
  }
  
  Point insertLines(int row, List<String> lines) {
    if (row >= length) {
      return insert(new Point(row, 0), "\n" + lines.join("\n"));
    }
    return _insertLines(math.max(row, 0), lines);
  }
  
  Point _insertLines(int row, List<String> lines) {
    if (lines.length == 0) {
      return new Point(row, 0);
    }      
    var end;
    if (lines.length > 0xFFFF) {
      end = this._insertLines(row, lines.getRange(0xFFFF, lines.length));
      lines = lines.getRange(0, 0xFFFF);
    }
    _lines.insertAll(row, lines);
    final range = new Range(row, 0, row + lines.length, 0);
    final delta = new InsertLinesDelta._(range, lines); 
    _onChange.add(delta);
    return (end == null) ? range.end : end;
  }
  
  Point insertNewLine(Point position) {
    position = _clipPosition(position);
    final line = (position.row >= length) ? "" : _lines[position.row];
    _lines[position.row] = line.substring(0, position.column);
    _lines.add(line.substring(position.column, line.length));
    final end = new Point(position.row + 1, 0);
    final delta = new InsertTextDelta._(
        new Range.fromPoints(position, end), newLineCharacter);
    _onChange.add(delta);
    return end;
  }
  
  bool isNewLine(String text) => 
      (text == "\r\n" || text == "\r" || text == "\n");
  
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
  
  List<String> removeLines(int startRow, int endRow) {
    assert(startRow >= 0);
    assert(endRow < length);
    return this._removeLines(startRow, endRow);
  }
  
  List<String> _removeLines(int startRow, int endRow) {
    final range = new Range(startRow, 0, endRow + 1, 0);
    final removed = _spliceList(_lines, startRow, endRow - startRow + 1);
    final delta = new RemoveLinesDelta._(range, removed, newLineCharacter);
    _onChange.add(delta);
    return removed;
  }
  
  void removeNewLine(int row) => throw new UnimplementedError();
  
  Point replace(Range range, String text) => throw new UnimplementedError();
  
  void revertDeltas(Iterable<Delta> deltas) => throw new UnimplementedError();
  
  List<String> _split(String text) {
    return text.replaceAll(r"/\r\n|\r/g", "\n").split("\n");
  }
}
