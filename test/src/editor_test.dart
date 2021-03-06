library ace.test.editor;

import 'dart:async';
import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';
import '_.dart';
import 'mocks.dart';

// TODO: transition all of the tests to use the `mockRenderer`
html.Element container;
Editor editor;
Editor editorWithMockRenderer;
MockVirtualRenderer mockRenderer;

void setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
  container = new html.Element.div();
  html.document.body.append(container);
  editor = edit(container)
  ..setValue(sampleText, -1);
  mockRenderer = new MockVirtualRenderer();
  final session = new EditSession(new Document(text: sampleText), 
      new Mode.named(Mode.TEXT));    
  editorWithMockRenderer = new Editor(mockRenderer, session);
}

void teardown() {
  html.document.body.children.remove(container);  
  editor.dispose();  
  editor = null;
  container = null;
  editorWithMockRenderer.dispose();
  editorWithMockRenderer = null;
  mockRenderer.dispose();
  mockRenderer = null;
}

void testEditElement() {
  expect(editor, isNotNull);
}

void testBlur() {
  editor.focus();
  editor.onBlur.listen(expectAsync((e) {
    expect(e, isNull);
    expect(editor.isFocused, isFalse);
  }));    
  editor.blur();
}

void testFocus() {
  editor.blur();
  editor.onFocus.listen(expectAsync((e) {
    expect(e, isNull);
    expect(editor.isFocused, isTrue);
  }));
  editor.focus();
}

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

void testBlockIndent() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(const Point(0, 4)));
}

void testBlockOutdent() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.session.tabSize = 4;
  editor.blockIndent();
  expect(editor.cursorPosition, equals(const Point(0, 4)));
  editor.blockOutdent();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
}

void testIndent() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.session.tabSize = 6;
  editor.indent();
  expect(editor.cursorPosition, equals(const Point(0, 6)));
}

void testFirstVisibleRow() {
  mockRenderer.getters[#firstVisibleRow] = () => 42;
  expect(editorWithMockRenderer.firstVisibleRow, equals(42));
}

void testLastVisibleRow() {
  mockRenderer.getters[#lastVisibleRow] = () => 18;
  expect(editorWithMockRenderer.lastVisibleRow, equals(18));
}

void testInsert() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.INSERT_TEXT));
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    expect(delta.text, equals('snarf'));    
  }));
  editor.insert('snarf');
  expect(editor.cursorPosition, equals(const Point(0,5)));
}

void testNavigateDown() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateDown(3);
  expect(editor.cursorPosition, equals(const Point(3, 0)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateFileEnd() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateFileEnd();
  final lastTextLine = sampleTextLines.length - 1;
  expect(editor.cursorPosition, 
      equals(new Point(lastTextLine, sampleTextLines[lastTextLine].length)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateFileStart() {
  editor.navigateFileEnd();
  final lastTextLine = sampleTextLines.length - 1;
  expect(editor.cursorPosition, 
      equals(new Point(lastTextLine, sampleTextLines[lastTextLine].length)));
  editor.navigateFileStart();
  expect(editor.cursorPosition, equals(const Point(0, 0)));  
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateLeft() {
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  editor.navigateLeft(17);
  expect(editor.cursorPosition, 
      equals(new Point(0, sampleTextLine0.length - 17)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateLineEnd() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateLineStart() {
  editor.navigateLineEnd();
  expect(editor.cursorPosition, equals(new Point(0, sampleTextLine0.length)));
  editor.navigateLineStart();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateRight() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateRight(6);
  expect(editor.cursorPosition, equals(const Point(0, 6)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateTo() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateTo(4, 25);
  expect(editor.cursorPosition, equals(const Point(4, 25)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateUp() {
  editor.navigateDown(4);
  expect(editor.cursorPosition, equals(const Point(4, 0)));
  editor.navigateUp(2);
  expect(editor.cursorPosition, equals(const Point(2, 0)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateWordLeft() {
  Point start = sampleTextWordStart(0, 5);
  editor.navigateTo(start.row, start.column);
  expect(editor.cursorPosition, equals(start));
  editor.navigateWordLeft();
  expect(editor.cursorPosition, equals(sampleTextWordStart(0, 4)));
  expect(editor.selection.isEmpty, isTrue);
}

void testNavigateWordRight() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.navigateWordRight();
  expect(editor.cursorPosition, equals(const Point(0, 5)));
  expect(editor.selection.isEmpty, isTrue);
}

void testRemoveToLineEnd() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_TEXT));
    expect(delta.range, equals(new Range(0, 0, 0, 73)));
    expect(delta.text, equals(sampleTextLine0));
  })); 
  editor.removeToLineEnd();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
}

void testRemoveToLineStart() {
  editor.navigateLineEnd();
  editor.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_TEXT));
    expect(delta.range, equals(new Range(0, 0, 0, 73)));  
    expect(delta.text, equals(sampleTextLine0));
  })); 
  editor.removeToLineStart();
  expect(editor.cursorPosition, equals(const Point(0, 0)));
}

void testRemoveWordLeft() {
  editor.setValue(sampleText, 1);
  expect(editor.cursorPosition, equals(const Point(5, 76)));  
  editor.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_TEXT));
    expect(delta.range, equals(new Range(5, 75, 5, 76)));
    expect(delta.text, equals('.'));
  }));
  editor.removeWordLeft();
  expect(editor.cursorPosition, equals(const Point(5, 75)));  
}

