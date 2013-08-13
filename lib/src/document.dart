part of ace;

class Document extends _HasProxy {
  
  int get length => _proxy.getLength();
  
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);
  
  Document._(js.Proxy proxy) : super(proxy);
    
  String getLine(int row) => _proxy.getLine(row);
}
