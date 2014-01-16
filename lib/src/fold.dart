part of ace;

abstract class Fold extends RangeList {
  
  Placeholder get placeholder;
  
  Range get range; 
  
  factory Fold(Range range, Placeholder placeholder) => 
      implementation.createFold(range, placeholder);
}

class FoldChangeEvent {
  
  static const ADD    = 'add';
  static const REMOVE = 'remove';
  static const UPDATE = null;
  
  final String action;
  
  final Fold data;  
  
  FoldChangeEvent(this.data, this.action);
}
