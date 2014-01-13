part of ace;

class Marker {
  
  static const FULL_LINE    = 'fullLine';
  static const LINE         = 'line';
  static const SCREEN_LINE  = 'screenLine';
  static const TEXT         = 'text';
  
  /// The CSS class for this marker.
  final String className;
  
  /// The unique id of this marker or `null` if this marker was not created by
  /// an instance of [EditSession].
  final int id;
  
  /// Whether this marker is rendered in the front marker layer or the back
  /// marker layer.
  final bool inFront;
  
  /// The defined range of this marker or `null` if this is a dynamic marker. 
  final Range range;
  
  /// The type of this marker; defaults to [LINE].
  final String type;
  
  Marker._({
    this.range, 
    this.className,
    this.id      : null,
    this.inFront : false,
    this.type    : LINE 
  });
  
  Marker._fromProxy(proxy) : this._(
    range     : proxy['range'] == null ? null : new Range._(proxy['range']),
    className : proxy['clazz'],
    id        : proxy['id'],
    inFront   : proxy['inFront'],
    type      : proxy['type']
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
  
  int get hashCode => className.hashCode 
      ^ id.hashCode 
      ^ inFront.hashCode 
      ^ range.hashCode 
      ^ type.hashCode;
  
  js.JsObject _toProxy() => _jsMap({
    'clazz'   : className,
    'id'      : id,
    'inFront' : inFront,
    'range'   : range == null ? null : range._toProxy(),
    'type'    : type
  });
}
