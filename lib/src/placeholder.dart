part of ace;

abstract class Placeholder extends _Disposable {
  
  int get length;
  
  factory Placeholder(
      EditSession session, 
      int length, 
      Point position,
      Iterable<Point> others,
      String mainClass,
      String othersClass) {
    assert(session is _EditSessionProxy);
    return new _PlaceholderProxy(
      session, length, position, others, mainClass, othersClass);
  }
}
