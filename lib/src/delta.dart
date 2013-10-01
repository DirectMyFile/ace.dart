part of ace;

/// A change in a [Document].
abstract class Delta {
  
  /// The action that triggered this change.
  final String action;
  
  /// The [Range] of this change within the document.
  final Range range;  
  
  factory Delta._for(data) {
    switch(data.action) {
      case 'insertLines': return new InsertLinesDelta._(data);
      case 'insertText': return new InsertTextDelta._(data);
      case 'removeLines': return new RemoveLinesDelta._(data);
      case 'removeText': return new RemoveTextDelta._(data);
      default: throw new UnsupportedError('Unknown action: ${data.action}');
    }
  }
  
  Delta._(this.action, js.Proxy r): range = new Range._(r);
  
  js.Proxy _toProxy() => js.map({'action': action, 'range': range._toProxy()});
}

class InsertLinesDelta extends Delta {  
  
  /// The lines inserted in the document by this change.
  final Iterable<String> lines;
  
  InsertLinesDelta._(data) 
    : super._(data.action, data.range)
    , lines = _list(data.lines);
  
  js.Proxy _toProxy() => super._toProxy()..['lines'] = js.array(lines);
}

class InsertTextDelta extends Delta {
  
  /// The text inserted in the document by this change.
  final String text;
  
  InsertTextDelta._(data) 
    : super._(data.action, data.range)
    , text = data.text;
  
  js.Proxy _toProxy() => super._toProxy()..['text'] = text;
}

class RemoveLinesDelta extends Delta {
  
  /// The lines removed from the document by this change.
  final Iterable<String> lines;
  
  /// The value of the document's newline character during this change as 
  /// defined by [Document.newLineCharacter].
  final String nl;
  
  RemoveLinesDelta._(data) 
    : super._(data.action, data.range)
    , lines = _list(data.lines)
    , nl = data.nl;
  
  js.Proxy _toProxy() => 
      super._toProxy()..['lines'] = js.array(lines)..['nl'] = nl;
}

class RemoveTextDelta extends Delta {
  
  /// The text removed from the document by this change.
  final String text;
  
  RemoveTextDelta._(data) 
    : super._(data.action, data.range)
    , text = data.text;
  
  js.Proxy _toProxy() => super._toProxy()..['text'] = text;
}
