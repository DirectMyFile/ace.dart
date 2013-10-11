part of ace;

class _ThemeProxy extends _HasProxy implements Theme {
  
  String get cssClass {
    if (!isLoaded) throw new StateError('$path is not yet loaded.');
    return _proxy.cssClass;
  }
  
  String get cssText {
    if (!isLoaded) throw new StateError('$path is not yet loaded.');
    return _proxy.cssText;
  }
  
  bool get isDark {
    if (!isLoaded) throw new StateError('$path is not yet loaded.');
    return _proxy.isDark;
  }
  
  bool get isLoaded => _hasProxy;
  
  String get name => _ext(path, separator: '/');
  
  Future get onLoad => _onHasProxy;
  
  final String path;
  
  get _theme => _hasProxy ? _proxy : path;
  
  _ThemeProxy(String path) : super.async(new Future<js.Proxy>(() {
    final completer = new Completer<js.Proxy>();
    _context.ace.config.loadModule(js.array(['theme', path]), 
        new js.Callback.once((module) {
            completer.complete(js.retain(module));
        }));
    return completer.future;
  })), path = path;
}
