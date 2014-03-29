library ace.test.mocks;

import 'dart:js' as js;
import 'package:ace/ace.dart';
import 'package:bench/bench.dart';

abstract class _MockProxy extends Disposable {
  
  js.JsObject _proxy;
  
  bool get _hasProxy => _proxy != null;
  
  _MockProxy([String ctorName = 'Object', List ctorArgs]) 
  : _proxy = new js.JsObject(js.context[ctorName], ctorArgs);
  
  void dispose() {
    if (_hasProxy) {
      _onDispose();
      _proxy = null;
    }
  }
  
  void _onDispose() {}
}

class MockVirtualRenderer extends _MockProxy with Mock<VirtualRenderer> {
  
  MockVirtualRenderer() {
    _proxy['getFirstVisibleRow'] = super.methods[#getFirstVisibleRow];
    _proxy['getLastVisibleRow'] = super.methods[#getLastVisibleRow];    
    // TODO: mock the rest of the VirtualRenderer interface    
  }
  
  void _onDispose() {
    _proxy.deleteProperty('getFirstVisibleRow');
    _proxy.deleteProperty('getLastVisibleRow');
  }
}
