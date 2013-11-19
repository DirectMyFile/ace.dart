part of ace;

class _KeyBindingProxy extends _HasProxy implements KeyBinding {

  KeyboardHandler
    get keyboardHandler => 
        new _KeyboardHandlerProxy._(call('getKeyboardHandler'));
    set keyboardHandler(KeyboardHandler handler) {
      assert(handler is _KeyboardHandlerProxy);
      handler.onLoad.then((_) {
        call('setKeyboardHandler', [(handler as _KeyboardHandlerProxy)._proxy]);
      });
    }

  _KeyBindingProxy._(js.JsObject proxy) : super(proxy);
}
