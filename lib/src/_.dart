part of ace;

get _context => js.context;

List _list(js.Proxy array) => JSON.decode(_context.JSON.stringify(array));

abstract class _HasProxy {
  var _proxy;
  
  final Future _onHasProxy;
  
  bool get _hasProxy => _proxy != null;
      
  _HasProxy.async(Future<js.Proxy> proxyFuture) 
      : _onHasProxy = proxyFuture {
    proxyFuture.then((proxy) => _proxy = proxy);
  }
  
  _HasProxy(js.Proxy proxy) 
      : _proxy = js.retain(proxy)
      , _onHasProxy = new Future.value();
  
  /// Dispose of any resources held by this object.
  /// 
  /// This method will release any javascript proxy objects help by this 
  /// object.  It will also close any streams exposed by the object.  It is an
  /// error to call any methods or access any fields of this object after this
  /// method has been called.
  void dispose() {
    if (_hasProxy) {
      _onDispose();
      js.release(_proxy);
      _proxy = null;
    }
  }
  
  void _onDispose() {}
  
  String toString() => _context.JSON.stringify(_proxy);
}