void testRemoveWordRight() {
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_TEXT));
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    expect(delta.text, equals('Lorem'));
  })); 
  editor.removeWordRight();
  expect(editor.cursorPosition, equals(const Point(0, 0)));  
}

void testPrintMarginColumn() {
  editor.printMarginColumn = 42;
  expect(editor.printMarginColumn, equals(42));
}

void testSetShowPrintMargin() {
  editor.showPrintMargin = true;
  expect(editor.showPrintMargin, isTrue);
  editor.showPrintMargin = false;
  expect(editor.showPrintMargin, isFalse);
}

void testSetShowInvisibles() {
  editor.showInvisibles = true;
  expect(editor.showInvisibles, isTrue);
  editor.showInvisibles = false;
  expect(editor.showInvisibles, isFalse);
}

void testSetTheme() {
  editor.theme = new Theme.named(Theme.MERBIVORE);
  expect(editor.theme.name, equals(Theme.MERBIVORE));
  editor.theme = new Theme.named(Theme.CHAOS);
  expect(editor.theme.name, equals(Theme.CHAOS));
}

void testDragDelay() {
  editor.dragDelay = 42;
  expect(editor.dragDelay, equals(42));
}

void testFadeFoldWidgets() {
  editor.fadeFoldWidgets = true;
  expect(editor.fadeFoldWidgets, equals(true));
  editor.fadeFoldWidgets = false;
  expect(editor.fadeFoldWidgets, equals(false));
}

void testShowFoldWidgets() {
  editor.showFoldWidgets = true;
  expect(editor.showFoldWidgets, equals(true));
  editor.showFoldWidgets = false;
  expect(editor.showFoldWidgets, equals(false));
}

void testScrollSpeed() {
  editor.scrollSpeed = 7;
  expect(editor.scrollSpeed, equals(7));
}

void testHighlightActiveLine() {
  editor.highlightActiveLine = true;
  expect(editor.highlightActiveLine, isTrue);
  editor.highlightActiveLine = false;
  expect(editor.highlightActiveLine, isFalse);
}

void testHighlightGutterLine() {
  editor.highlightGutterLine = true;
  expect(editor.highlightGutterLine, isTrue);
  editor.highlightGutterLine = false;
  expect(editor.highlightGutterLine, isFalse);
}

void testHighlightSelectedWord() {
  editor.highlightSelectedWord = true;
  expect(editor.highlightSelectedWord, isTrue);
  editor.highlightSelectedWord = false;
  expect(editor.highlightSelectedWord, isFalse);
}

void testSetOverwrite() {
  final bool initialValue = editor.overwrite;
  editor.session.onChangeOverwrite.listen(expectAsync((_) {
    expect(editor.overwrite, isNot(initialValue));
  })); 
  editor.overwrite = !initialValue;
}

