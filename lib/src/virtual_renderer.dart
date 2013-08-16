part of ace;

class VirtualRenderer extends _HasProxy {
  
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
  VirtualRenderer._(js.Proxy proxy) : super(proxy);
}
