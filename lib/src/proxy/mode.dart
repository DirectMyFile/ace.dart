part of ace;

class _ModeProxy extends _HasProxy implements Mode {
  
  final String _modePath;
  
  get _mode => _hasProxy ? _proxy : _modePath;
    
  _ModeProxy(String modePath) : super.async(new Future<js.JsObject>(() {
    final completer = new Completer<js.JsObject>();
    _context['ace']['config'].callMethod('loadModule', 
        [new js.JsObject.jsify(['mode', modePath]), 
        (module) => completer.complete(module[Mode])]);
    return completer.future;
  })), _modePath = modePath ;
  
  _ModeProxy._(js.JsObject proxy) : super(proxy), _modePath = null;
}
