part of ace.proxy;

class _AnchorProxy extends HasProxy implements Anchor {
  
  _Event<AnchorChangeEvent> _onChange;
  Stream<AnchorChangeEvent> get onChange {
    if (_onChange == null) {
      _onChange = new _Event<AnchorChangeEvent>(this, 'change', (e) =>
        new AnchorChangeEvent(_point(e['old']), _point(e['value'])));
    }
    return _onChange.stream;
  }
  
  Document get document => new _DocumentProxy._(call('getDocument'));
  
  Point get position => _point(call('getPosition'));
  
  _AnchorProxy(Document document, int row, int column) 
  : this._(new js.JsObject(_modules['ace/anchor']['Anchor'], 
      [(document as _DocumentProxy)._proxy, row, column]));
  
  _AnchorProxy._(proxy) : super(proxy);
  
  Future _onDispose() {
    call('detach');
    if (_onChange == null) return new Future.value();
    return _onChange.dispose();
  }
  
  void setPosition(int row, int column, {bool clip: true}) => 
      call('setPosition', [row, column, !clip]);      
}
