part of ace;

/// Encapsulates the text of a document. 
/// 
/// At its core, a [Document] is just an array of strings where the index of the
/// array points to a row in the document.
/// 
/// An instance of [Document] may be attached to more than one [EditSession].
class Document extends _HasProxy {
  js.Callback _jsOnChange;
  final _onChange = new StreamController<Delta>.broadcast();
  /// Fired whenever this document changes.
  Stream<Delta> get onChange => _onChange.stream;
  
  /// All lines in this document.
  Iterable<String> get allLines =>
      json.parse(_context.JSON.stringify(_proxy.getAllLines()));
  
  /// The number of rows in this document.
  int get length => _proxy.getLength();
  
  String get newLineCharacter => _proxy.getNewLineCharacter();
  String get newLineMode => _proxy.getNewLineMode();
  
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);
  
  Document._(js.Proxy proxy) : super(proxy) {
    _jsOnChange = new js.Callback.many((e,__) => 
        _onChange.add(new Delta._for(e.data)));
    _proxy.on('change', _jsOnChange);
  }
  
  void _onDispose() {
    _onChange.close();
    _jsOnChange.dispose();
  }
  
  /// Returns a verbatim copy of the given line [row] as it is in this document.
  String getLine(int row) => _proxy.getLine(row);
  
  /// Inserts a block of [text] at the given [position].
  void insert(Point position, String text) {
    _proxy.insert(position._toProxy(), text);
  }
}
