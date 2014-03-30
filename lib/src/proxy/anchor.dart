part of ace.proxy;

class _AnchorProxy extends HasProxy implements Anchor {
  
  final _onChange = new StreamController<AnchorChangeEvent>.broadcast();
  Stream<AnchorChangeEvent> get onChange => _onChange.stream;
  
  Document get document => new _DocumentProxy._(call('getDocument'));
  
  Point get position => _point(call('getPosition'));
  
  _AnchorProxy(Document document, int row, int column) 
  : this._(new js.JsObject(_modules['ace/anchor']['Anchor'], 
      [(document as _DocumentProxy)._proxy, row, column]));
  
  _AnchorProxy._(proxy) : super(proxy) {
    call('on', ['change', (e,__) => _onChange.add(
        new AnchorChangeEvent(_point(e['old']), _point(e['value'])))]);
  }
  
  void _onDispose() {
    _onChange.close();
    call('detach');
  }
  
  void setPosition(int row, int column, {bool clip: true}) => 
      call('setPosition', [row, column, !clip]);      
}
