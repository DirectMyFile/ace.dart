part of ace;

class _UndoManagerProxy extends _HasProxy implements UndoManager {
  
  bool get hasRedo => call('hasRedo');
  
  bool get hasUndo => call('hasUndo');
  
  _UndoManagerProxy._(js.JsObject proxy) : super(proxy);
  
  Range redo({bool select: true}) => new Range._(call('redo', [!select]));
  
  void reset() => call('reset');
  
  Range undo({bool select: true}) => new Range._(call('undo', [!select]));
}
