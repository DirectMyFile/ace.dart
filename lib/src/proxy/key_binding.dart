part of ace;

class _KeyBindingProxy extends _HasProxy implements KeyBinding {

  KeyboardHandler get keyboardHandler {
    js.JsObject proxy = call('getKeyboardHandler');
    return proxy == null ? null : new _KeyboardHandlerProxy._(proxy);
  }

  set keyboardHandler(KeyboardHandler handler) {
    if (handler == null) {
      call('setKeyboardHandler', [null]);
    } else {
      assert(handler is _KeyboardHandlerProxy);
      call('setKeyboardHandler', [(handler as _KeyboardHandlerProxy)._proxy]);
    }
  }

  _KeyBindingProxy._(js.JsObject proxy) : super(proxy);
}
