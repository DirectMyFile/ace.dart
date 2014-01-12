part of ace;

abstract class Folding {
  
  Fold addFold(Fold fold);
  
  List<Fold> getAllFolds();
  
  Fold getFoldAt(int row, int column, {int side});
  
  void removeFold(Fold fold);
}
