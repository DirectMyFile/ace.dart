@TestGroup(description: 'KeyboardHandler')
library ace.test.keyboard_handler;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

final _noop = (_){};

@Test()
void testEmacsHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.EMACS)
  ..onLoad.then(expectAsync1(_noop));
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/emacs');
}

@Test()
void testVimHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.VIM)
  ..onLoad.then(expectAsync1(_noop));
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/vim');
}
