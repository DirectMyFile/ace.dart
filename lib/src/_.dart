part of ace;

get _context => js.context;

abstract class _HasProxy {
  var _proxy;
  
  /// A future that completes when this object first obtains an underlying
  /// javascript proxy object.
  /// 
  /// Some of the objects in Ace require an asynchronous computation to fully
  /// initialize the underlying proxy.  This future provides a way to observe
  /// when that computations has completed.
  final Future onHasProxy;
  
  /// Returns `true` if this object has an underlying javascript proxy object.
  bool get hasProxy => _proxy != null;
      
  _HasProxy.async(Future<js.Proxy> proxyFuture) 
      : onHasProxy = proxyFuture {
    proxyFuture.then((proxy) => _proxy = proxy);
  }
  
  _HasProxy(js.Proxy proxy) 
      : _proxy = js.retain(proxy)
      , onHasProxy = new Future.value();
  
  /// Dispose of and release the underlying javascript proxy object, if any.
  void dispose() {
    if (hasProxy) {
      _onDispose();
      js.release(_proxy);
      _proxy = null;
    }
  }
  
  void _onDispose() {}
  
  String toString() => _context.JSON.stringify(_proxy);
}
