part of ace.proxy;

class _RangeListProxy extends HasProxy implements RangeList {
  
  List<Range> 
    get ranges => _rangeList(_proxy['ranges']);
    set ranges(List<Range> ranges) {
      _proxy['ranges'] = _jsArray(ranges.map((r) => _jsRange(r)));
    }
    
  _RangeListProxy() 
  : this._(new js.JsObject(_modules['ace/range_list']['RangeList']));
  
  _RangeListProxy._(proxy) : super(proxy);
  
  List<Range> add(Range range) => 
      _rangeList(call('add', [_jsRange(range)]));

  List<List<Range>> addList(Iterable<Range> ranges) {
    final lists = call('addList', [_jsArray(ranges.map((r) => _jsRange(r)))]);
    return new List.generate(lists['length'], (i) => _rangeList(lists[i]));
  }
  
  bool contains(int row, int column) => call('contains', [row, column]);
  
  bool containsPoint(Point p) => call('containsPoint', [_jsPoint(p)]);
  
  List<Range> merge() => _rangeList(call('merge'));

  int pointIndex(Point p, { bool excludeEdges: false, int startIndex: 0 }) =>
      call('pointIndex', [_jsPoint(p), excludeEdges, startIndex]);
  
  List<Range> substractPoint(Point p) => 
      _rangeList(call('substractPoint', [_jsPoint(p)]));
  
  List<Range> _rangeList(js.JsObject array) => new List<Range>.generate(
      array['length'], (i) => _range(array[i]));
}
