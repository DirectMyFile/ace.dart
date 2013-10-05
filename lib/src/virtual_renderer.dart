part of ace;

/// The renderer draws to the screen.
abstract class VirtualRenderer extends _Disposable {
  
  /// The index of the first visible row.
  int get firstVisibleRow;
  
  /// Whether or not the gutter has a fixed width.
  bool fixedWidthGutter;
  
  /// Creates a new VirtualRenderer within the given [container], applying the 
  /// given [theme].
  factory VirtualRenderer(html.Element container, Theme theme) =>
      new _VirtualRendererProxy(container, theme);
  
  /// Updates all of the layers, for all the rows.
  /// 
  /// By default this schedules an asynchronous update.  If [force] is `true`
  /// then the update is performed immediately.
  void updateFull({bool force: false});
}
