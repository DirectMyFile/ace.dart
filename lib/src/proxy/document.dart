part of ace;

class _DocumentProxy extends _HasProxy implements Document {
  
  js.Callback _jsOnChange;
  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;

  int get length => _proxy.getLength();
  
  String get newLineCharacter => _proxy.getNewLineCharacter();
  
  String 
    get newLineMode => _proxy.getNewLineMode();
    set newLineMode(String newLineMode) => _proxy.setNewLineMode(newLineMode);
    
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);

  _DocumentProxy([String text = '']) : this._(
      new js.Proxy(_context.ace.define.modules['ace/document'].Document, text));
    
  _DocumentProxy._(js.Proxy proxy) : super(proxy) {
    _jsOnChange = new js.Callback.many((e,__) => 
        _onChange.add(new Delta._forProxy(e.data)));
    _proxy.on('change', _jsOnChange);
  }
  
  void _onDispose() {
    _onChange.close();
    _jsOnChange.dispose();
  }
  
  void applyDeltas(List<Delta> deltas) =>
      _proxy.applyDeltas(js.array(deltas.map((delta) => delta._toProxy())));
  
  Anchor createAnchor(int row, int column) =>
      new _AnchorProxy._(_proxy.createAnchor(row, column));

  List<String> getAllLines() => _list(_proxy.getAllLines());
  
  List<String> getLines(int firstRow, int lastRow) => 
      _list(_proxy.getLines(firstRow, lastRow));
  
  String getLine(int row) => _proxy.getLine(row);
  
  String getTextRange(Range range) => _proxy.getTextRange(range._toProxy());
  
  Point insert(Point position, String text) =>
      new Point._(_proxy.insert(position._toProxy(), text));
  
  Point insertInLine(Point position, String text) =>
      new Point._(_proxy.insertInLine(position._toProxy(), text));
  
  Point insertLines(int row, List<String> lines) =>
      new Point._(_proxy.insertLines(row, js.array(lines)));
  
  Point insertNewLine(Point position) =>
      new Point._(_proxy.insertNewLine(position._toProxy()));
  
  bool isNewLine(String text) => _proxy.isNewLine(text);      
  
  int positionToIndex(Point position, {int startRow: 0}) =>
      _proxy.positionToIndex(position._toProxy(), startRow);
  
  Point remove(Range range) => new Point._(_proxy.remove(range._toProxy()));
  
  Point removeInLine(int row, int startColumn, int endColumn) =>
      new Point._(_proxy.removeInLine(row, startColumn, endColumn));
  
  List<String> removeLines(int startRow, int endRow) => 
      _list(_proxy.removeLines(startRow, endRow));
  
  void removeNewLine(int row) => _proxy.removeNewLine(row);
  
  Point replace(Range range, String text) => 
      new Point._(_proxy.replace(range._toProxy(), text));
  
  void revertDeltas(List<Delta> deltas) => 
      _proxy.revertDeltas(js.array(deltas.map((delta) => delta._toProxy())));
}
