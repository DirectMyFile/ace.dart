part of ace;

abstract class Delta {
  final String action;
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
  Delta._(this.action, js.Proxy r): range = new Range._fromProxy(r);
  js.Proxy _toProxy() => js.map({'action': action, 'range': range._toProxy()});
}

class InsertLinesDelta extends Delta {  
  final Iterable<String> lines;
  InsertLinesDelta._(data) 
    : super._(data.action, data.range)
    , lines = json.parse(_context.JSON.stringify(data.lines));
  js.Proxy _toProxy() => super._toProxy()..['lines'] = js.array(lines);
}

class InsertTextDelta extends Delta {
  final String text;  
  InsertTextDelta._(data) 
    : super._(data.action, data.range)
    , text = data.text;
  js.Proxy _toProxy() => super._toProxy()..['text'] = text;
}

class RemoveLinesDelta extends Delta {  
  final Iterable<String> lines;
  final String nl;
  RemoveLinesDelta._(data) 
    : super._(data.action, data.range)
    , lines = json.parse(_context.JSON.stringify(data.lines))
    , nl = data.nl;
  js.Proxy _toProxy() => 
      super._toProxy()..['lines'] = js.array(lines)..['nl'] = nl;
}

class RemoveTextDelta extends Delta {
  final String text;  
  RemoveTextDelta._(data) 
    : super._(data.action, data.range)
    , text = data.text;
  js.Proxy _toProxy() => super._toProxy()..['text'] = text;
}
