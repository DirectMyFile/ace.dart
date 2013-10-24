part of ace;

class _ThemeProxy extends _HasProxy implements Theme {
  
  String get cssClass {
    if (!isLoaded) throw new StateError('$path is not yet loaded.');
    return _proxy[cssClass];
  }
  
  String get cssText {
    if (!isLoaded) throw new StateError('$path is not yet loaded.');
    return _proxy[cssText];
  }
  
  bool get isDark {
    if (!isLoaded) throw new StateError('$path is not yet loaded.');
    return _proxy[isDark];
  }
  
  bool get isLoaded => _hasProxy;
  
  String get name => _ext(path, separator: '/');
  
  Future get onLoad => _onHasProxy;
  
  final String path;
  
  get _theme => _hasProxy ? _proxy : path;
  
  _ThemeProxy(String path) : super.async(new Future<js.JsObject>(() {
    final completer = new Completer<js.JsObject>();
    _context['ace']['config'].callMethod('loadModule', 
        [new js.JsObject.jsify(['theme', path]), 
        (module) => completer.complete(module)]);
    return completer.future;
  })), path = path;
}
