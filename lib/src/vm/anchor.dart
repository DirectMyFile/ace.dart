part of ace;

class _Anchor implements Anchor {

  Stream<AnchorChangeEvent> get onChange => throw new UnimplementedError();
  
  final Document document;
  
  Point get position => throw new UnimplementedError();
  
  _Anchor(this.document, int row, int column);
  
  void dispose() => throw new UnimplementedError();
  
  Point _clipPositionToDocument(int row, int column) {
    var _row;
    var _column;
    if (row >= document.length) {
      _row = math.max(0, document.length - 1);
      _column = document.getLine(_row).length;
    } else if (row < 0) {
      _row = 0;
      _column = 0;
    } else {
      _row = row;
      _column = math.min(document.getLine(_row).length, math.max(0, column));
    }
    if (column < 0) {
      _column = 0;
    }
    return new Point(_row, _column);
  }
  
  void setPosition(int row, int column, bool noClip) => 
      throw new UnimplementedError();  
}
