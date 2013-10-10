part of ace;

class _Anchor implements Anchor {
  
  int _row;
  int _column;
  StreamSubscription _documentChangeListener;
  
  final _onChange = new StreamController<AnchorChangeEvent>.broadcast();
  Stream<AnchorChangeEvent> get onChange => _onChange.stream;
  
  final Document document;
  
  Point get position => _clipPositionToDocument(_row, _column);
  
  _Anchor(this.document, int row, int column) {
    _attach();
    setPosition(row, column);
  }
 
  void _attach() {
    assert(_documentChangeListener == null);
    _documentChangeListener = document.onChange.listen(_onDocumentChange);
  }
  
  void _detach() {
    assert(_documentChangeListener != null);
    _documentChangeListener.cancel();
    _documentChangeListener = null;
  }
  
  void dispose() {
    _detach();
    _onChange.close();
  }
  
  Point _clipPositionToDocument(int row, int column) {
    var r;
    var c;
    if (row >= document.length) {
      r = math.max(0, document.length - 1);
      c = document.getLine(r).length;
    } else if (row < 0) {
      r = 0;
      c = 0;
    } else {
      r = row;
      c = math.min(document.getLine(r).length, math.max(0, column));
    }
    if (column < 0) {
      c = 0;
    }
    return new Point(r, c);
  }
  
  void _onDocumentChange(Delta e) => throw new UnimplementedError();
  
  void setPosition(int row, int column, {bool clip: true}) {
    var pos;
    if (!clip) {
      pos = new Point(row, column);
    } else {
      pos = _clipPositionToDocument(row, column);
    }
    if (_row == pos.row && _column == pos.column) return;
    final old = new Point(_row, _column);
    _row = pos.row;
    _column = pos.column;
    _onChange.add(new AnchorChangeEvent._(old, pos));
  }
}
