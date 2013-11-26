part of ace;

class _VirtualRendererProxy extends _HasProxy implements VirtualRenderer {
  
  int get firstVisibleRow => call('getFirstVisibleRow');
  
  bool
    get fixedWidthGutter => call('getOption', ['fixedWidthGutter']);
    set fixedWidthGutter(bool fixedWidthGutter) => 
        call('setOption', ['fixedWidthGutter', fixedWidthGutter]);
  
  int
    get printMarginColumn => call('getPrintMarginColumn');
    set printMarginColumn(int printMarginColumn) => 
        call('setPrintMarginColumn', [printMarginColumn]);
    
  bool
    get showGutter => call('getShowGutter');
    set showGutter(bool value) => call('setShowGutter', [value]);
    
  _VirtualRendererProxy(html.Element container, Theme theme) 
  : this._(new js.JsObject(_modules['ace/virtual_renderer'][VirtualRenderer], 
      [container, (theme as _ThemeProxy)._theme]));
    
  _VirtualRendererProxy._(js.JsObject proxy) : super(proxy);
  
  getOption(String name) => call('getOption', [name]);
  
  Map<String, dynamic> getOptions(List<String> optionNames) =>
      _map(call('getOptions', [_jsify(optionNames)]));
  
  void setOption(String name, value) => call('setOption', [name, value]);
  
  void setOptions(Map<String, dynamic> options) => 
      call('setOptions', [_jsify(options)]);
  
  void updateFull({bool force: false}) => call('updateFull', [force]);
}
