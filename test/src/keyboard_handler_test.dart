@TestGroup(description: 'KeyboardHandler')
library ace.test.keyboard_handler;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

@Test()
void testEmacsHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.EMACS)
  ..onLoad.then(expectAsync1(noop1));
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/emacs');
}

@Test()
void testVimHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.VIM)
  ..onLoad.then(expectAsync1(noop1));
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/vim');
}
