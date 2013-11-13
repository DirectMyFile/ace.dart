part of ace;

class _ModeProxy extends _HasProxy implements Mode {
  
  final String path;
  
  bool get isLoaded => _hasProxy;
    
  Future get onLoad => _onHasProxy;
  
  get _mode => _hasProxy ? _proxy : path;
    
  _ModeProxy(String path) 
  : super.async(_loadModule('mode', path))
  , path = path;
  
  _ModeProxy._(js.JsObject proxy) : super(proxy), path = null;
}
