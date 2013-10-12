@TestGroup(description: 'EditSession')
library ace.test.edit_session;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

EditSession session;
@Setup
setup() {  
  session = new EditSession(new Document(text: sampleText), 
    new Mode('ace/mode/text'));
}

@Test()
void testEditSessionCtor() {
  expect(session, isNotNull);
  expect(session.value, equals(sampleText));  
}

@Test()
void testCreateEditSession() {  
  session = createEditSession(sampleText, new Mode('ace/mode/dart'));
  expect(session, isNotNull); 
  expect(session.value, equals(sampleText));
}

@Test()
void testDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  session.onChange.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeBreakpoint.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeOverwrite.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeScrollLeft.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeScrollTop.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeTabSize.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeWrapLimit.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeWrapMode.listen(noop1, onDone: expectAsync0(noop0));
  session.dispose();
}

@Test()
void testDocument() {
  expect(session.document, const isInstanceOf<Document>());
  expect(session.document.value, equals(sampleText));
  final newText = 'do re me fa so la ti do';
  session.document = new Document(text: newText);
  expect(session.document.value, equals(newText));
  expect(session.value, equals(newText));
}

@Test()
void testGetLength() {
  expect(session.length, equals(6));
}

@Test()
void testGetTextRange() {
  expect(session.getTextRange(new Range(0, 0, 0, sampleTextLine0.length)),
      equals(sampleTextLine0));
}

@Test()
void testGetWordRange() {
  expect(session.getWordRange(0, 0), equals(new Range(0, 0, 0, 5)));
}

@Test()
void testValue() {
  final text = 'do re me fa so la ti do';
  session.value = text;
  expect(session.value, equals(text));
  expect(session.document.value, equals(text));
  session.document.value = sampleText;
  expect(session.value, equals(sampleText));
}

@Test()
void testSetTabSize() {
  session.onChangeTabSize.listen(expectAsync1((_) {    
    expect(session.tabSize, equals(7));    
  }));
  session.tabSize = 7;
}

@Test()
void testUndoSelect() {
  session.undoSelect = true;
  expect(session.undoSelect, isTrue);
  session.undoSelect = false;
  expect(session.undoSelect, isFalse);
}

@Test()
void testUseSoftTabs() {
  session.useSoftTabs = true;
  session.tabSize = 5;
  expect(session.useSoftTabs, isTrue);
  expect(session.tabString, equals('     '));
  session.useSoftTabs = false;
  expect(session.useSoftTabs, isFalse);
  expect(session.tabString, equals('\t'));
}

@Test()
void testIsTabStop() {
  session.useSoftTabs = true;
  session.tabSize = 7;
  for (int i = 0; i < sampleTextLine0.length; i++) {
    if (i % session.tabSize == 0) 
      expect(session.isTabStop(new Point(0, i)), isTrue);
    else
      expect(session.isTabStop(new Point(0, i)), isFalse);
  }
}

@Test()
void testUseWrapMode() {
  session.onChangeWrapMode.listen(expectAsync1((_){}, count: 1));
  session.useWrapMode = true;
  expect(session.useWrapMode, isTrue);
  session.useWrapMode = true; // Should not fire an event.
  expect(session.useWrapMode, isTrue);
//  session.useWrapMode = false;
//  expect(session.useWrapMode, isFalse);
}

@Test()
void testSetWrapLimitRange() {
  session.onChangeWrapMode.listen(expectAsync1((_) {    
    expect(session.wrapLimitRange['min'], equals(63));
    expect(session.wrapLimitRange['max'], equals(65));
  }));
  session.setWrapLimitRange(min: 63, max: 65);
}

@Test()
void testSetWrapLimitRangeMin() {
  session.onChangeWrapMode.listen(expectAsync1((_) {    
    expect(session.wrapLimitRange['min'], equals(63));
    expect(session.wrapLimitRange['max'], equals(null));
  }));
  session.setWrapLimitRange(min: 63);
}

@Test()
void testSetWrapLimitRangeMax() {
  session.onChangeWrapMode.listen(expectAsync1((_) {    
    expect(session.wrapLimitRange['min'], equals(null));
    expect(session.wrapLimitRange['max'], equals(65));
  }));
  session.setWrapLimitRange(max: 65);
}

@Test()
void testAdjustWrapLimit() {
  session.useWrapMode = true;
  session.setWrapLimitRange(min: 63, max: 65);  
  session.onChangeWrapLimit.listen(expectAsync1((_) {    
    expect(session.wrapLimit, equals(64));
  }));  
  expect(session.adjustWrapLimit(64, 80), isTrue);
  expect(session.wrapLimit, equals(64));
}

@Test()
void testSetScrollLeft() {
  session.onChangeScrollLeft.listen(expectAsync1((int scrollLeft) {
    expect(scrollLeft, equals(13));
    expect(session.scrollLeft, equals(13));
  })); 
  session.scrollLeft = 13;
}

