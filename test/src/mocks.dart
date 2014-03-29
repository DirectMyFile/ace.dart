library ace.test.mocks;

import 'dart:js' as js;
import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';

class MockVirtualRenderer extends HasProxy with Mock<VirtualRenderer> 
    implements VirtualRenderer {
  
  final containerElement = new html.DivElement();
  
  MockVirtualRenderer() : super(new js.JsObject(js.context['Object'])) {
    jsProxy['getFirstVisibleRow'] = () => super.getters[#firstVisibleRow]();
    jsProxy['getLastVisibleRow'] = () => super.getters[#lastVisibleRow]();
    jsProxy['getContainerElement'] = () => containerElement;
    jsProxy['getTextAreaContainer'] = () => containerElement;
    
    // TODO: mock the rest of the VirtualRenderer interface    
  }
  
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  
  void _onDispose() {
    jsProxy.deleteProperty('getFirstVisibleRow');
    jsProxy.deleteProperty('getLastVisibleRow');
    jsProxy.deleteProperty('getContainerElement');
    jsProxy.deleteProperty('getTextAreaContainer');
  }
}
