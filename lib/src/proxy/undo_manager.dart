part of ace;

class _UndoManagerProxy extends _HasProxy implements UndoManager {
  
  bool get hasRedo => _proxy.hasRedo();
  
  bool get hasUndo => _proxy.hasUndo();
  
  _UndoManagerProxy._(js.Proxy proxy) : super(proxy);
  
  Range redo(bool dontSelect) => new Range._(_proxy.redo(dontSelect));
  
  void reset() => _proxy.reset();
  
  Range undo(bool dontSelect) => new Range._(_proxy.undo(dontSelect));
}
