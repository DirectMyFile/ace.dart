part of ace;

class _VirtualRendererProxy extends _HasProxy implements VirtualRenderer {
  
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
  bool
    get fixedWidthGutter => _proxy.getOption('fixedWidthGutter');
    set fixedWidthGutter(bool fixedWidthGutter) => 
        _proxy.setOption('fixedWidthGutter', fixedWidthGutter);
  
  _VirtualRendererProxy(html.Element container, Theme theme) 
  : this._(
        new js.Proxy(
            _context.ace.define.modules['ace/virtual_renderer'].VirtualRenderer, 
            container, 
            theme._theme));
    
  _VirtualRendererProxy._(js.Proxy proxy) : super(proxy);
  
  void updateFull({bool force: false}) => _proxy.updateFull(force);
}
