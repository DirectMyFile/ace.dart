part of ace;

class _SearchProxy extends _HasProxy implements Search {
  
  SearchOptions
    get options => new SearchOptions._(_proxy.getOptions());
    set options(SearchOptions options) => _proxy.setOptions(options._toProxy());
  
  _SearchProxy()
  : super(new js.Proxy(_context.ace.define.modules['ace/search'].Search));
  
  Range find(EditSession session) {
    final range = _proxy.find(session._proxy);
    return range == null ? null : new Range._(range);
  }
  
  Iterable<Range> findAll(EditSession session) => 
      _list(_proxy.findAll(session._proxy))
      .map((range) => new Range._(js.map(range)));
}
