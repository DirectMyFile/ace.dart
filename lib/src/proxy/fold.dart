part of ace;

class _FoldProxy extends _RangeListProxy implements Fold {
  
  Placeholder get placeholder => new _PlaceholderProxy._(_proxy['placeholder']);
  
  Range get range => new Range._(_proxy['range']);
  
  _FoldProxy(Range range, Placeholder placeholder)
  : this._(new js.JsObject(_modules['ace/edit_session/fold']['Fold'],
      [range._toProxy(), (placeholder as _PlaceholderProxy)._proxy]));
  
  _FoldProxy._(proxy) : super._(proxy);
}
