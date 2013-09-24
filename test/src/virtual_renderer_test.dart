@TestGroup('VirtualRenderer')
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
      html.query('#editor'), 
      new Theme.named(Theme.MONOKAI));
}

@Teardown
void teardown() {
  html.document.body.children.remove(html.query('#editor'));
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
