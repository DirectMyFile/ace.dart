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
  factory Anchor(Document document, int row, int column) =>
      new _AnchorProxy(document, row, column);
  
  /// Sets the anchor [position] to the specified [row] and [column]. 
  /// If [noClip] is `true`, the position is not clipped.
  void setPosition(int row, int column, bool noClip);
}

/// Fired by an [Anchor] whenever its position changes.
class AnchorChangeEvent {
  
  /// The old position of the anchor.
  final Point oldPosition;  
  
  /// The new position of the anchor.
  final Point newPosition;  
  
  AnchorChangeEvent._(this.oldPosition, this.newPosition);
}
