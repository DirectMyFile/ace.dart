@Group()
library ace.test.editor;

import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';

final String sampleText =
'''
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu 
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in 
culpa qui officia deserunt mollit anim id est laborum.
''';

@Test()
void testEditElement() {
  final Editor editor = edit(html.query('#editor'));
  expect(editor, isNotNull);
  expect(editor.readOnly, isFalse);
}

@Test()
@ExpectThrows()
void testEditNullThrows() {  
  final Editor a = edit(null);
}

@Test()
void testBlurEditor() {
  final Editor editor = edit(html.query('#editor'));
  editor.focus();
  editor.onBlur.listen(expectAsync1((e) {
    expect(e, equals(editor));
  }));    
  editor.blur();
}

@Test()
void testFocusEditor() {
  final Editor editor = edit(html.query('#editor'));
  editor.blur();
  editor.onFocus.listen(expectAsync1((e) {
    expect(e, equals(editor));
  }));
  editor.focus();  
}

@Test()
void testEditorValue() {
  final Editor editor = edit(html.query('#editor'));
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

@Test()
void testEditorBlockIndent() {
  final Editor editor = edit(html.query('#editor'));
  editor.setValue(sampleText, -1);
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(new Point(0,4)));
}
