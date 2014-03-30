part of ace.proxy;

class _PlaceholderProxy extends HasProxy implements Placeholder {
  
  int get length => _proxy['length'];
  
  _PlaceholderProxy(
      EditSession session, 
      int length, 
      Point position,
      Iterable<Point> others,
      String mainClass,
      String othersClass) 
  : this._(new js.JsObject(_modules['ace/placeholder']['PlaceHolder'], 
      [(session as _EditSessionProxy)._proxy, 
      length, 
      _jsPoint(position),
      _jsArray(others.map((Point p) => _jsPoint(p))),
      mainClass,
      othersClass]));
      
  _PlaceholderProxy._(proxy) : super(proxy);
}
