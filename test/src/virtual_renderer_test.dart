library ace.test.virtual_renderer;

import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';

Editor editor;
VirtualRenderer renderer;

setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
  html.document.body.append(new html.Element.div()..id = 'editor');  
  editor = edit(html.querySelector('#editor'));
  renderer = editor.renderer;
}

void teardown() {
  html.document.body.children.remove(html.querySelector('#editor'));
}

void testConstructor() {
  expect(renderer, isNotNull);
}

void testGetContainerElement() {
  final container = html.querySelector('#editor');
  expect(container, isNotNull);
  expect(renderer.containerElement, same(container));  
}

void testFixedWidthGutter() {
  renderer.fixedWidthGutter = true;
  expect(renderer.fixedWidthGutter, isTrue);
  renderer.fixedWidthGutter = false;
  expect(renderer.fixedWidthGutter, isFalse);
}

void testGetMouseEventTarget() {
  expect(renderer.mouseEventTarget, const isInstanceOf<html.DivElement>());  
}

void testPrintMarginColumn() {
  renderer.printMarginColumn = 42;
  expect(renderer.printMarginColumn, equals(42));
}

void testShowGutter() {
  renderer.showGutter = false;
  expect(renderer.showGutter, isFalse);
  renderer.showGutter = true;
  expect(renderer.showGutter, isTrue);
}

void testGetOption() {
  renderer.fixedWidthGutter = true;
  expect(renderer.getOption('fixedWidthGutter'), isTrue);
}

void testGetOptions() {
  renderer.fixedWidthGutter = true;
  renderer.printMarginColumn = 57;
  var options = renderer.getOptions(['fixedWidthGutter', 'printMarginColumn']);
  expect(options.keys.length, equals(2));
  expect(options['fixedWidthGutter'], isTrue);
  expect(options['printMarginColumn'], equals(57));
}

void testSetOption() {
  renderer.setOption('printMarginColumn', 11);
  expect(renderer.printMarginColumn, equals(11));
}

void testSetOptions() {
  renderer.setOptions({ 'fixedWidthGutter' : true, 'printMarginColumn' : 76 });
  expect(renderer.fixedWidthGutter, isTrue);
  expect(renderer.printMarginColumn, equals(76));
}

void testTextToScreenCoordinates() {
  var screenCoords = renderer.textToScreenCoordinates(0, 0);
  expect(screenCoords.row, greaterThan(0));
  expect(screenCoords.column, greaterThan(0));
}

void testLineHeight() {
  expect(renderer.lineHeight, greaterThanOrEqualTo(editor.fontSize));
}
