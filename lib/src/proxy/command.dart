part of ace.proxy;

class _CommandProxy extends HasProxy implements Command {
  
  String get name => _proxy['name'];
  BindKey get bindKey => _bindKey(_proxy['bindKey']);
  Function get exec => _exec;
  bool get readOnly => _proxy['readOnly'];
  String get scrollIntoView => _proxy['scrollIntoView'];
  String get multiSelectAction => _proxy['multiSelectAction'];
  
  _CommandProxy._(proxy) : super(proxy);
    
  _exec(Editor editor) {
    assert(editor is _EditorProxy);    
    return _proxy['exec'].apply([(editor as _EditorProxy)._proxy]);    
  }
}

class _CommandReverseProxy extends HasProxy implements Command {
  
  final String name;
  final BindKey bindKey;
  final Function exec;
  final bool readOnly;
  final String scrollIntoView;
  final String multiSelectAction;
  
  _CommandReverseProxy(this.name, this.bindKey, this.exec, 
      {this.readOnly: false, this.scrollIntoView, this.multiSelectAction})
      : super(_jsObject()) {
    _proxy['name'] = name;
    _proxy['bindKey'] = _jsBindKey(bindKey);
    _proxy['exec'] = (editor, args) {
      final _editor = editor == null ? null 
          : new _EditorProxy._(editor, listen: false);
      final result = exec(_editor);
      if (_editor != null) {
        _editor.dispose();  
      }
      return result;
    };
    _proxy['readOnly'] = readOnly;
    if (scrollIntoView != null) {
      _proxy['scrollIntoView'] = scrollIntoView;
    }
    if (multiSelectAction != null) {
      _proxy['multiSelectAction'] = multiSelectAction;
    }
  }
  
  void _onDispose() {
    _proxy.deleteProperty('exec');
  }
}
