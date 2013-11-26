part of ace;

/// The renderer draws to the screen.
abstract class VirtualRenderer extends _Disposable implements OptionsProvider {
  
  /// The index of the first visible row.
  int get firstVisibleRow;
  
  /// Whether or not the gutter has a fixed width.
  bool fixedWidthGutter;
  
  /// The column number of where the print margin is.
  int printMarginColumn;
  
  /// Whether or not the gutter is visible.
  bool showGutter;
  
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
