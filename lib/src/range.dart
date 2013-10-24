part of ace;

/// A region within an [Editor].
/// 
/// A [Range] can be thought of as a rectangle from a [start] point to an [end]
/// point.
class Range implements Comparable<Range> {
    
  /// The start point of this range.
  Point start;
  
  /// The end point of this range.
  Point end;

  /// Returns _true_ if this range's [start] point equals its [end] point.
  bool get isEmpty => start.row == end.row && start.column == end.column;
  
  /// Returns _true_ if this range spans across multiple lines.
  bool get isMultiLine => start.row != end.row;
  
  Range(int startRow, int startColumn, int endRow, int endColumn)
  : this.fromPoints(
      new Point(startRow, startColumn), 
      new Point(endRow, endColumn));
  
  /// Constructs a new [Range] that is a copy of the given [other].
  Range.copy(Range other) 
    : this(
        other.start.row, 
        other.start.column, 
        other.end.row, 
        other.end.column);
  
  Range.fromPoints(this.start, this.end);
  
  /// Creates a new range that is the union of all the given [ranges].
  /// 
  /// The returned range has a [start] point that comes first among all the
  /// given [ranges] and an [end] point that comes last among all the given 
  /// [ranges].
  /// 
  /// If the given [ranges] is an empty iterable this throws an [ArgumentError].
  factory Range.union(Iterable<Range> ranges)  {
    if (ranges.isEmpty) {
      throw new ArgumentError('ranges must not be empty.');
    }
    final initialValue = new Range.copy(ranges.first);    
    return ranges.skip(1).fold(initialValue, (Range value, Range e) {
      final cmp = value.compareTo(e);
      if (cmp == 0) {
        return value;
      } else if (cmp < 0) {
        value.start = new Point(e.start.row, e.start.column);      
      } else {
        value.end = new Point(e.end.row, e.end.column);  
      }
      return value;
    });
  }
  
  Range._(proxy) 
  : this(
      proxy['start']['row'], 
      proxy['start']['column'], 
      proxy['end']['row'], 
      proxy['end']['column']);
  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Range) return false; 
    final o = other;
    return start == o.start && end == o.end;
  }
  
  int get hashCode => start.hashCode ^ end.hashCode;
  
  /// Compares the given [row] and [column] with this range.
  /// 
  /// This algorithm will return the following values:
  /// 
  ///     -1  if the point comes before this range
  ///     0   if the point comes within this range
  ///     1   if the point comes after this range   
  int compare(int row, int column) {
    if (!isMultiLine) {
      if (row == start.row) {        
        return column < start.column ? -1 : (column > end.column ? 1 : 0);
      };
    }
    if (row < start.row)  return -1;
    if (row > end.row)    return 1;
    if (start.row == row) return column >= start.column ? 0 : -1;
    if (end.row == row)   return column <= end.column ? 0 : 1;
    return 0;
  }
  
  int compareEnd(int row, int column) {
    if (end.row == row && end.column == column) {
      return 1;
    } else {
      return compare(row, column);
    }
  }
  
  int compareInside(int row, int column) {
    if (end.row == row && end.column == column) {
      return 1;
    } else if (start.row == row && start.column == column) {
      return -1;
    } else {
      return compare(row, column);
    }
  }
  
  int comparePoint(Point point) => compare(point.row, point.column);
  
  // TODO(rms): figure this out and document + test it
  int compareRange(Range range) {
    var cmp,
        end = range.end,
        start = range.start;

    cmp = compare(end.row, end.column);
    if (cmp == 1) {
      cmp = compare(start.row, start.column);
      if (cmp == 1) {
        return 2;
      } else if (cmp == 0) {
        return 1;
      } else {
        return 0;
      }
    } else if (cmp == -1) {
      return -2;
    } else {
      cmp = compare(start.row, start.column);
      if (cmp == -1) {
        return -1;
      } else if (cmp == 1) {
        return 42;
      } else {
        return 0;
      }
    }
  }
  
  int compareStart(int row, int column) {
    if (start.row == row && start.column == column) {
      return -1;
    } else {
      return compare(row, column);
    }
  }
  
  /// Compares the given [other] with this range.
  /// 
  /// This method forwards the call to the [compareRange] method.
  int compareTo(Range other) => compareRange(other);
  
  /// Returns `true` if the given [row] and [column] are within this range.
  /// 
  /// This method performs a check that is _endpoint - inclusive_.  That is, it
  /// will return `true` if:
  /// 
  ///     start.row     <= row      <= end.row      &&
  ///     start.column  <= column   <= end.column
  bool contains(int row, int column) => compare(row, column) == 0;
  
  /// Returns `true` if the given [other] is within this range.
  /// 
  /// This method performs a check that is _endpoint - inclusive_.
  bool containsRange(Range other) => 
      comparePoint(other.start) == 0 && comparePoint(other.end) == 0;
  
  /// Returns `true` if the given `other` intersects this range.
  bool intersects(Range other) {
    final cmp = compareRange(other);
    return (cmp == -1 || cmp == 0 || cmp == 1);
  }
  
  /// Returns `true` if the point given by [row] and [column] is equal to this
  /// range's [end] point.
  bool isEnd(int row, int column) => end.row == row && end.column == column;
  
  /// Returns `true` if the point given by [row] and [column] is equal to this
  /// range's [start] point.
  bool isStart(int row, int column) => 
      start.row == row && start.column == column;
  
  js.JsObject _toProxy() => 
      new js.JsObject(_modules['ace/range'][Range], 
          [start.row, start.column, end.row, end.column]);
  
  String toString() => 
      'Range: [${start.row}/${start.column}] -> [${end.row}/${end.column}]';
}
