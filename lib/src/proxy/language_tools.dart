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

    completer(_editor, _session, pos, prefix)
    .then((results) {
      callback.apply([null, _jsArray(results.map(_jsCompletion))]);
    }).catchError((e) {
      callback.apply([null, _jsArray([])]);
    });
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
