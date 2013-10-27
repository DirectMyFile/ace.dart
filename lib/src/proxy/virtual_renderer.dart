part of ace;

class _VirtualRendererProxy extends _HasProxy implements VirtualRenderer {
  
  int get firstVisibleRow => call('getFirstVisibleRow');
  
  bool
    get fixedWidthGutter => call('getOption', ['fixedWidthGutter']);
    set fixedWidthGutter(bool fixedWidthGutter) => 
        call('setOption', ['fixedWidthGutter', fixedWidthGutter]);
  
  _VirtualRendererProxy(html.Element container, Theme theme) 
  : this._(new js.JsObject(_modules['ace/virtual_renderer'][VirtualRenderer], 
      [container, (theme as _ThemeProxy)._theme]));
    
  _VirtualRendererProxy._(js.JsObject proxy) : super(proxy);
  
  void updateFull({bool force: false}) => call('updateFull', [force]);
}
