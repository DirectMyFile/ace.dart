@Group()
library ace.test.editor;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';

@Test()
void testEditElementById() {
  final Editor editor = edit("editor");
  expect(editor, isNotNull);
  expect(editor.readOnly, isFalse);
}
