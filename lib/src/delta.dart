part of ace;

/// A change in a [Document].
abstract class Delta {
  
  /// The action that triggered this change.
  final String action;
  
  /// The [Range] of this change within the document.
  final Range range;  
    
  Delta._(this.action, this.range);
}

class InsertLinesDelta extends Delta {  
  
  /// The lines inserted in the document by this change.
  final Iterable<String> lines;
  
  InsertLinesDelta(Range range, this.lines) : super._('insertLines', range);
}

class InsertTextDelta extends Delta {
    
  /// The text inserted in the document by this change.
  final String text;
  
  InsertTextDelta(Range range, this.text) : super._('insertText', range);
}

class RemoveLinesDelta extends Delta {
  
  /// The lines removed from the document by this change.
  final Iterable<String> lines;
  
  /// The value of the document's newline character during this change as 
  /// defined by [Document.newLineCharacter].
  final String nl;
  
  RemoveLinesDelta(Range range, this.lines, this.nl)
  : super._('removeLines', range);
}

class RemoveTextDelta extends Delta {
  
  /// The text removed from the document by this change.
  final String text;
  
  RemoveTextDelta(Range range, this.text) : super._('removeText', range);
}
