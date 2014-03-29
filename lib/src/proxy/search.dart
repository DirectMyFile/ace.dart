part of ace.proxy;

class _SearchProxy extends HasProxy implements Search {
  
  SearchOptions
    get options => _searchOptions(call('getOptions'));
    set options(SearchOptions options) => 
        call('setOptions', [_jsSearchOptions(options)]);
  
  _SearchProxy()
  : super(new js.JsObject(_modules['ace/search']['Search']));
  
  Range find(EditSession session) {
    assert(session is _EditSessionProxy);
    final proxy = call('find', [(session as _EditSessionProxy)._proxy]);
    return proxy == null ? null : _range(proxy);
  }
  
  Iterable<Range> findAll(EditSession session) {
    assert (session is _EditSessionProxy);
    return _list(call('findAll', [(session as _EditSessionProxy)._proxy]))
        .map((proxy) => _range(proxy));
  }
}
