part of ace;

class _ModeProxy extends _HasProxy implements Mode {
  
  final String _modePath;
  
  get _mode => _hasProxy ? _proxy : _modePath;
    
  _ModeProxy(String modePath) : super.async(new Future<js.Proxy>(() {
    final completer = new Completer<js.Proxy>();
    _context.ace.config.loadModule(js.array(['mode', modePath]), 
        new js.Callback.once((module) {
            completer.complete(js.retain(new js.Proxy(module.Mode)));
        }));
    return completer.future;
  })), _modePath = modePath ;
  
  _ModeProxy._(js.Proxy proxy) : super(proxy), _modePath = null;
}
