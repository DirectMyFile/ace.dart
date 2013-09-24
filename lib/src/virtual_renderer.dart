part of ace;

/// The renderer draws to the screen.
class VirtualRenderer extends _HasProxy {
  
  /// The index of the first visible row.
  int get firstVisibleRow => _proxy.getFirstVisibleRow();
  
  /// Whether or not the gutter has a fixed width.
  bool
    get fixedWidthGutter => _proxy.getOption('fixedWidthGutter');
    set fixedWidthGutter(bool fixedWidthGutter) => 
        _proxy.setOption('fixedWidthGutter', fixedWidthGutter);
  
  /// Creates a new VirtualRenderer within the given [container], applying the 
  /// given [theme].
  VirtualRenderer(html.Element container, Theme theme) : this._(
        new js.Proxy(
            _context.ace.define.modules['ace/virtual_renderer'].VirtualRenderer, 
            container, 
            theme._theme));
    
  VirtualRenderer._(js.Proxy proxy) : super(proxy);
  
  /// Updates all of the layers, for all the rows.
  /// 
  /// By default this schedules an asynchronous update.  If [force] is `true`
  /// then the update is performed immediately.
  void updateFull({bool force: false}) => _proxy.updateFull(force);
}
