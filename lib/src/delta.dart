part of ace;

abstract class Delta {
  final String action;
  final Range range;
  
  factory Delta._for(js.Proxy data) {
    switch(data.action) {
      case 'insertLines': return new InsertLinesDelta._(data);
      case 'insertText': return new InsertTextDelta._(data);
      case 'removeLines': return new RemoveLinesDelta._(data);
      case 'removeText': return new RemoveTextDelta._(data);
      default: throw new UnsupportedError('Unknown action: ${data.action}');
    }
  }
  
  Delta._(this.action, js.Proxy r): range = new Range._fromProxy(r);
}

class InsertLinesDelta extends Delta {  
  //final Iterable<String> lines;
  InsertLinesDelta._(js.Proxy data) 
    : super._(data.action, data.range);
    //, lines = data.lines
}

class InsertTextDelta extends Delta {
  final String text;  
  InsertTextDelta._(js.Proxy data) 
    : super._(data.action, data.range)
    , text = data.text;
}

class RemoveLinesDelta extends Delta {  
  //final Iterable<String> lines;
  final String nl;
  RemoveLinesDelta._(js.Proxy data) 
    : super._(data.action, data.range)
    //, lines = data.lines
    , nl = data.nl;
}

class RemoveTextDelta extends Delta {
  final String text;  
  RemoveTextDelta._(js.Proxy data) 
    : super._(data.action, data.range)
    , text = data.text;
}
