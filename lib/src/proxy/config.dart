part of ace.proxy;

class _ConfigProxy extends HasProxy implements Config {
  
  _ConfigProxy(): super(_ace['config']);
  
  String moduleUrl(String modulePath, String moduleType) =>
      call('moduleUrl', [modulePath, moduleType]);
  
  String setModuleUrl(String modulePath, String moduleUrl) => 
      call('setModuleUrl', [modulePath, moduleUrl]);
}
