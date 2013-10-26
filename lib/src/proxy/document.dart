part of ace;

class _DocumentProxy extends _HasProxy implements Document {
  
  final _onChange = new StreamController<Delta>.broadcast();
  Stream<Delta> get onChange => _onChange.stream;

  int get length => call('getLength');
  
  String get newLineCharacter => call('getNewLineCharacter');
  
  String 
    get newLineMode => call('getNewLineMode');
    set newLineMode(String newLineMode) => 
        call('setNewLineMode', [newLineMode]);
    
  String
    get value => call('getValue');
    set value(String text) => call('setValue', [text]);

  _DocumentProxy([String text = '']) : this._(
      new js.JsObject(_modules['ace/document']['Document'], [text]));
    
  _DocumentProxy._(js.JsObject proxy) : super(proxy) {
    call('on', ['change', (e,__) => 
        _onChange.add(new Delta._forProxy(e['data']))]);
  }
  
  void _onDispose() {
    _onChange.close();
  }
  
  void applyDeltas(List<Delta> deltas) =>
      call('applyDeltas', [_jsify(deltas.map((delta) => delta._toProxy()))]);
  
  Anchor createAnchor(int row, int column) =>
      new _AnchorProxy._(call('createAnchor', [row, column]));

  List<String> getAllLines() => _list(call('getAllLines'));
  
  List<String> getLines(int firstRow, int lastRow) => 
      _list(call('getLines', [firstRow, lastRow]));
  
  String getLine(int row) => call('getLine', [row]);
  
  String getTextRange(Range range) => call('getTextRange', [range._toProxy()]);
  
  Point indexToPosition(int index, {int startRow: 0}) =>
      new Point._(call('indexToPosition', [index, startRow]));
  
  Point insert(Point position, String text) =>
      new Point._(call('insert', [position._toProxy(), text]));
  
  Point insertInLine(Point position, String text) =>
      new Point._(call('insertInLine', [position._toProxy(), text]));
  
  Point insertLines(int row, List<String> lines) =>
      new Point._(call('insertLines', [row, _jsify(lines)]));
  
  Point insertNewLine(Point position) =>
      new Point._(call('insertNewLine', [position._toProxy()]));
  
  bool isNewLine(String text) => call('isNewLine', [text]);      
  
  int positionToIndex(Point position, {int startRow: 0}) =>
      call('positionToIndex', [position._toProxy(), startRow]);
  
  Point remove(Range range) => new Point._(call('remove', [range._toProxy()]));
  
  Point removeInLine(int row, int startColumn, int endColumn) =>
      new Point._(call('removeInLine', [row, startColumn, endColumn]));
  
  List<String> removeLines(int startRow, int endRow) => 
      _list(call('removeLines', [startRow, endRow]));
  
  void removeNewLine(int row) => call('removeNewLine', [row]);
  
  Point replace(Range range, String text) => 
      new Point._(call('replace', [range._toProxy(), text]));
  
  void revertDeltas(List<Delta> deltas) => 
      call('revertDeltas', [_jsify(deltas.map((delta) => delta._toProxy()))]);
}
