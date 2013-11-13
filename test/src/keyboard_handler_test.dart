@TestGroup(description: 'KeyboardHandler')
library ace.test.point;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

@Test()
void testEmacsHandler() {
  final handler = new KeyboardHandler(KeyboardHandler.EMACS);
  expect(handler, isNotNull);
  expect(handler.id, 'ace/keyboard/emacs');
}

@Test()
void testVimHandler() {
  final handler = new KeyboardHandler(KeyboardHandler.VIM);
  expect(handler, isNotNull);
  expect(handler.id, 'ace/keyboard/vim');
}
