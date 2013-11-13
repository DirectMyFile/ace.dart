part of ace;

class _KeyboardHandlerProxy extends _HasProxy implements KeyboardHandler {

  _KeyboardHandlerProxy(String name) : super.async(new Future<js.JsObject>(() {
    final completer = new Completer<js.JsObject>();
    _context['ace']['config'].callMethod('loadModule',
        [_jsify(['keybinding', name]), (module) => completer.complete(module)]);
    return completer.future;
  }));

  _KeyboardHandlerProxy._(js.JsObject proxy) : super(proxy);
}
