part of ace;

class _ModeProxy extends _HasProxy implements Mode {
  
  final String _modePath;
  
  bool get isLoaded => _hasProxy;
  
  Future get onLoad => _onHasProxy;
  
  get _mode => _hasProxy ? _proxy : _modePath;
    
  _ModeProxy(String modePath) 
  : super.async(_loadModule('mode', modePath))
  , _modePath = modePath ;
  
  _ModeProxy._(js.JsObject proxy) : super(proxy), _modePath = null;
}
