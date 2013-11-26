@TestGroup(description: 'VirtualRenderer')
library ace.test.virtual_renderer;

import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

VirtualRenderer renderer;
@Setup
setup() {  
  html.document.body.append(new html.Element.div()..id = 'editor');  
  renderer = new VirtualRenderer(
      html.querySelector('#editor'), 
      new Theme.named(Theme.MONOKAI));
}

@Teardown
void teardown() {
  html.document.body.children.remove(html.querySelector('#editor'));
}

@Test()
void testConstructor() {
  expect(renderer, isNotNull);
}

@Test()
void testFixedWidthGutter() {
  renderer.fixedWidthGutter = true;
  expect(renderer.fixedWidthGutter, isTrue);
  renderer.fixedWidthGutter = false;
  expect(renderer.fixedWidthGutter, isFalse);
}

@Test()
void testShowGutter() {
  var renderer = edit(html.querySelector('#editor')).renderer;
  renderer.showGutter = false;
  expect(renderer.showGutter, isFalse);
  renderer.showGutter = true;
  expect(renderer.showGutter, isTrue);
}