void testToggleOverwrite() {
  final bool initialValue = editor.overwrite;
  editor.session.onChangeOverwrite.listen(expectAsync((_) {
    expect(editor.overwrite, isNot(initialValue));
  })); 
  editor.toggleOverwrite();
}

void testSetSession() {
  final EditSession initialSession = editor.session;
  final EditSession newSession = createEditSession('snarf', 
      new Mode('ace/mode/text'));
  editor.onChangeSession.listen(expectAsync((EditSessionChangeEvent ev) {
    expect(ev.oldSession.value, equals(initialSession.value));
    expect(ev.newSession.value, equals(newSession.value));
  })); 
  editor.session = newSession;
}

void testGetCopyText() {
  editor.selection.selectLineEnd();
  final start = const Point(0, 0);
  final end = new Point(0, sampleTextLine0.length);
  expect(editor.cursorPosition, equals(end));
  expect(editor.selectionRange, equals(new Range.fromPoints(start, end)));  
  editor.onCopy.listen(expectAsync((String copyText) {
    expect(copyText, equals(sampleTextLine0));
  }));
  final String copyText = editor.copyText;
  expect(copyText, equals(sampleTextLine0));
}

void testFontSize() {
  editor.fontSize = 14;
  expect(editor.fontSize, 14);
  editor.fontSize = 10;
  expect(editor.fontSize, 10);
}

void testToLowerCase() {
  editor.selection.selectLineEnd();
  editor.toLowerCase();
  expect(editor.copyText, equals(sampleTextLine0.toLowerCase()));
}

void testToUpperCase() {
  editor.selection.moveCursorDown();
  editor.selection.selectLineEnd();
  editor.toUpperCase();
  expect(editor.copyText, equals(sampleTextLine1.toUpperCase()));
}

void testSetReadOnly() {
  editor.readOnly = true;
  expect(editor.readOnly, isTrue);
  editor.readOnly = false;
  expect(editor.readOnly, isFalse);
}

