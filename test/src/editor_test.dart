@TestGroup(description: 'Editor')
library ace.test.editor;

import 'dart:async';
import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

Editor editor;
@Setup
void setup() {
  html.document.body.append(new html.Element.div()..id = 'editor');
  editor = edit(html.querySelector('#editor'))
      ..setValue(sampleText, -1);
}

@Teardown
void teardown() {
  html.document.body.children.remove(html.querySelector('#editor'));
  editor.dispose();
  editor = null;
}

@Test()
void testEditElement() {
  final Editor editor = edit(html.querySelector('#editor'));
  expect(editor, isNotNull);
}

@Test()
@ExpectError()
void testEditNullThrows() {  
  final Editor a = edit(null);
}

@Test()
void testDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  editor.onBlur.listen(noop1, onDone: expectAsync0(noop0));
  editor.onChange.listen(noop1, onDone: expectAsync0(noop0));
  editor.onChangeSession.listen(noop1, onDone: expectAsync0(noop0));
  editor.onCopy.listen(noop1, onDone: expectAsync0(noop0));
  editor.onFocus.listen(noop1, onDone: expectAsync0(noop0));
  editor.onPaste.listen(noop1, onDone: expectAsync0(noop0));
  editor.dispose();
}

@Test()
@ExpectError()
void testDisposeTwiceThrows() {
  editor.dispose();
  editor.dispose();
}

@Test()
@ExpectError(isNoSuchMethodError)
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
  editor.setValue('snarf');
  expect(editor.value, equals('snarf'));
  expect(editor.cursorPosition, equals(const Point(0, 5))); 
  expect(editor.selectionRange, equals(new Range(0, 0, 0, 5)));
  // -1 = document start
  editor.setValue('start', -1);
  expect(editor.value, equals('start'));
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  expect(editor.selectionRange, equals(new Range(0, 0, 0, 0)));
  // 1 = document end
  editor.setValue('end', 1);
  expect(editor.value, equals('end'));
  expect(editor.cursorPosition, equals(const Point(0, 3)));
  expect(editor.selectionRange, equals(new Range(0, 3, 0, 3)));
}

@Test()
void testBlockIndent() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(const Point(0, 4)));
}

@Test()
void testBlockOutdent() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(const Point(0, 4)));
  editor.blockOutdent();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
}

@Test()
void testFirstVisibleRow() {
  expect(editor.firstVisibleRow, equals(0));
}

@Test()
void testInsert() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals('snarf'));    
  }));
  editor.insert('snarf');
  expect(editor.cursorPosition, equals(const Point(0,5)));
}

@Test()
void testNavigateDown() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateDown(3);
  expect(editor.cursorPosition, equals(const Point(3, 0)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateFileEnd() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
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
  expect(editor.cursorPosition, equals(const Point(0, 0)));  
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
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateLineStart() {
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  editor.navigateLineStart();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateRight() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateRight(6);
  expect(editor.cursorPosition, equals(const Point(0, 6)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateTo() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateTo(4, 25);
  expect(editor.cursorPosition, equals(const Point(4, 25)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateUp() {
  editor.navigateDown(4);
  expect(editor.cursorPosition, equals(const Point(4, 0)));
  editor.navigateUp(2);
  expect(editor.cursorPosition, equals(const Point(2, 0)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateWordLeft() {
  Point start = sampleTextWordStart(0, 5);
  editor.navigateTo(start.row, start.column);
  expect(editor.cursorPosition, equals(start));
  editor.navigateWordLeft();
  expect(editor.cursorPosition, equals(sampleTextWordStart(0, 4)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testNavigateWordRight() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateWordRight();
  expect(editor.cursorPosition, equals(const Point(0, 5)));
  expect(editor.selection.isEmpty, isTrue);
}

@Test()
void testRemoveToLineEnd() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 73)));
    RemoveTextDelta removeTextDelta = delta;    
    expect(removeTextDelta.text, equals(sampleTextLine0));
  })); 
  editor.removeToLineEnd();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
}

@Test()
void testRemoveToLineStart() {
  editor.navigateLineEnd();
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 73)));
    RemoveTextDelta removeTextDelta = delta;    
    expect(removeTextDelta.text, equals(sampleTextLine0));
  })); 
  editor.removeToLineStart();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
}

@Test()
void testRemoveWordLeft() {
  editor.setValue(sampleText, 1);
  expect(editor.cursorPosition, equals(const Point(5, 76)));  
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(5, 75, 5, 76)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals('.'));
  }));
  editor.removeWordLeft();
  expect(editor.cursorPosition, equals(const Point(5, 75)));  
}

@Test()
void testRemoveWordRight() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals('Lorem'));
  })); 
  editor.removeWordRight();
  expect(editor.cursorPosition, equals(const Point(0, 0)));  
}

@Test()
void testPrintMarginColumn() {
  editor.printMarginColumn = 42;
  expect(editor.printMarginColumn, equals(42));
}

