part of ace;

class Completion {
  final String name;
  final String value;
  final int score;
  final String meta;
  Completion(this.name, this.value, this.score, {this.meta});
}

abstract class AutoCompleter extends Disposable {
  
  Function get getCompletions;
  
  factory AutoCompleter(Future<List<Completion>> getCompletions(
      Editor editor, EditSession session, Point position, String prefix)) {
    return implementation.createAutoCompleter(getCompletions);
  }
}

/// An extension that provides auto-completion customization.
/// 
/// This extension can be loaded using the [require] function:
///     
///     ace.LanguageTools langTools = ace.require('ace/ext/language_tools'); 
abstract class LanguageTools extends Disposable {
  
  /// Add a new auto-completion provider.
  void addCompleter(AutoCompleter completer);
}
