part of ace.proxy;

class _KeyboardHandlerProxy extends HasProxy implements KeyboardHandler {

  bool get isLoaded => _hasProxy;
  
  String get name => (path == null) ? null 
      : implementation.getExtension(path, separator: '/');
  
  Future get onLoad => _onHasProxy;
  
  final String path;
  
  get _handler => _hasProxy ? _proxy : path;
  
  _KeyboardHandlerProxy(String path) 
  : super.async(
      _loadModule('keybinding', path)
      .then((module) => new Future.value(module['handler'])))
  , path = path;

  _KeyboardHandlerProxy._(js.JsObject proxy) 
  : super.async(new Future.sync(() => proxy))
  , path = (proxy == null) ? null : proxy[r'$id'];
}
