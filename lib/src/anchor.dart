part of ace;

/// A floating [Point] in a [Document].
/// 
/// Whenever text is inserted or deleted before the [document]'s cursor, the 
/// [position] of the anchor is updated.
class Anchor extends _HasProxy {
  
  /// The document of this anchor.
  Document get document => new Document._(_proxy.getDocument());
  
  /// The current position of this anchor.
  Point get position => new Point._(_proxy.getPosition());
  
  /// Creates a new Anchor and associates it with the given [document] at the
  /// given [row] and [column] starting position.
  Anchor(Document document, int row, int column) 
    : super(new js.Proxy(_context.ace.define.modules['ace/anchor'].Anchor, 
        document._proxy, row, column));  
}
