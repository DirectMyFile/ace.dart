part of ace;

class _AnchorProxy extends _HasProxy implements Anchor {
  
  js.Callback _jsOnChange;
  final _onChange = new StreamController<AnchorChangeEvent>.broadcast();
  Stream<AnchorChangeEvent> get onChange => _onChange.stream;
  
  Document get document => new _DocumentProxy._(_proxy.getDocument());
  
  Point get position => new Point._(_proxy.getPosition());
  
  _AnchorProxy(Document document, int row, int column) 
  : this._(
      new js.Proxy(_context.ace.define.modules['ace/anchor'].Anchor, 
          (document as _DocumentProxy)._proxy, row, column));
  
  _AnchorProxy._(proxy) : super(proxy) {
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
  
  void setPosition(int row, int column, {bool clip: true}) => 
      _proxy.setPosition(row, column, !clip);      
}
