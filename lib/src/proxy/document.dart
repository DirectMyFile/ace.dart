part of ace.proxy;

class _DocumentProxy extends HasProxy implements Document {
  
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
    call('on', ['change', (e,__) => _onChange.add(_delta(e['data']))]);
  }
  
  void _onDispose() {
    _onChange.close();
  }
  
  void applyDeltas(List<Delta> deltas) =>
      call('applyDeltas', [_jsArray(deltas.map(_jsDelta))]);
  
  Anchor createAnchor(int row, int column) =>
      new _AnchorProxy._(call('createAnchor', [row, column]));

  List<String> getAllLines() => _list(call('getAllLines'));
  
  List<String> getLines(int firstRow, int lastRow) => 
      _list(call('getLines', [firstRow, lastRow]));
  
  String getLine(int row) => call('getLine', [row]);
  
  String getTextRange(Range range) => call('getTextRange', [_jsRange(range)]);
  
  Point indexToPosition(int index, {int startRow: 0}) =>
      _point(call('indexToPosition', [index, startRow]));
  
  Point insert(Point position, String text) =>
      _point(call('insert', [_jsPoint(position), text]));
  
  Point insertInLine(Point position, String text) =>
      _point(call('insertInLine', [_jsPoint(position), text]));
  
  Point insertLines(int row, List<String> lines) =>
      _point(call('insertLines', [row, _jsArray(lines)]));
  
  Point insertNewLine(Point position) =>
      _point(call('insertNewLine', [_jsPoint(position)]));
  
  bool isNewLine(String text) => call('isNewLine', [text]);      
  
  int positionToIndex(Point position, {int startRow: 0}) =>
      call('positionToIndex', [_jsPoint(position), startRow]);
  
  Point remove(Range range) => _point(call('remove', [_jsRange(range)]));
  
  Point removeInLine(int row, int startColumn, int endColumn) =>
      _point(call('removeInLine', [row, startColumn, endColumn]));
  
  List<String> removeLines(int startRow, int endRow) => 
      _list(call('removeLines', [startRow, endRow]));
  
  void removeNewLine(int row) => call('removeNewLine', [row]);
  
  Point replace(Range range, String text) => 
      _point(call('replace', [_jsRange(range), text]));
  
  void revertDeltas(List<Delta> deltas) => call('revertDeltas', 
      [_jsArray(deltas.map(_jsDelta))]);
}
