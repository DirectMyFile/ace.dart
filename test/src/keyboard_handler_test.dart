@TestGroup(description: 'KeyboardHandler')
library ace.test.keyboard_handler;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

@Setup
setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
}

@Test()
void testEmacsHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.EMACS);
  expectThen(handler.onLoad);
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/emacs');
  expect(handler.name, equals(KeyboardHandler.EMACS));
}

@Test()
void testVimHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.VIM);
  expectThen(handler.onLoad);
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/vim');
  expect(handler.name, equals(KeyboardHandler.VIM));
}
