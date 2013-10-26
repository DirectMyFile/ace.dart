part of ace;

/// A change in a [Document].
abstract class Delta {
  
  /// The action that triggered this change.
  final String action;
  
  /// The [Range] of this change within the document.
  final Range range;  
  
  factory Delta._forProxy(proxy) {
    switch(proxy['action']) {
      case 'insertLines': return new InsertLinesDelta._fromProxy(proxy);
      case 'insertText': return new InsertTextDelta._fromProxy(proxy);
      case 'removeLines': return new RemoveLinesDelta._fromProxy(proxy);
      case 'removeText': return new RemoveTextDelta._fromProxy(proxy);
      default: throw new UnsupportedError('Unknown action: ${proxy['action']}');
    }
  }
  
  Delta._(this.action, this.range);
  
  Delta._fromProxy(js.JsObject proxy) 
  : this._(proxy['action'], new Range._(proxy['range']));
  
  js.JsObject _toProxy() => 
      _jsify({'action': action, 'range': range._toProxy()});
}

class InsertLinesDelta extends Delta {  
  
  /// The lines inserted in the document by this change.
  final Iterable<String> lines;
  
  InsertLinesDelta._(Range range, this.lines)
    : super._('insertLines', range);
  
  InsertLinesDelta._fromProxy(proxy) 
  : super._fromProxy(proxy)
  , lines = _list(proxy['lines']);
  
  js.JsObject _toProxy() => super._toProxy()..['lines'] = _jsify(lines);
}

class InsertTextDelta extends Delta {
    
  /// The text inserted in the document by this change.
  final String text;
  
  InsertTextDelta._(Range range, this.text)
  : super._('insertText', range);
  
  InsertTextDelta._fromProxy(proxy)
  : super._fromProxy(proxy)
  , text = proxy['text'];
  
  js.JsObject _toProxy() => super._toProxy()..['text'] = text;
}

class RemoveLinesDelta extends Delta {
  
  /// The lines removed from the document by this change.
  final Iterable<String> lines;
  
  /// The value of the document's newline character during this change as 
  /// defined by [Document.newLineCharacter].
  final String nl;
  
  RemoveLinesDelta._(Range range, this.lines, this.nl)
    : super._('removeLines', range);
  
  RemoveLinesDelta._fromProxy(proxy) 
    : super._fromProxy(proxy)
    , lines = _list(proxy['lines'])
    , nl = proxy['nl'];
  
  js.JsObject _toProxy() => 
      super._toProxy()
      ..['lines'] = _jsify(lines)
      ..['nl'] = nl;
}

class RemoveTextDelta extends Delta {
  
  /// The text removed from the document by this change.
  final String text;
  
  RemoveTextDelta._(Range range, this.text)
    : super._('removeText', range);
  
  RemoveTextDelta._fromProxy(proxy)
    : super._fromProxy(proxy)
    , text = proxy['text'];
  
  js.JsObject _toProxy() => super._toProxy()..['text'] = text;
}
