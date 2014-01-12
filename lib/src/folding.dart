part of ace;

abstract class Folding {
  
  Fold addFold(Fold fold);
  Fold getFoldAt(int row, int column, {int side});
  List<Fold> getAllFolds();
  void removeFold(Fold fold);
}
