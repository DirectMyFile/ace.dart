part of ace;

abstract class RangeList extends Disposable {
  
  List<Range> ranges;
  
  factory RangeList() => implementation.createRangeList();
  
  List<Range> add(Range range);
  
  List<List<Range>> addList(Iterable<Range> ranges);
  
  bool contains(int row, int column);
  
  bool containsPoint(Point p);
  
  List<Range> merge();
  
  int pointIndex(Point p, { bool excludeEdges: false, int startIndex: 0 });
  
  List<Range> substractPoint(Point p);
}
