part of ace.proxy;

class _ThemeProxy extends HasProxy implements Theme {
  
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
  
  String get name => implementation.getExtension(path, separator: '/');
  
  Future get onLoad => _onHasProxy;
  
  final String path;
  
  get _theme => _hasProxy ? _proxy : path;
  
  _ThemeProxy(String path) 
  : super.async(_loadModule('theme', path))
  , path = path;
}
