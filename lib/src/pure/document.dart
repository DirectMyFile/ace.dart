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
    get newLineMode => _newLineMode;
    set newLineMode(String newLineMode) {
      if (_newLineMode != newLineMode) {
        _newLineMode = newLineMode;
      }
    }
  
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
  
  void applyDeltas(List<Delta> deltas) {
    for (int i = 0; i < deltas.length; i++) {
      final delta = deltas[i];
      final range = new Range.fromPoints(delta.range.start, delta.range.end);
      if (delta.action == "insertLines") {
        InsertLinesDelta _delta = delta;
        insertLines(range.start.row, _delta.lines);
      } else if (delta.action == "insertText") {
        InsertTextDelta _delta = delta;
        insert(range.start, _delta.text);
      } else if (delta.action == "removeLines") {
        this._removeLines(range.start.row, range.end.row - 1);
      } else if (delta.action == "removeText") {
        this.remove(range);
      } else {
        throw new ArgumentError('$delta is not a valid type of delta');
      }
    }
  }
  
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
  
  Anchor createAnchor(int row, int column) => new _Anchor(this, row, column);
  
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
  
  String getTextRange(Range range) {
    if (range.start.row == range.end.row) {
      return getLine(range.start.row)
          .substring(range.start.column, range.end.column);
    }
    final lines = getLines(range.start.row, range.end.row);
    if (lines.length == 0) {
      lines.add("");
    } else {
      lines[0] = lines[0].substring(range.start.column);
    }    
    final l = lines.length - 1;
    if (range.end.row - range.start.row == l) {
      lines[l] = lines[l].substring(0, range.end.column);
    }
    return lines.join(newLineCharacter);
  }
  
  Point indexToPosition(int index, {int startRow: 0}) {
    final newlineLength = newLineCharacter.length;
    final l = _lines.length;
    for (int i = startRow; i < l; i++) {
      index -= _lines[i].length + newlineLength;
      if (index < 0) {
        return new Point(i, index + _lines[i].length + newlineLength);
      }        
    }
    return new Point(l - 1, _lines[l - 1].length);
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
    final lineToPosition = line.substring(0, position.column);
    if (position.row < length) {
      _lines[position.row] = lineToPosition;
    } else {
      _lines.insert(position.row, lineToPosition);
    }
    _lines.insert(
        position.row + 1, 
        line.substring(position.column, line.length));
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
  
  Point remove(Range range) {
    range = new Range.fromPoints(
        _clipPosition(range.start), 
        _clipPosition(range.end));
    if (range.isEmpty) {
      return range.start;
    }
    final firstRow = range.start.row;
    final lastRow = range.end.row;
    if (range.isMultiLine) {
      final firstFullRow = range.start.column == 0 ? firstRow : firstRow + 1;
      final lastFullRow = lastRow - 1;
      if (range.end.column > 0) {
        removeInLine(lastRow, 0, range.end.column);
      }
      if (lastFullRow >= firstFullRow) {
        _removeLines(firstFullRow, lastFullRow);
      }
      if (firstFullRow != firstRow) {
        removeInLine(
            firstRow, 
            range.start.column, 
            getLine(firstRow).length);
        removeNewLine(range.start.row);
      }
    } else {
      removeInLine(firstRow, range.start.column, range.end.column);
    }
    return range.start;
  }
  
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
  
  void removeNewLine(int row) {
    final firstLine = this.getLine(row);
    final secondLine = this.getLine(row + 1);
    final range = new Range(row, firstLine.length, row + 1, 0);
    final line = firstLine + secondLine;
    _spliceList(_lines, row, 2, [line]);
    final delta = new RemoveTextDelta._(range, newLineCharacter);
    _onChange.add(delta);
  }
  
  Point replace(Range range, String text) {
    if (text.length == 0 && range.isEmpty) {
      return range.start;
    }
    if (text == getTextRange(range)) {
      return range.end;
    }
    remove(range);
    var end;
    if (text != null) {
      end = insert(range.start, text);
    } else {
      end = range.start;
    }
    return end;
  }
  
  void revertDeltas(List<Delta> deltas) {
    for (int i = deltas.length - 1; i >= 0; i--) {
      final delta = deltas[i];
      final range = new Range.fromPoints(delta.range.start, delta.range.end);
      if (delta.action == "insertLines") {
        _removeLines(range.start.row, range.end.row - 1);
      } else if (delta.action == "insertText") {
        remove(range);
      } else if (delta.action == "removeLines") {
        RemoveLinesDelta _delta = delta;
        _insertLines(range.start.row, _delta.lines);
      } else if (delta.action == "removeText") {
        RemoveTextDelta _delta = delta;
        insert(range.start, _delta.text);
      } else {
        throw new ArgumentError('$delta is not a valid type of delta');
      }
    }
  }
  
  List<String> _split(String text) {
    return text.replaceAll(new RegExp(r"\r\n|\r"), "\n").split("\n");
  }
}