@Test()
void testSetShowPrintMargin() {
  editor.showPrintMargin = true;
  expect(editor.showPrintMargin, isTrue);
  editor.showPrintMargin = false;
  expect(editor.showPrintMargin, isFalse);
}

@Test()
void testSetShowInvisibles() {
  editor.showInvisibles = true;
  expect(editor.showInvisibles, isTrue);
  editor.showInvisibles = false;
  expect(editor.showInvisibles, isFalse);
}

@Test()
void testSetTheme() {
  editor.theme = new Theme.named(Theme.MERBIVORE);
  expect(editor.theme.name, equals(Theme.MERBIVORE));
  editor.theme = new Theme.named(Theme.CHAOS);
  expect(editor.theme.name, equals(Theme.CHAOS));
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

@Test()
void testHighlightGutterLine() {
  editor.highlightGutterLine = true;
  expect(editor.highlightGutterLine, isTrue);
  editor.highlightGutterLine = false;
  expect(editor.highlightGutterLine, isFalse);
}

@Test()
void testHighlightSelectedWord() {
  editor.highlightSelectedWord = true;
  expect(editor.highlightSelectedWord, isTrue);
  editor.highlightSelectedWord = false;
  expect(editor.highlightSelectedWord, isFalse);
}

@Test()
void testSetOverwrite() {
  final bool initialValue = editor.overwrite;
  editor.session.onChangeOverwrite.listen(expectAsync1((_) {
    expect(editor.overwrite, isNot(initialValue));
  })); 
  editor.overwrite = !initialValue;
}

@Test()
void testToggleOverwrite() {
  final bool initialValue = editor.overwrite;
  editor.session.onChangeOverwrite.listen(expectAsync1((_) {
    expect(editor.overwrite, isNot(initialValue));
  })); 
  editor.toggleOverwrite();
}

@Test()
void testSetSession() {
  final EditSession initialSession = editor.session;
  final EditSession newSession = createEditSession('snarf', 
      new Mode('ace/mode/text'));
  editor.onChangeSession.listen(expectAsync1((EditSessionChangeEvent ev) {
    expect(ev.oldSession.value, equals(initialSession.value));
    expect(ev.newSession.value, equals(newSession.value));
  })); 
  editor.session = newSession;
}

@Test()
void testGetCopyText() {
  editor.selection.selectLineEnd();
  final start = const Point(0, 0);
  final end = new Point(0, sampleTextLine0.length);
  expect(editor.cursorPosition, equals(end));
  expect(editor.selectionRange, equals(new Range.fromPoints(start, end)));  
  editor.onCopy.listen(expectAsync1((String copyText) {
    expect(copyText, equals(sampleTextLine0));
  }));
  final String copyText = editor.copyText;
  expect(copyText, equals(sampleTextLine0));
}

@Test()
void testFontSize() {
  editor.fontSize = 14;
  expect(editor.fontSize, 14);
  editor.fontSize = 10;
  expect(editor.fontSize, 10);
}

@Test()
void testToLowerCase() {
  editor.selection.selectLineEnd();
  editor.toLowerCase();
  expect(editor.copyText, equals(sampleTextLine0.toLowerCase()));
}

@Test()
void testToUpperCase() {
  editor.selection.moveCursorDown();
  editor.selection.selectLineEnd();
  editor.toUpperCase();
  expect(editor.copyText, equals(sampleTextLine1.toUpperCase()));
}

@Test()
void testSetReadOnly() {
  editor.readOnly = true;
  expect(editor.readOnly, isTrue);
  editor.readOnly = false;
  expect(editor.readOnly, isFalse);
}

@Test()
void testUndoRedo() {
  final verify = expectAsync0(() {
    expect(editor.session.undoManager.hasUndo, isTrue);
    editor.undo();  
    expect(editor.session.undoManager.hasUndo, isFalse);
    expect(editor.session.undoManager.hasRedo, isTrue);
    expect(editor.value, isEmpty);
    editor.redo();
    expect(editor.session.undoManager.hasUndo, isTrue);
    expect(editor.session.undoManager.hasRedo, isFalse);
    expect(editor.value, equals(sampleText));
  });  
  // The UndoManager is notified internally after some delay from the initial
  // `setValue` call in our @Setup function; there does not seem to be any event 
  // that we can observe to reliably know when the UndoManager is updated. 
  new Future.delayed(const Duration(seconds: 1), verify); 
}

@Test()
void testSelectAll() {
  Point endCursor = new Point(sampleTextLines.length - 1, 
      sampleTextLines[sampleTextLines.length - 1].length);  
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  expect(editor.selectionRange, equals(new Range(0, 0, 0, 0)));
  editor.selectAll();
  expect(editor.cursorPosition, equals(endCursor));
  expect(editor.selectionRange, 
      equals(new Range.fromPoints(const Point(0, 0), endCursor)));
}

@Test()
void testClearSelection() {
  editor.selectAll();
  expect(editor.copyText, equals(sampleText));
  expect(editor.selection.isEmpty, isFalse);
  expect(editor.selectionRange.isEmpty, isFalse);
  editor.clearSelection();
  expect(editor.copyText, isEmpty);
  expect(editor.selection.isEmpty, isTrue);
  expect(editor.selectionRange.isEmpty, isTrue);
}

@Test()
void testCopyLinesDown() {
  editor.clearSelection();
  editor.navigateTo(2, 14);
  editor.selection.selectTo(3, 11);
  expect(editor.value, equals(sampleText));
  editor.copyLinesDown();
  final doc = editor.session.document;
  expect(doc.length, equals(sampleTextLines.length + 2));
  for (int i = 0; i < 4; i++) {
    expect(doc.getLine(i), equals(sampleTextLines[i]));
  }
  for (int i = 4; i < doc.length; i++) {
    expect(doc.getLine(i), equals(sampleTextLines[i - 2]));
  }
}

@Test()
void testCopyLinesUp() {
  editor.clearSelection();
  editor.navigateTo(4, 21);
  editor.selection.selectTo(5, 22);
  expect(editor.value, equals(sampleText));
  editor.copyLinesUp();
  final doc = editor.session.document;
  expect(doc.length, equals(sampleTextLines.length + 2));
  for (int i = 0; i < 6; i++) {
    expect(doc.getLine(i), equals(sampleTextLines[i]));
  }
  for (int i = 6; i < doc.length; i++) {
    expect(doc.getLine(i), equals(sampleTextLines[i - 2]));
  }
}

@Test()
void testGetOption() {
  editor.fontSize = 42;
  expect(editor.getOption('fontSize'), equals(42));
}

@Test()
void testGetOptions() {
  editor.fontSize = 13;
  editor.printMarginColumn = 57;
  var options = editor.getOptions(['fontSize', 'printMarginColumn']);
  expect(options.keys.length, equals(2));
  expect(options['fontSize'], equals(13));
  expect(options['printMarginColumn'], equals(57));
}

@Test()
void testSetOption() {
  editor.setOption('fontSize', 11);
  expect(editor.fontSize, equals(11));
}

@Test()
void testSetOptions() {
  editor.setOptions({ 'fontSize' : 8, 'printMarginColumn' : 76 });
  expect(editor.fontSize, equals(8));
  expect(editor.printMarginColumn, equals(76));
}

@Test()
void testGetKeyBinding() {
  var keyBinding = editor.keyBinding;
  expect(keyBinding, isNotNull);
  expect(keyBinding.keyboardHandler, isNotNull);
  expect(keyBinding.keyboardHandler.path, null);
}

@Test()
void testSetKeyboardHandlerDefault() {
  editor.keyboardHandler = new KeyboardHandler.named(KeyboardHandler.DEFAULT)
  ..onLoad.then(expectAsync1((_) {
    expect(editor.keyboardHandler.name, equals(KeyboardHandler.DEFAULT));
  }));
}

@Test()
void testSetKeyboardHandlerEmacs() {
  editor.keyboardHandler = new KeyboardHandler.named(KeyboardHandler.EMACS)
  ..onLoad.then(expectAsync1((_) {
    expect(editor.keyboardHandler.name, equals(KeyboardHandler.EMACS));
  }));  
}

@Test()
void testSetKeyboardHandlerVim() {
  editor.keyboardHandler = new KeyboardHandler.named(KeyboardHandler.VIM)
  ..onLoad.then(expectAsync1((_) {
    expect(editor.keyboardHandler.name, equals(KeyboardHandler.VIM));
  }));  
}

@Test()
void testSetKeyBindingKeyboardHandlerDefault() {
  var handler = new KeyboardHandler.named(KeyboardHandler.DEFAULT);
  editor.keyBinding.keyboardHandler = handler;
  handler.onLoad.then(expectAsync1((_) {
    expect(editor.keyBinding.keyboardHandler.name, 
        equals(KeyboardHandler.DEFAULT));
  }));
}

@Test()
void testSetKeyBindingKeyboardHandlerEmacs() {
  var handler = new KeyboardHandler.named(KeyboardHandler.EMACS);
  editor.keyBinding.keyboardHandler = handler;
  handler.onLoad.then(expectAsync1((_) {
    expect(editor.keyBinding.keyboardHandler.name, 
        equals(KeyboardHandler.EMACS));
  }));
}

@Test()
void testSetKeyBindingKeyboardHandlerVim() {
  var handler = new KeyboardHandler.named(KeyboardHandler.VIM);
  editor.keyBinding.keyboardHandler = handler;
  handler.onLoad.then(expectAsync1((_) {
    expect(editor.keyBinding.keyboardHandler.name, equals(KeyboardHandler.VIM));
  }));
}
