part of ace;

/// A change in a [Document].
class Delta {
  
  static const INSERT_LINES = 'insertLines';
  static const INSERT_TEXT  = 'insertText';
  static const REMOVE_LINES = 'removeLines';
  static const REMOVE_TEXT  = 'removeText';
  
  /// The action that triggered this change.
  final String action; 
    
  /// The lines inserted in or removed from the document by this change; may be 
  /// `null`.
  /// 
  /// This field is non-null if the [action] is either [INSERT_LINES] or 
  /// [REMOVE_LINES].
  final Iterable<String> lines;

  /// The value of the document's newline character during this change as 
  /// defined by [Document.newLineCharacter]; may be `null`.
  /// 
  /// This field is non-null if the [action] is [REMOVE_LINES] only.
  final String nl;
  
  /// The [Range] of this change within the document.
  final Range range;

  /// The text inserted in or removed from the document by this change; may be 
  /// `null`.
  /// 
  /// This field is non-null if the [action] is either [INSERT_TEXT] or 
  /// [REMOVE_TEXT].
  final String text;
  
  Delta(this.action, this.range, {this.lines, this.nl, this.text});
}
