part of ace;

/// A region within an [Editor].
/// 
/// A [Range] can be thought of as a rectangle from a [start] point to an [end]
/// point.
class Range {
  final Point start;
  final Point end;

  /// Returns _true_ if this range's [start] point equals its [end] point.
  bool get isEmpty => start.row == end.row && start.column == end.column;
  /// Returns _true_ if this range spans across multiple lines.
  bool get isMultiLine => start.row != end.row;
  
  Range(int startRow, int startColumn, int endRow, int endColumn)
      : this.fromPoints(new Point(startRow, startColumn), 
                        new Point(endRow, endColumn));
  
  Range.fromPoints(this.start, this.end);
  
  Range._fromProxy(p)
      : this(p.start.row, p.start.column, p.end.row, p.end.column);
  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Range) return false; 
    return start == other.start && end == other.end;
  }  
  int get hashCode => start.hashCode ^ end.hashCode;
  
  js.Proxy _toProxy() => 
      new js.Proxy(_context.ace.define.modules['ace/range'].Range, 
          start.row, start.column, end.row, end.column);
  
  String toString() => 
      'Range: [${start.row}/${start.column}] -> [${end.row}/${end.column}]';
}
