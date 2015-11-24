library ace.test.mocks;

import 'dart:js' as js;
import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';

typedef dynamic MockGetter();
typedef dynamic MockMethod(List positionalArgs, Map<Symbol, dynamic> namedArgs);
typedef dynamic MockSetter(dynamic);

@proxy
class Mock<T> {
  
  final List<Invocation> _calls = new List<Invocation>();
  final Map<Symbol, MockGetter> getters = new Map<Symbol, MockGetter>();
  final Map<Symbol, MockSetter> setters = new Map<Symbol, MockSetter>();
  final Map<Symbol, MockMethod> methods = new Map<Symbol, MockMethod>();
    
  Iterable<Invocation> calls(Symbol memberName) => 
      _calls.where((invocation) => invocation.memberName == memberName);
  
  void clearCalls() => _calls.clear();
    
  noSuchMethod(Invocation invocation) {
    _calls.add(invocation);    
    if (invocation.isGetter) {
      if (getters.containsKey(invocation.memberName)) {
        return getters[invocation.memberName]();
      }
    } else if (invocation.isSetter) {
      if (setters.containsKey(invocation.memberName)) {
        return setters[invocation.memberName]
            (invocation.positionalArguments[0]);
      }
    } else if (invocation.isMethod) {
      if (methods.containsKey(invocation.memberName)) {
        return methods[invocation.memberName]
            (invocation.positionalArguments, invocation.namedArguments);
      }
    } 
  }
}

@proxy
class MockVirtualRenderer extends HasProxy with Mock<VirtualRenderer> 
    implements VirtualRenderer {
  
  final containerElement = new html.Element.div();
  var _session;
  
  MockVirtualRenderer() : super(new js.JsObject(js.context['Object'])) {
    jsProxy[r'$gutter'] = {};
    jsProxy['adjustWrapLimit'] = () => adjustWrapLimit();
    jsProxy['container'] = containerElement;
    jsProxy['getContainerElement'] = () => containerElement;
    jsProxy['getFirstVisibleRow'] = () => firstVisibleRow;
    jsProxy['getLastVisibleRow'] = () => lastVisibleRow;    
    jsProxy['getMouseEventTarget'] = () => containerElement;
    jsProxy['getSession'] = () => _session;
    jsProxy['getTextAreaContainer'] = () => containerElement;
    jsProxy['on'] = () => on();
    jsProxy['onChangeTabSize'] = (startRow, endRow) => 
        onChangeTabSize(startRow, endRow);
    jsProxy['onResize'] = () => onResize();    
    jsProxy['scrollCursorIntoView'] = () => scrollCursorIntoView();
    jsProxy['scroller'] = containerElement;    
    jsProxy['scrollToX'] = (scrollLeft) => scrollToX(scrollLeft);
    jsProxy['scrollToY'] = (scrollTop) => scrollToY(scrollTop);
    jsProxy['setAnnotations'] = (annotations) => setAnnotations(annotations);
    jsProxy['setSession'] = (s) {
      _session = s;
    };    
    jsProxy['setStyle'] = (style) => setStyle(style);
    jsProxy['showCursor'] = () => showCursor();
    jsProxy['updateBackMarkers'] = () => updateBackMarkers();
    jsProxy['updateBreakpoints'] = () => updateBreakpoints();
    jsProxy['updateCursor'] = () => updateCursor();
    jsProxy['updateFrontMarkers'] = () => updateFrontMarkers();    
    jsProxy['updateFull'] = () => updateFull();
    jsProxy['updateLines'] = (startRow, endRow) => 
            updateLines(startRow, endRow);
    jsProxy['updateText'] = () => updateText();     
  }
  
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  
  void _onDispose() {
    jsProxy.deleteProperty(r'$gutter');
    jsProxy.deleteProperty('adjustWrapLimit');
    jsProxy.deleteProperty('container');
    jsProxy.deleteProperty('getContainerElement');
    jsProxy.deleteProperty('getFirstVisibleRow');
    jsProxy.deleteProperty('getLastVisibleRow');    
    jsProxy.deleteProperty('getMouseEventTarget');
    jsProxy.deleteProperty('getSession');
    jsProxy.deleteProperty('getTextAreaContainer');
    jsProxy.deleteProperty('on');
    jsProxy.deleteProperty('onChangeTabSize');
    jsProxy.deleteProperty('onResize');
    jsProxy.deleteProperty('scrollCursorIntoView');
    jsProxy.deleteProperty('scroller');
    jsProxy.deleteProperty('scrollToX');
    jsProxy.deleteProperty('scrollToY');
    jsProxy.deleteProperty('setAnnotations');
    jsProxy.deleteProperty('setSession');
    jsProxy.deleteProperty('setStyle');
    jsProxy.deleteProperty('showCursor');
    jsProxy.deleteProperty('updateBackMarkers');
    jsProxy.deleteProperty('updateBreakpoints');
    jsProxy.deleteProperty('updateCursor');
    jsProxy.deleteProperty('updateFrontMarkers');
    jsProxy.deleteProperty('updateFull');
    jsProxy.deleteProperty('updateLines');
    jsProxy.deleteProperty('updateText');
  }
}
