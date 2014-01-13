part of ace;

class Marker {
  
  static const FULL_LINE    = 'fullLine';
  static const LINE         = 'line';
  static const SCREEN_LINE  = 'screenLine';
  static const TEXT         = 'text';
  
  /// The CSS class for this marker.
  final String className;
  
  /// The unique id of this marker; may be `null`.
  ///
  /// Marker id's are assigned by an instance of [EditSession].
  final int id;
  
  /// Whether this marker is rendered in the front marker layer or the back
  /// marker layer.
  final bool inFront;
  
  final Range range;
  
  final String type;
  
  Marker._(
    this.range, 
    this.className, {
    this.id      : null,
    this.inFront : false,
    this.type    : LINE 
  });
  
  Marker._fromProxy(proxy) : this._(
    new Range._(proxy['range']),
    proxy['clazz'],
    id: proxy['id'],
    inFront: proxy['inFront'],
    type: proxy['type']
  );
  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Marker) return false; 
    final o = other;
    return className == o.className 
        && id == o.id
        && inFront == o.inFront
        && range == o.range 
        && type == o.type;
  }
  
  int get hashCode => className.hashCode ^ id.hashCode ^ inFront.hashCode 
      ^ range.hashCode ^ type.hashCode;
  
  js.JsObject _toProxy() => _jsMap({
    'clazz'   : className,
    'id'      : id,
    'inFront' : inFront,
    'range'   : range._toProxy(),
    'type'    : type });
}
