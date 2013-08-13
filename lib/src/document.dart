part of ace;

class Document {
  var _proxy;
  
  int get length => _proxy.getLength();
  
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);
  
  Document._(js.Proxy proxy) : _proxy = js.retain(proxy);
  
  void dispose() {
    assert(_proxy != null);
    js.release(_proxy);
    _proxy = null;
  }
  
  String getLine(int row) => _proxy.getLine(row);
}
