@Group('Editor')
library ace.test.editor;

import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

Editor editor;
@Setup
void setup() {
  html.document.body.append(new html.Element.div()..id = 'editor');
  editor = edit(html.query('#editor'))..setValue(sampleText, -1);
}

@Teardown
void teardown() {
  html.document.body.children.remove(html.query('#editor'));
}

@Test()
void testEditElement() {
  final Editor editor = edit(html.query('#editor'));
  expect(editor, isNotNull);
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
  expect(editor.isDisposed, isFalse);
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
  editor.dispose();
  editor.dispose();
}

@Test()
@ExpectThrows(isNoSuchMethodError)
void testCallMethodOnDisposedEditorThrows() {
  editor.dispose();
  editor.blur();
}

@Test()
void testBlur() {
  editor.focus();
  editor.onBlur.listen(expectAsync1((e) {
    expect(e, equals(editor));
    expect(editor.isFocused, isFalse);
  }));    
  editor.blur();
}

@Test()
void testFocus() {
  editor.blur();
  editor.onFocus.listen(expectAsync1((e) {
    expect(e, equals(editor));
    expect(editor.isFocused, isTrue);
  }));
  editor.focus();
}

@Test()
void testValue() {
  expect(editor.value, equals(sampleText));
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
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(new Point(0,4)));
}

@Test()
void testBlockOutdent() {
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(new Point(0,4)));
  editor.blockOutdent();
  expect(editor.cursorPosition, equals(new Point(0,0)));
}

@Test()
void testFirstVisibleRow() {
  expect(editor.firstVisibleRow, equals(0));
}

@Test()
void testInsert() {
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
void testNavigateFileEnd() {
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.navigateFileEnd();
  final lastTextLine = sampleTextLines.length - 1;
  expect(editor.cursorPosition, 
      equals(new Point(lastTextLine, sampleTextLines[lastTextLine].length)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateFileStart() {
  editor.navigateFileEnd();
  final lastTextLine = sampleTextLines.length - 1;
  expect(editor.cursorPosition, 
      equals(new Point(lastTextLine, sampleTextLines[lastTextLine].length)));
  editor.navigateFileStart();
  expect(editor.cursorPosition, equals(new Point(0,0)));  
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateLeft() {
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  editor.navigateLeft(17);
  expect(editor.cursorPosition, 
      equals(new Point(0, sampleTextLine0.length - 17)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateLineEnd() {
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateLineStart() {
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  editor.navigateLineStart();
  expect(editor.cursorPosition, equals(new Point(0, 0)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateRight() {
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.navigateRight(6);
  expect(editor.cursorPosition, equals(new Point(0, 6)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testRemoveToLineEnd() {
  expect(editor.cursorPosition, equals(new Point(0,0)));
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0,0,0,73)));
    RemoveTextDelta removeTextDelta = delta;    
    expect(removeTextDelta.text, equals(sampleTextLine0));
  })); 
  editor.removeToLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, 0)));
}

@Test()
void testRemoveToLineStart() {
  editor.navigateLineEnd();
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0,0,0,73)));
    RemoveTextDelta removeTextDelta = delta;    
    expect(removeTextDelta.text, equals(sampleTextLine0));
  })); 
  editor.removeToLineStart();
  expect(editor.cursorPosition, equals(new Point(0, 0)));
}

@Test()
void testRemoveWordLeft() {
  editor.setValue(sampleText, 1);
  expect(editor.cursorPosition, equals(new Point(5,76)));  
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(5,75,5,76)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals('.'));
  }));
  editor.removeWordLeft();
  expect(editor.cursorPosition, equals(new Point(5, 75)));  
}

@Test()
void testRemoveWordRight() {
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

@Test()
void testPrintMarginColumn() {
  editor.printMarginColumn = 42;
  expect(editor.printMarginColumn, equals(42));
}

@Test()
void testDragDelay() {
  editor.dragDelay = 42;
  expect(editor.dragDelay, equals(42));
}

@Test()
void testScrollSpeed() {
  editor.dragDelay = 7;
  expect(editor.dragDelay, equals(7));
}


@Test()
void testHighlightActiveLine() {
  editor.highlightActiveLine = true;
  expect(editor.highlightActiveLine, isTrue);
  editor.highlightActiveLine = false;
  expect(editor.highlightActiveLine, isFalse);
}
