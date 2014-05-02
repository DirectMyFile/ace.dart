part of ace;

class Completion {
  /// The display string and default value for this completion.
  /// 
  /// If this completion's [snippet] is `null` this value will be inserted.
  final String value;
  
  /// An optional string to insert in the document for this completion.
  final String snippet;
  
  /// An optional score for this completion result; bigger is better.
  final int score;
  
  /// An optional string that is displayed during auto-completion if specified.
  final String meta;
  
  const Completion(this.value, {this.snippet, this.score, this.meta});
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
