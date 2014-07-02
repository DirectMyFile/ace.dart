part of ace;

abstract class Config extends Disposable {
  
  /// Loads the module for the given [moduleType] and [modulePath].
  Future loadModule(String moduleType, String modulePath);
  
  /// Returns the module url for the given [modulePath] and [moduleType].
  String moduleUrl(String modulePath, String moduleType);
  
  /// Sets the module url for the given [modulePath] to the given [moduleUrl]
  /// and returns the [moduleUrl].
  String setModuleUrl(String modulePath, String moduleUrl);  
}
