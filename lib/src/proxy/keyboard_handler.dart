part of ace;

class _KeyboardHandlerProxy extends _HasProxy implements KeyboardHandler {

  bool get isLoaded => _hasProxy;
  
  Future get onLoad => _onHasProxy;
  
  final String path;
  
  _KeyboardHandlerProxy(String path) 
  : super.async(
      _loadModule('keybinding', path)
      .then((module) => new Future.value(module['handler'])))
  , path = path;

  _KeyboardHandlerProxy._(js.JsObject proxy) 
  : super(proxy)
  , path = proxy[r'$id'];
}
