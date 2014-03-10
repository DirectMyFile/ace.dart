part of ace.proxy;

class _CommandReverseProxy extends _HasReverseProxy 
    implements Command {
  
  final String name;
  final BindKey bindKey;
  final Function exec;
  final bool readOnly;
  final String scrollIntoView;
  final String multiSelectAction;
  
  _CommandReverseProxy(this.name, this.bindKey, this.exec, 
      {this.readOnly: false, this.scrollIntoView, this.multiSelectAction}) {
    _proxy['name'] = name;
    _proxy['bindKey'] = _jsBindKey(bindKey);
    _proxy['exec'] = new js.JsFunction.withThis((_, editor) {
      final _editor = new _EditorProxy._(editor, listen: false);
      final result = exec(_editor);
      _editor.dispose();
      return result;
    });
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
