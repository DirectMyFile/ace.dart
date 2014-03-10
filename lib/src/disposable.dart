part of ace;

abstract class Disposable {
  /// Dispose of any resources held by this object.
  /// 
  /// This method will release any javascript proxy objects help by this 
  /// object.  It will also close any streams exposed by the object.  It is an
  /// error to call any methods or access any fields of this object after this
  /// method has been called.
  void dispose() {}
}
