part of ace;

abstract class Placeholder extends Disposable {
  
  int get length;
  
  factory Placeholder(
      EditSession session, 
      int length, 
      Point position,
      Iterable<Point> others,
      String mainClass,
      String othersClass) => implementation.createPlaceholder(
          session, length, position, others, mainClass, othersClass);
}
