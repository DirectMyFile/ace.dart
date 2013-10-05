part of ace;

class _ThemeProxy extends _HasProxy implements Theme {
  
  final String _themePath;
  
  get _theme => _hasProxy ? _proxy : _themePath;
  
  String get cssClass {
    if (!_hasProxy) throw new StateError('$_themePath is not yet loaded.');
    return _proxy.cssClass;
  }
  
  String get cssText {
    if (!_hasProxy) throw new StateError('$_themePath is not yet loaded.');
    return _proxy.cssText;
  }
  
  bool get isDark {
    if (!_hasProxy) throw new StateError('$_themePath is not yet loaded.');
    return _proxy.isDark;
  }
  
  _ThemeProxy.named(String name) : this('ace/theme/$name');
  
  _ThemeProxy(String themePath) : super.async(new Future<js.Proxy>(() {
    final completer = new Completer<js.Proxy>();
    _context.ace.config.loadModule(js.array(['theme', themePath]), 
        new js.Callback.once((module) {
            completer.complete(js.retain(module));
        }));
    return completer.future;
  })), _themePath = themePath;
  
  _ThemeProxy._(js.Proxy proxy) : super(proxy), _themePath = null;
}
