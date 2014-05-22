part of ace.proxy;

class _AutoCompleterReverseProxy extends HasProxy implements AutoCompleter {
  
  final Function getCompletions;
  
  _AutoCompleterReverseProxy(this.getCompletions) : super(_jsObject()) {
    _proxy['getCompletions'] = (editor, session, pos, prefix, 
        js.JsFunction callback) {
      final _editor = editor == null ? null : new _EditorProxy._(editor);
      final _session = session == null ? null 
          : new _EditSessionProxy._(session);        
      getCompletions(_editor, _session, _point(pos), prefix)
      .then((List<Completion> results) {
        callback.apply([null, _jsArray(results.map(_jsCompletion))]);
      })
      .catchError((e) {
        // TODO: should we pass the error (string) as the first argument?
        callback.apply([null, _jsArray([])]);
      })
      .whenComplete(() {
        if (_editor != null) {
          _editor.dispose();  
        }
        if (_session != null) {
          _session.dispose();
        }
      });
    };
  }
    
  Future _onDispose() {
    _proxy.deleteProperty('getCompletions');
    return new Future.value();
  }
}

class _LanguageToolsProxy extends HasProxy implements LanguageTools {
  
  _LanguageToolsProxy._(js.JsObject proxy) : super(proxy);
  
  void addCompleter(AutoCompleter completer) {
    assert(completer is _AutoCompleterReverseProxy);
    call('addCompleter', [(completer as _AutoCompleterReverseProxy)._proxy]);
  }
}
