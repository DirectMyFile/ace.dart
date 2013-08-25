part of ace;

get _context => js.context;

abstract class _HasProxy {
  var _proxy;

  bool get isDisposed => _proxy == null;
  
  _HasProxy(js.Proxy proxy) : _proxy = js.retain(proxy);  
  
  void dispose() {
    assert(!isDisposed);
    _onDispose();
    js.release(_proxy);
    _proxy = null;
  }
  
  void _onDispose() {}
  
  String toString() => _context.JSON.stringify(_proxy);
}
