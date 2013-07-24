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

@Test()
void testEditorValue() {
  final Editor editor = edit('editor');
  expect(editor.value, isEmpty);
  // 0 = select all
  editor.setValue('snarf', 0);
  expect(editor.value, equals('snarf'));
  expect(editor.cursorPosition, equals(new Point(0,5))); 
  expect(editor.selectionRange, equals(new Range(0,0,0,5)));
  // -1 = document start
  editor.setValue('start', -1);
  expect(editor.value, equals('start'));
  expect(editor.cursorPosition, equals(new Point(0,0)));
  expect(editor.selectionRange, equals(new Range(0,0,0,0)));
  // 1 = document end
  editor.setValue('end', 1);
  expect(editor.value, equals('end'));
  expect(editor.cursorPosition, equals(new Point(0,3)));
  expect(editor.selectionRange, equals(new Range(0,3,0,3)));
}
