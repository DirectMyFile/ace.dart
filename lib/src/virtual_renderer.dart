part of ace;

/// The renderer draws to the screen.
abstract class VirtualRenderer extends Disposable implements OptionsProvider {
  
  /// The root element containing this renderer.
  get containerElement;
  
  /// The index of the first visible row.
  int get firstVisibleRow;
  
  /// The index of the last visible row.
  int get lastVisibleRow;
  
  /// The current line height.
  int get lineHeight;
  
  /// Whether or not the gutter has a fixed width.
  bool fixedWidthGutter;
  
  /// The element that the mouse events handlers are attached to.
  get mouseEventTarget;
  
  /// The column number of where the print margin is.
  int printMarginColumn;
  
  /// Whether or not the gutter is visible.
  bool showGutter;
  
  /// Creates a new VirtualRenderer within the given [container], applying the 
  /// given [theme].
  factory VirtualRenderer(container, Theme theme) => 
      implementation.createVirtualRenderer(container, theme);
  
  /// Returns a point containing the `pageX` and `pageY` coordinates for the
  /// given document [row] and [column].
  Point textToScreenCoordinates(int row, int column);
  
  /// Updates all of the layers, for all the rows.
  /// 
  /// By default this schedules an asynchronous update.  If [force] is `true`
  /// then the update is performed immediately.
  void updateFull({bool force: false});
}
