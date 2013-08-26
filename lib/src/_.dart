part of ace;

get _context => js.context;

abstract class _HasProxy {
  var _proxy;
  
  final Future onHasProxy;
  
  bool get hasProxy => _proxy != null;
      
  _HasProxy.async(Future<js.Proxy> proxyFuture) 
      : onHasProxy = proxyFuture {
    proxyFuture.then((proxy) => _proxy = proxy);
  }
  
  _HasProxy(js.Proxy proxy) 
      : _proxy = js.retain(proxy)
      , onHasProxy = new Future.value();
  
  void dispose() {
    assert(hasProxy);
    _onDispose();
    js.release(_proxy);
    _proxy = null;
  }
  
  void _onDispose() {}
  
  String toString() => _context.JSON.stringify(_proxy);
}
