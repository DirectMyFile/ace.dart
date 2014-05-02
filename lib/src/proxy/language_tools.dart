part of ace.proxy;

class _CodeCompleterReverseProxy extends _HasReverseProxy {
  final CodeCompleter completer;
  
  _CodeCompleterReverseProxy(this.completer) {
    _proxy['getCompletions'] = _getCompletions;
  }
  
  void _getCompletions(editor, session, pos, prefix, js.JsFunction callback) {
    print('completer called: ${prefix}');
    
    final _editor = new _EditorProxy._(editor, listen: false);
    final _session = new _EditSessionProxy._(session, listen: false);

    completer(_editor, _session, pos, prefix).then((results) {
      js.JsArray arr = new js.JsArray.from(results.map(_convertCompletion));
      callback.apply([null, arr]);
    }).catchError((e) {
      js.JsArray results = new js.JsArray.from([]);
      callback.apply([null, results]);
    });
  }
  
  js.JsObject _convertCompletion(Completion completion) {
    js.JsObject obj = new js.JsObject(js.context['Object']);
    obj['name'] = completion.name;
    obj['value'] = completion.value;
    obj['score'] = completion.score;
    if (completion.meta != null) obj['meta'] = completion.meta;
    return proxy;
  }
}

class _LanguageToolsProxy extends HasProxy implements LanguageTools {
  
  _LanguageToolsProxy._(js.JsObject proxy) : super(proxy);
  
  void addCompleter(CodeCompleter completer) {
    // TODO: this is problematic as the user has no chance to dispose of the
    // reverseProxy, we should refactor to have the user provide us with the
    // proxy object as with the commands
    var reverseProxy = new _CodeCompleterReverseProxy(completer);
    call('addCompleter', [reverseProxy._proxy]);
  }
}
