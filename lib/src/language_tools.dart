part of ace;

class Completion {
  final String name;
  final String value;
  final int score;
  final String meta;
  Completion(this.name, this.value, this.score, {this.meta});
}

abstract class CodeCompleter extends Disposable {
  
  Function get getCompletions;
  
  factory CodeCompleter(Future<List<Completion>> getCompletions(
      Editor editor, EditSession session, int position, String prefix)) {
    return implementation.createCodeCompleter(getCompletions);
  }
}

abstract class LanguageTools extends Disposable {
  
  /// Add a new code completion provider.
  void addCompleter(CodeCompleter completer);
}
