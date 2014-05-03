part of ace.proxy;

class _ModeProxy extends HasProxy implements Mode {
  
  final String path;
  
  bool get isLoaded => _hasProxy;
    
  String get name => implementation.getExtension(path, separator: '/');
    
  Future get onLoad => _onHasProxy;
  
  get _mode => _hasProxy ? _proxy : path;

  _ModeProxy(String path) 
  : super.async(_loadModule('mode', path).then((module) => 
      new Future.value(new js.JsObject(module['Mode']))))
  , path = path;
  
  _ModeProxy._(js.JsObject proxy, this.path) 
  : super.async(new Future.sync(() => proxy));
}