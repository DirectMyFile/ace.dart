part of ace;

/// The renderer draws to the screen.
class VirtualRenderer extends _HasProxy {
  
  /// The index of the first visible row.
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
  VirtualRenderer._(js.Proxy proxy) : super(proxy);
}
