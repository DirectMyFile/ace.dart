part of ace;

/// Manages the undo stack for an [EditSession].
abstract class UndoManager extends Disposable {
  
  /// Returns `true` if there are [redo] operations left to perform.
  bool get hasRedo;
  
  /// Returns `true` if there are [undo] operations left to perform.
  bool get hasUndo;
  
  /// Called internally when the given [deltas] have been executed.
  /// 
  /// It is an error to call this method from outside this library.
  void onExecuted(List<UndoManagerDelta> deltas, bool merge);
  
  /// Performs a redo operation on the associated document, reapplying the last 
  /// change.
  /// 
  /// If [select] is _false_ then the range of the change will not be selected.  
  /// 
  /// Returns the range of the operation that is performed, or `null` if 
  /// [hasRedo] is _false_.
  Range redo({bool select: true});
  
  /// Destroys the stack of [undo] and [redo] operations.
  void reset();
  
  /// Performs an undo operation on the associated document, reverting the last 
  /// change.
  /// 
  /// If [select] is _false_ then the range of the change will not be selected.  
  /// 
  /// Returns the range of the operation that is performed, or `null` if 
  /// [hasUndo] is _false_.
  Range undo({bool select: true});
}

class UndoManagerDelta {

  final String group;
  
  final List<Delta> deltas;
  
  UndoManagerDelta(this.group, this.deltas);
}
