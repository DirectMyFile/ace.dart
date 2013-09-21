part of ace;

/// The renderer draws to the screen.
class VirtualRenderer extends _HasProxy {
  
  /// The index of the first visible row.
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
  VirtualRenderer._(js.Proxy proxy) : super(proxy);
  
  /// Updates all of the layers, for all the rows.
  /// 
  /// By default this schedules an asynchronous update.  If [force] is `true`
  /// then the update is performed immediately.
  void updateFull({bool force: false}) => _proxy.updateFull(force);
}
