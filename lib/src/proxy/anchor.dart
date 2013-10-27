part of ace;

class _AnchorProxy extends _HasProxy implements Anchor {
  
  final _onChange = new StreamController<AnchorChangeEvent>.broadcast();
  Stream<AnchorChangeEvent> get onChange => _onChange.stream;
  
  Document get document => new _DocumentProxy._(call('getDocument'));
  
  Point get position => new Point._(call('getPosition'));
  
  _AnchorProxy(Document document, int row, int column) 
  : this._(new js.JsObject(_modules['ace/anchor'][Anchor], 
      [(document as _DocumentProxy)._proxy, row, column]));
  
  _AnchorProxy._(proxy) : super(proxy) {
    call('on', ['change', (e,__) =>
        _onChange.add(new AnchorChangeEvent._(
            new Point._(e['old']), new Point._(e['value'])))]);
  }
  
  void _onDispose() {
    _onChange.close();
    call('detach');
  }
  
  void setPosition(int row, int column, {bool clip: true}) => 
      call('setPosition', [row, column, !clip]);      
}
