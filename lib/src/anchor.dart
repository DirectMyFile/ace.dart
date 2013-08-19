part of ace;

/// Fired by an [Anchor] whenever its position changes.
class AnchorChangeEvent {
  /// The old position of the anchor.
  final Point oldPosition;  
  /// The new position of the anchor.
  final Point newPosition;  
  AnchorChangeEvent._(this.oldPosition, this.newPosition);
}

/// A floating [Point] in a [Document].
/// 
/// Whenever text is inserted or deleted before the [document]'s cursor, the 
/// [position] of the anchor is updated.
class Anchor extends _HasProxy {
  js.Callback _jsOnChange;
  final _onChange = new StreamController<AnchorChangeEvent>.broadcast();
  
  /// Fired whenever the [position] changes.
  Stream<AnchorChangeEvent> get onChange => _onChange.stream;
  
  /// The document of this anchor.
  Document get document => new Document._(_proxy.getDocument());
  
  /// The current position of this anchor.
  Point get position => new Point._(_proxy.getPosition());
  
  /// Creates a new Anchor and associates it with the given [document] at the
  /// given [row] and [column] starting position.
  Anchor(Document document, int row, int column) 
    : super(new js.Proxy(_context.ace.define.modules['ace/anchor'].Anchor, 
        document._proxy, row, column)) {
    _jsOnChange = new js.Callback.many((e,__) =>
        _onChange.add(new AnchorChangeEvent._(
            new Point._(e.old), new Point._(e.value))));
    _proxy.on('change', _jsOnChange);
  }
  
  void _onDispose() {
    _onChange.close();
    _jsOnChange.dispose();
    _proxy.detach();
  }
  
  /// Sets the anchor [position] to the specified [row] and [column]. 
  /// If [noClip] is `true`, the position is not clipped.
  // TODO(rms): negative bool args like `noClip` make me sad but if we flip it
  // we could break people porting from ace.js in subtle ways... change anyways?
  void setPosition(int row, int column, bool noClip) => 
      _proxy.setPosition(row, column, noClip);      
}
