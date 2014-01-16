part of ace.proxy;

class _UndoManagerProxy extends _HasProxy implements UndoManager {
  
  bool get hasRedo => call('hasRedo');
  
  bool get hasUndo => call('hasUndo');
  
  _UndoManagerProxy._(js.JsObject proxy) : super(proxy);
  
  void onExecuted(List<UndoManagerDelta> deltas, bool merge) => 
      throw new UnsupportedError('This method may only be called internally.');
  
  Range redo({bool select: true}) => _range(call('redo', [!select]));
  
  void reset() => call('reset');
  
  Range undo({bool select: true}) => _range(call('undo', [!select]));
}

/// A base class for implementing [UndoManager].
/// 
/// When setting [EditSession.undoManager] the argument _must_ be an object
/// derived from this class.
abstract class UndoManagerBase extends _HasReverseProxy implements UndoManager {
  
  EditSession _session;
  /// The [EditSession] whose undo stack this undo manager manages; may be 
  /// `null` until the first call to [UndoManager.onExecuted].
  EditSession get session => _session;
  
  UndoManagerBase() {
    _proxy['execute'] = new js.JsFunction.withThis((_, options) {
      if (_session == null) {
        _session = new _EditSessionProxy._(options['args'][1]);
      }   
      List<UndoManagerDelta> deltas =_list(options['args'][0]).map((proxy) => 
          _undoManagerDelta(proxy)).toList(growable: false);      
      bool merge = options['merge'];
      onExecuted(deltas, merge);
    });
    _proxy['hasRedo'] = new js.JsFunction.withThis((_) => hasRedo);
    _proxy['hasUndo'] = new js.JsFunction.withThis((_) => hasUndo);    
    _proxy['redo'] = new js.JsFunction.withThis((_,[bool dontSelect = false]) => 
        redo(select: !dontSelect));
    _proxy['reset'] = new js.JsFunction.withThis((_) => reset());
    _proxy['undo'] = new js.JsFunction.withThis((_,[bool dontSelect = false]) => 
        undo(select: !dontSelect)); 
  }
  
  void _onDispose() {
    _proxy.deleteProperty('execute');
    _proxy.deleteProperty('hasRedo');
    _proxy.deleteProperty('hasUndo');    
    _proxy.deleteProperty('redo');
    _proxy.deleteProperty('reset');
    _proxy.deleteProperty('undo');
  }
}
