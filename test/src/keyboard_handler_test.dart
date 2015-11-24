library ace.test.keyboard_handler;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';

setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
}

void testEmacsHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.EMACS);
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/emacs');
  expect(handler.name, equals(KeyboardHandler.EMACS));
}

void testVimHandler() {
  final handler = new KeyboardHandler.named(KeyboardHandler.VIM);
  expect(handler, isNotNull);
  expect(handler.path, 'ace/keyboard/vim');
  expect(handler.name, equals(KeyboardHandler.VIM));
}
