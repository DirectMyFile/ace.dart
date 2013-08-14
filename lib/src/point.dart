part of ace;

class Point {
  final int row;
  final int column;
  Point(this.row, this.column);
  Point._fromProxy(p) : this(p.row, p.column);  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Point) return false; 
    return row == other.row && column == other.column;
  }  
  int get hashCode => row.hashCode ^ column.hashCode;
  js.Proxy _toProxy() => js.map({'row': row, 'column': column});
  String toString() => 'Point: [${row}/${column}]';
}
