@Group('Editor')
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

@Setup
void setup() {
  html.document.body.append(new html.Element.div()..id = 'editor');
}

@Teardown
void teardown() {
  html.document.body.children.remove(html.query('#editor'));
}

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
void testDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  final Editor editor = edit(html.query('#editor'));  
  expect(editor.isDisposed, isFalse);
  // We expect all the editor's streams to close.
  editor.onBlur.listen(noop1, onDone: expectAsync0(noop0));
  editor.onChange.listen(noop1, onDone: expectAsync0(noop0));
  editor.onCopy.listen(noop1, onDone: expectAsync0(noop0));
  editor.onFocus.listen(noop1, onDone: expectAsync0(noop0));
  editor.onPaste.listen(noop1, onDone: expectAsync0(noop0));
  editor.dispose();
  expect(editor.isDisposed, isTrue);
}

@Test()
@ExpectThrows()
void testDisposeTwiceThrows() {
  final Editor editor = edit(html.query('#editor'));
  editor.dispose();
  editor.dispose();
}

@Test()
@ExpectThrows(isNoSuchMethodError)
void testCallMethodOnDisposedEditorThrows() {
  final Editor editor = edit(html.query('#editor'));
  editor.dispose();
  editor.blur();
}

@Test()
void testBlur() {
  final Editor editor = edit(html.query('#editor'));
  editor.focus();
  editor.onBlur.listen(expectAsync1((e) {
    expect(e, equals(editor));
    expect(editor.isFocused, isFalse);
  }));    
  editor.blur();
}

@Test()
void testFocus() {
  final Editor editor = edit(html.query('#editor'));
  editor.blur();
  editor.onFocus.listen(expectAsync1((e) {
    expect(e, equals(editor));
    expect(editor.isFocused, isTrue);
  }));
  editor.focus();
}

@Test()
void testValue() {
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
void testBlockIndent() {
  final Editor editor = edit(html.query('#editor'));
  editor.setValue(sampleText, -1);
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(new Point(0,4)));
}

@Test()
void testBlockOutdent() {
  final Editor editor = edit(html.query('#editor'));
  editor.setValue(sampleText, -1);
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(new Point(0,4)));
  editor.blockOutdent();
  expect(editor.cursorPosition, equals(new Point(0,0)));
}

@Test()
void testInsert() {
  final Editor editor = edit(html.query('#editor'));
  editor.setValue(sampleText, -1);
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0,0,0,5)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals('snarf'));    
  }));
  editor.insert('snarf');
  expect(editor.cursorPosition, equals(new Point(0,5)));
}

@Test()
void testRemoveWordLeft() {
  final Editor editor = edit(html.query('#editor'));
  editor.setValue(sampleText, 1);
  expect(editor.cursorPosition, equals(new Point(6,0)));  
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(5,54,6,0)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals('\n'));
  }));  
  editor.removeWordLeft();
  expect(editor.cursorPosition, equals(new Point(5, 54)));  
}

@Test()
void testRemoveWordRight() {
  final Editor editor = edit(html.query('#editor'));
  editor.setValue(sampleText, -1);
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0,0,0,5)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals('Lorem'));
  })); 
  editor.removeWordRight();
  expect(editor.cursorPosition, equals(new Point(0, 0)));  
}