void testUndoRedo() {
  final verify = expectAsync(() {
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

void testGetOption() {
  editor.fontSize = 42;
  expect(editor.getOption('fontSize'), equals(42));
}

void testGetOptions() {
  editor.fontSize = 13;
  editor.printMarginColumn = 57;
  var options = editor.getOptions(['fontSize', 'printMarginColumn']);
  expect(options.keys.length, equals(2));
  expect(options['fontSize'], equals(13));
  expect(options['printMarginColumn'], equals(57));
}

void testSetOption() {
  editor.setOption('fontSize', 11);
  expect(editor.fontSize, equals(11));
}

void testSetOptions() {
  editor.setOptions({ 'fontSize' : 8, 'printMarginColumn' : 76 });
  expect(editor.fontSize, equals(8));
  expect(editor.printMarginColumn, equals(76));
}

void testGetKeyBinding() {
  var keyBinding = editor.keyBinding;
  expect(keyBinding, isNotNull);
  expect(keyBinding.keyboardHandler, isNotNull);
  expect(keyBinding.keyboardHandler.path, null);
}

void testSetKeyboardHandlerDefault() {
  editor.keyboardHandler = new KeyboardHandler.named(KeyboardHandler.DEFAULT)
  ..onLoad.then(expectAsync((_) {
    expect(editor.keyboardHandler.name, equals(KeyboardHandler.DEFAULT));
  }));
}

void testSetKeyboardHandlerEmacs() {
  editor.keyboardHandler = new KeyboardHandler.named(KeyboardHandler.EMACS)
  ..onLoad.then(expectAsync((_) {
    expect(editor.keyboardHandler.name, equals(KeyboardHandler.EMACS));
  }));  
}

void testSetKeyboardHandlerVim() {
  editor.keyboardHandler = new KeyboardHandler.named(KeyboardHandler.VIM)
  ..onLoad.then(expectAsync((_) {
    expect(editor.keyboardHandler.name, equals(KeyboardHandler.VIM));
  }));  
}

void testSetKeyBindingKeyboardHandlerDefault() {
  var handler = new KeyboardHandler.named(KeyboardHandler.DEFAULT);
  editor.keyBinding.keyboardHandler = handler;
  handler.onLoad.then(expectAsync((_) {
    expect(editor.keyBinding.keyboardHandler.name, 
        equals(KeyboardHandler.DEFAULT));
  }));
}

void testSetKeyBindingKeyboardHandlerEmacs() {
  var handler = new KeyboardHandler.named(KeyboardHandler.EMACS);
  editor.keyBinding.keyboardHandler = handler;
  handler.onLoad.then(expectAsync((_) {
    expect(editor.keyBinding.keyboardHandler.name, 
        equals(KeyboardHandler.EMACS));
  }));
}

void testSetKeyBindingKeyboardHandlerVim() {
  var handler = new KeyboardHandler.named(KeyboardHandler.VIM);
  editor.keyBinding.keyboardHandler = handler;
  handler.onLoad.then(expectAsync((_) {
    expect(editor.keyBinding.keyboardHandler.name, equals(KeyboardHandler.VIM));
  }));
}

void testTransposeLetters() {
  editor.setValue('snarf', 1);
  editor.transposeLetters();
  expect(editor.value, equals('snafr'));
  editor.navigateLeft(3);
  editor.transposeLetters();
  expect(editor.value, equals('sanfr'));
  editor.navigateLineStart();
  editor.transposeLetters();
  expect(editor.value, equals('sanfr'));
}

void testGotoLine() {
  editor.setValue('line 1\nline 2');
  editor.gotoLine(2, 2, false);
  expect(editor.selectionRange.start.row, equals(1));
  expect(editor.selectionRange.start.column, equals(2));
  expect(editor.cursorPosition, equals(const Point(1, 2)));
  editor.gotoLine(1);
  expect(editor.selectionRange.start.row, equals(0));
  expect(editor.selectionRange.start.column, equals(0));
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.gotoLine(2, 99, true);
  expect(editor.selectionRange.start.row, equals(1));
  expect(editor.selectionRange.start.column, equals(6));
  expect(editor.cursorPosition, equals(const Point(1, 6)));
  editor.gotoLine(0, 99);
  expect(editor.selectionRange.start.row, equals(0));
  expect(editor.selectionRange.start.column, equals(0));
  expect(editor.cursorPosition, equals(const Point(0, 0)));
  editor.gotoLine(3, 1);
  expect(editor.selectionRange.start.row, equals(1));
  expect(editor.selectionRange.start.column, equals(6));
  expect(editor.cursorPosition, equals(const Point(1, 6)));
}

void testPaste() {
  editor.onPaste.listen(expectAsync((String text) {
    expect(text, equals('42'));
  }));
  editor.setValue('snarf', 1);
  editor.paste('42');
  expect(editor.value, equals('snarf42'));
}

void testGetCommandManager() {
  final cm = editor.commands;
  expect(cm, isNotNull);
  final commands = cm.getCommands();
  expect(commands, isNot(isEmpty));
}

void testExecCommand() {
  final c = new Command(
      'paste-answer',
      const BindKey(mac: 'Command-A', win: 'Ctrl-A'),
      (editor) {
        editor.paste('42');
      });  
  editor.setValue('snarf', 1);
  editor.commands.addCommand(c);
  editor.execCommand('paste-answer');
  expect(editor.value, equals('snarf42'));
}

void testScrollToLine() {
  // TODO: force resize to workaround known issue:
  // https://groups.google.com/forum/#!topic/ace-discuss/Dyz8U2N16HQ
  editor.resize(true);
  expect(editor.session.scrollTop, isZero);
  editor.scrollToLine(2);
  expect(editor.session.scrollTop, greaterThanOrEqualTo(2 * editor.fontSize));
}

void testScrollToRow() {
  // TODO: force resize to workaround known issue:
  // https://groups.google.com/forum/#!topic/ace-discuss/Dyz8U2N16HQ
  editor.resize(true);
  expect(editor.session.scrollTop, isZero);
  editor.scrollToRow(2);
  expect(editor.session.scrollTop, greaterThanOrEqualTo(2 * editor.fontSize));
}
