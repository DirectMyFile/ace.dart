part of ace;

get _context => js.context;

abstract class _HasProxy {
  var _proxy;
  
  /// A future that completes when this object first obtains an underlying
  /// javascript proxy object.
  /// 
  /// Some of the objects in Ace require an asynchronous computation to fully
  /// initialize the underlying proxy.  This future provides a way to observe
  /// when that computation has completed.
  final Future _onHasProxy;
  
  /// Returns `true` if this object has an underlying javascript proxy object.
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
