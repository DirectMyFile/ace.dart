part of ace;

/// A floating [Point] in a [Document].
/// 
/// Whenever text is inserted or deleted before the [document]'s cursor, the 
/// [position] of the anchor is updated.
abstract class Anchor extends _Disposable {

  /// Fired whenever the [position] changes.
  Stream<AnchorChangeEvent> get onChange;
  
  /// The document of this anchor.
  Document get document;
  
  /// The current position of this anchor.
  Point get position;
  
  /// Creates a new Anchor and associates it with the given [document] at the
  /// given [row] and [column] starting position.
  /// 
  /// **WARNING** do not set [useExperimental] to `true` in production code; 
  /// this is an experimental flag to enable continuous integration testing of a 
  /// work-in-progress pure Dart implementation, and may be removed at any time.
  factory Anchor(Document document, int row, int column, 
                {bool useExperimental: false}) {
    if (useExperimental) {
      return new _Anchor(document, row, column);
    } else {
      return new _AnchorProxy(document, row, column);
    }
  }
  
  /// Sets the anchor [position] to the specified [row] and [column]. 
  /// 
  /// By default, the position will be clipped to the bounds of the [document].
  /// If [clip] is given as `false`, the position will not be clipped.
  void setPosition(int row, int column, {bool clip: true});
}

/// Fired by an [Anchor] whenever its position changes.
class AnchorChangeEvent {
  
  /// The old position of the anchor.
  final Point oldPosition;  
  
  /// The new position of the anchor.
  final Point newPosition;  
  
  AnchorChangeEvent._(this.oldPosition, this.newPosition);
}
