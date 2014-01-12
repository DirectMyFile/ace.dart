part of ace;

abstract class Fold extends RangeList {
  
  Placeholder get placeholder;
  
  Range get range; 
  
  factory Fold(Range range, Placeholder placeholder) {
    assert(placeholder is _PlaceholderProxy);
    return new _FoldProxy(range, placeholder);
  }
}

class FoldChangeEvent {
  
  static const ADD    = 'add';
  static const REMOVE = 'remove';
  static const UPDATE = null;
  
  final String action;
  
  final Fold data;  
  
  FoldChangeEvent._(this.data, this.action);
}
