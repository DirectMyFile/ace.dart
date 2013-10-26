part of ace;

class _SearchProxy extends _HasProxy implements Search {
  
  SearchOptions
    get options => new SearchOptions._(call('getOptions'));
    set options(SearchOptions options) => 
        call('setOptions', [options._toProxy()]);
  
  _SearchProxy()
  : super(new js.JsObject(_modules['ace/search']['Search']));
  
  Range find(EditSession session) {
    assert(session is _EditSessionProxy);
    final range = call('find', [(session as _EditSessionProxy)._proxy]);
    return range == null ? null : new Range._(range);
  }
  
  Iterable<Range> findAll(EditSession session) {
    assert (session is _EditSessionProxy);
    return _list(call('findAll', [(session as _EditSessionProxy)._proxy]))
        .map((range) => new Range._(_jsify(range)));
  }
}
