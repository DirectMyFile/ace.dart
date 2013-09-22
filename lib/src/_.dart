part of ace;

get _context => js.context;

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
  
  /// Dispose of and release the underlying javascript proxy object, if any.
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
