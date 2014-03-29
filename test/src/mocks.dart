library ace.test.mocks;

import 'dart:js' as js;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';

class MockVirtualRenderer extends HasProxy with Mock<VirtualRenderer> {
  
  MockVirtualRenderer() : super(new js.JsObject(js.context['Object'])) {
    jsProxy['getFirstVisibleRow'] = super.methods[#getFirstVisibleRow];
    jsProxy['getLastVisibleRow'] = super.methods[#getLastVisibleRow];    
    
    // TODO: mock the rest of the VirtualRenderer interface    
    
  }
  
  void _onDispose() {
    jsProxy.deleteProperty('getFirstVisibleRow');
    jsProxy.deleteProperty('getLastVisibleRow');
  }
}
