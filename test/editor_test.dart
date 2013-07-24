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

@Test()
@ExpectThrows()
void testEditElementBadIdThrows() {  
  final Editor a = edit("snarf");
}

@Test()
void testBlurEditor() {
  final Editor editor = edit('editor');  
  editor.focus();
  editor.onBlur.listen(expectAsync1((e) {
    expect(e, equals(editor));
  }));    
  editor.blur();
}

@Test()
void testFocusEditor() {
  final Editor editor = edit('editor');  
  editor.blur();
  editor.onFocus.listen(expectAsync1((e) {
    expect(e, equals(editor));
  }));
  editor.focus();  
}
