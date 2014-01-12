part of ace;

class _RangeListProxy extends _HasProxy implements RangeList {
  
  List<Range> 
    get ranges => _rangeList(_proxy['ranges']);
    set ranges(List<Range> ranges) {
      _proxy['ranges'] = _jsArray(ranges.map((r) => r._toProxy()));
    }
    
  _RangeListProxy() 
  : this._(new js.JsObject(_modules['ace/range_list']['RangeList']));
  
  _RangeListProxy._(proxy) : super(proxy);
  
  List<Range> add(Range range) => _rangeList(call('add', [range._toProxy()]));

  List<List<Range>> addList(Iterable<Range> ranges) {
    final lists = call('addList', [_jsArray(ranges.map((r) => r._toProxy()))]);
    return new List.generate(lists['length'], (i) => _rangeList(lists[i]));
  }
  
  bool contains(int row, int column) => call('contains', [row, column]);
  
  bool containsPoint(Point p) => call('containsPoint', [p._toProxy()]);
  
  List<Range> merge() => _rangeList(call('merge'));

  int pointIndex(Point p, { bool excludeEdges: false, int startIndex: 0 }) =>
      call('pointIndex', [p._toProxy(), excludeEdges, startIndex]);
  
  List<Range> substractPoint(Point p) => 
      _rangeList(call('substractPoint', [p._toProxy()]));
  
  List<Range> _rangeList(js.JsObject array) => new List<Range>.generate(
      array['length'], (i) => new Range._(array[i]));
}
