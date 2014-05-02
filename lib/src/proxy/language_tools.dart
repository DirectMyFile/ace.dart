part of ace.proxy;

class _CodeCompleterReverseProxy extends _HasReverseProxy 
    implements CodeCompleter {
  
  final Function getCompletions;
  
  _CodeCompleterReverseProxy(this.getCompletions) {
    _proxy['getCompletions'] = (editor, session, pos, prefix, 
        js.JsFunction callback) {
      final _editor = editor == null ? null 
          : new _EditorProxy._(editor, listen: false);
      final _session = session == null ? null 
          : new _EditSessionProxy._(session, listen: false);        
      getCompletions(_editor, _session, pos, prefix)
      ..then((results) {
        callback.apply([null, _jsArray(results.map(_jsCompletion))]);
      })
      ..catchError((e) {
        // TODO: should we pass the error (string) as the first argument?
        callback.apply([null, _jsArray([])]);
      })
      ..whenComplete(() {
        if (_editor != null) {
          _editor.dispose();  
        }
        if (_session != null) {
          _session.dispose();
        }
      });
    };
  }
    
  void _onDispose() {
    _proxy.deleteProperty('getCompletions');
  }
}

class _LanguageToolsProxy extends HasProxy implements LanguageTools {
  
  _LanguageToolsProxy._(js.JsObject proxy) : super(proxy);
  
  void addCompleter(CodeCompleter completer) {
    assert(completer is _CodeCompleterReverseProxy);
    call('addCompleter', [(completer as _CodeCompleterReverseProxy)._proxy]);
  }
}
