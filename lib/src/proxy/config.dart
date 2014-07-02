part of ace.proxy;

class _ConfigProxy extends HasProxy implements Config {
  
  _ConfigProxy(): super(_ace['config']);
  
  Future loadModule(String moduleType, String modulePath) {
    final completer = new Completer<js.JsObject>();
    call('loadModule', [_jsArray([moduleType, modulePath]), (module) {
      completer.complete(module);
    }]);
    return completer.future;
  }
  
  String moduleUrl(String modulePath, String moduleType) =>
      call('moduleUrl', [modulePath, moduleType]);
  
  String setModuleUrl(String modulePath, String moduleUrl) => 
      call('setModuleUrl', [modulePath, moduleUrl]);
}
