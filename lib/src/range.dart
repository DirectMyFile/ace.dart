part of ace;

class Point {
  final int row;
  final int column;
  Point(this.row, this.column);
  Point._fromProxy(js.Proxy p) : this(p.row, p.column);  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Point) return false; 
    return row == other.row && column == other.column;
  }  
  int get hashCode => row.hashCode ^ column.hashCode;
  String toString() => 'Point: [${row}/${column}]';
}

class Range {
  final Point start;
  final Point end;
  
  bool get isEmpty => start.row == end.row && start.column == end.column;
  bool get isMultiLine => start.row != end.row;
  
  Range(int startRow, int startColumn, int endRow, int endColumn)
      : this.fromPoints(new Point(startRow, startColumn), 
                        new Point(endRow, endColumn));
  
  Range.fromPoints(this.start, this.end);
  
  Range._fromProxy(js.Proxy p)
      : this(p.start.row, p.start.column, p.end.row, p.end.column);
  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Range) return false; 
    return start == other.start && end == other.end;
  }  
  int get hashCode => start.hashCode ^ end.hashCode;
  
  js.Proxy _toProxy() {
    // TODO(rms): create a new js.Proxy using js Range ctor function
  }
  
  String toString() => 
      'Range: [${start.row}/${start.column}] -> [${end.row}/${end.column}]';
}