@Test()
void testSetScrollTop() {
  session.onChangeScrollTop.listen(expectAsync1((int scrollTop) {
    expect(scrollTop, equals(42));
    expect(session.scrollTop, equals(42));
  })); 
  session.scrollTop = 42;
}

@Test()
void testSetOverwrite() {
  final bool initialValue = session.overwrite;
  session.onChangeOverwrite.listen(expectAsync1((_) {
    expect(session.overwrite, isNot(initialValue));
  })); 
  session.overwrite = !initialValue;
}

@Test()
void testToggleOverwrite() {
  final bool initialValue = session.overwrite;
  session.onChangeOverwrite.listen(expectAsync1((_) {
    expect(session.overwrite, isNot(initialValue));
  })); 
  session.toggleOverwrite();
}

@Test()
void testGetUndoManager() {
  // The EditSession ctor does not wire up an UndoManager but this does.
  session = createEditSession(sampleText, new Mode('ace/mode/dart'));
  final undoManager = session.undoManager;
  expect(undoManager, isNotNull);
  expect(undoManager.hasUndo, isFalse);
  expect(undoManager.hasRedo, isFalse);
}

@Test()
void testNewLineMode() {
  session.newLineMode = 'windows';
  expect(session.newLineMode, 'windows');
  expect(session.document.newLineCharacter, '\r\n');
  session.newLineMode = 'unix';
  expect(session.newLineMode, 'unix');
  expect(session.document.newLineCharacter, '\n');
  session.newLineMode = 'auto';
  expect(session.document.newLineMode, 'auto');
}

@Test()
void testGetLine() {
  for (int i = 0; i < sampleTextLines.length - 1; i++)
    expect(session.getLine(i), equals(sampleTextLines[i]));
}

@Test()
testGetAWordRange() {
  final range = session.getAWordRange(0, 0);
  expect(range, equals(new Range(0, 0, 0, 6)));
}

@Test()
void testGetRowLength() {
  expect(session.getRowLength(0), 1);
  int desiredLimit = 20;
  session.useWrapMode = true;  
  expect(session.adjustWrapLimit(desiredLimit, 80), isTrue);
  expect(session.wrapLimit, equals(desiredLimit));
  expect(session.getRowLength(0), 
      equals((sampleTextLine0.length / desiredLimit).ceil()));
}

@Test()
void testIndentRows() {
  final prefix = 'I_AM_YOUR_PREFIX';
  session.indentRows(3, 4, prefix);
  expect(session.getLine(0), equals(sampleTextLine0));
  expect(session.getLine(1), equals(sampleTextLine1));
  expect(session.getLine(2), equals(sampleTextLine2));
  expect(session.getLine(3).startsWith(prefix), isTrue);
  expect(session.getLine(3).length, 
      equals(sampleTextLine3.length + prefix.length));
  expect(session.getLine(4).startsWith(prefix), isTrue);
  expect(session.getLine(4).length, 
      equals(sampleTextLine4.length + prefix.length));
  expect(session.getLine(5), equals(sampleTextLine5));
}

@Test()
void testInsert() {
  session.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals('snarf'));    
  }));
  final point = session.insert(const Point(0, 0), 'snarf');
  expect(point, equals(new Point(0, 5)));
}

@Test()
void testMoveLinesDown() {  
  final verify = () {
    expect(session.getLine(0), equals(sampleTextLine0));
    expect(session.getLine(1), equals(sampleTextLine3));
    expect(session.getLine(2), equals(sampleTextLine1));
    expect(session.getLine(3), equals(sampleTextLine2));
    expect(session.getLine(4), equals(sampleTextLine4));
    expect(session.getLine(5), equals(sampleTextLine5));
  };
  session.moveLinesDown(1, 2);
  verify();
  session.moveLinesDown(5, 5);
  verify();
}

@Test()
void testMoveLinesUp() {
  final verify = () {
    expect(session.getLine(0), equals(sampleTextLine0));
    expect(session.getLine(1), equals(sampleTextLine1));
    expect(session.getLine(2), equals(sampleTextLine3));
    expect(session.getLine(3), equals(sampleTextLine2));
    expect(session.getLine(4), equals(sampleTextLine4));
    expect(session.getLine(5), equals(sampleTextLine5));
  };
  session.moveLinesUp(3, 3);
  verify();
  session.moveLinesUp(0, 0);
  verify();
}

@Test()
void testDocumentToScreenColumn() {
  int desiredLimit = 40;
  session.useWrapMode = true;  
  expect(session.adjustWrapLimit(desiredLimit, 80), isTrue);
  expect(session.wrapLimit, equals(desiredLimit));
  expect(session.documentToScreenColumn(0, 41), equals(1));  
}

