part of ace;

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
}
