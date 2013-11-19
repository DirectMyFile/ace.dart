part of ace;

class _KeyboardHandlerProxy extends _HasProxy implements KeyboardHandler {

  bool get isLoaded => _hasProxy;
  
  String get name => (path == null) ? null : _ext(path, separator: '/');
  
  Future get onLoad => _onHasProxy;
  
  final String path;
  
  get _handler => _hasProxy ? _proxy : path;
  
  _KeyboardHandlerProxy(String path) 
  : super.async(
      _loadModule('keybinding', path)
      .then((module) => new Future.value(module['handler'])))
  , path = path;

  _KeyboardHandlerProxy._(js.JsObject proxy) 
  : super(proxy)
  , path = (proxy == null) ? null : proxy[r'$id'];
}