@Test()
void testDocumentToScreenRow() {
  int desiredLimit = 20;
  session.useWrapMode = true;  
  expect(session.adjustWrapLimit(desiredLimit, 80), isTrue);
  expect(session.wrapLimit, equals(desiredLimit));
  expect(session.documentToScreenRow(0, 41), equals(2));  
}

@Test() 
void testDuplicateLines() {
  session.duplicateLines(0, 2);
  expect(session.getLine(0), equals(sampleTextLine0));
  expect(session.getLine(1), equals(sampleTextLine1));
  expect(session.getLine(2), equals(sampleTextLine2));
  expect(session.getLine(3), equals(sampleTextLine0));
  expect(session.getLine(4), equals(sampleTextLine1));
  expect(session.getLine(5), equals(sampleTextLine2));
  expect(session.getLine(6), equals(sampleTextLine3));
  expect(session.getLine(7), equals(sampleTextLine4));
  expect(session.getLine(8), equals(sampleTextLine5));  
}

@Test()
void testRemove() {
  session.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 10)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals(sampleTextLine0.substring(0, 10)));    
  }));
  final point = session.remove(new Range(0, 0, 0, 10));
  expect(point, equals(const Point(0, 0)));
}

@Test()
void testReplace() {
  int onChangeCount = 0;
  session.onChange.listen(expectAsync1((Delta delta) {    
    switch (onChangeCount++) {
      case 0:
        expect(delta, const isInstanceOf<RemoveTextDelta>());
        expect(delta.range, equals(new Range(3, 7, 3, 42)));
        RemoveTextDelta removeTextDelta = delta;
        expect(removeTextDelta.text, equals(sampleTextLine3.substring(7, 42)));
        break;
      case 1:
        expect(delta, const isInstanceOf<InsertTextDelta>());
        expect(delta.range, equals(new Range(3, 7, 3, 13)));
        InsertTextDelta insertTextDelta = delta;
        expect(insertTextDelta.text, equals('pardon'));
        break;
    }
  }, count: 2));
  final point = session.replace(new Range(3, 7, 3, 42), 'pardon');
  expect(point, equals(const Point(3, 13)));
}

@Test()
void testAddGutterDecoration() {
  session.onChangeBreakpoint.listen(expectAsync1((_){})); 
  session.addGutterDecoration(0, 'cssnarf');
}

@Test()
void testRemoveGutterDecoration() {
  session.onChangeBreakpoint.listen(expectAsync1((_){})); 
  session.removeGutterDecoration(0, 'cssnarf');
}

@Test() 
void testGetBreakpoints() {
  expect(session.breakpoints, isEmpty);
}

@Test()
void testSetBreakpoint() {
  session.onChangeBreakpoint.listen(expectAsync1((_) {
    expect(session.breakpoints[2], equals('ace_breakpoint'));
  }));  
  session.setBreakpoint(2);
}

@Test()
void testSetBreakpoints() {
  session.onChangeBreakpoint.listen(expectAsync1((_) {
    expect(session.breakpoints[2], isNotNull);
    expect(session.breakpoints[3], isNotNull);
    expect(session.breakpoints[4], isNotNull);
  }));  
  session.setBreakpoints([2, 3, 4]);
}

@Test()
void testSetBreakpointWithClassName() {
  session.onChangeBreakpoint.listen(expectAsync1((_) {
    expect(session.breakpoints[4], equals('fancy_breakpoint'));
  }));  
  session.setBreakpoint(4, className: 'fancy_breakpoint');
}

@Test()
void testClearBreakpoint() {
  session.setBreakpoint(3);
  expect(session.breakpoints[3], isNotNull);
  session.onChangeBreakpoint.listen(expectAsync1((_) {
    expect(session.breakpoints[3], isNull);
  }));
  session.clearBreakpoint(3);
}

@Test()
void testClearBreakpoints() {
  session.setBreakpoints([1, 4]);
  expect(session.breakpoints[1], isNotNull);
  expect(session.breakpoints[4], isNotNull);
  session.onChangeBreakpoint.listen(expectAsync1((_) {
    expect(session.breakpoints, isEmpty);
  }));
  session.clearBreakpoints();
}

@Test()
void testScreenToDocumentPosition() {
  int desiredLimit = 20;
  session.useWrapMode = true;  
  expect(session.adjustWrapLimit(desiredLimit, 80), isTrue);
  expect(session.wrapLimit, equals(desiredLimit));
  Point word = sampleTextWordStart(0, 8);  
  int screenRow = session.documentToScreenRow(word.row, word.column);
  int screenColumn = session.documentToScreenColumn(word.row, word.column);  
  expect(session.screenToDocumentPosition(screenRow, screenColumn), 
      equals(word));      
}
