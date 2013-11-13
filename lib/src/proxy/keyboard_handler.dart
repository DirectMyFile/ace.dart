part of ace;

class _KeyboardHandlerProxy extends _HasProxy implements KeyboardHandler {

  _KeyboardHandlerProxy(String name) : super.async(_loadModule('keybinding', name));

  _KeyboardHandlerProxy._(js.JsObject proxy) : super(proxy);
  
  String get id => _proxy[r'$id'];
}
