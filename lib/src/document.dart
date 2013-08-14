part of ace;

/// Encapsulates the text of a document. 
/// 
/// At its core, a [Document] is just an array of strings where the index of the
/// array points to a row in the document.
/// 
/// An instance of [Document] may be attached to more than one [EditSession].
class Document extends _HasProxy {
  
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
  
  Document._(js.Proxy proxy) : super(proxy);
    
  /// Returns a verbatim copy of the given line [row] as it is in this document.
  String getLine(int row) => _proxy.getLine(row);
}
