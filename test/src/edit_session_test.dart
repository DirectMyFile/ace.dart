@TestGroup('EditSession')
library ace.test.edit_session;

import 'dart:async';
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

EditSession session;
@Setup
setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
  session = new EditSession(
      new Document(text: sampleText), 
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
void testCreateEditSessionModeIsLoaded() {  
  final mode = new Mode.named(Mode.DART);
  mode.onLoad.then(expectAsync((_) {
    session = createEditSession(sampleText, mode);
    expect(session, isNotNull); 
    expect(session.value, equals(sampleText));
    expect(session.mode.name, equals(mode.name));
  }));
}

@Test()
void testDispose() {
  expectDone(session.onChange);
  expectDone(session.onChangeAnnotation);
  expectDone(session.onChangeBackMarker);
  expectDone(session.onChangeBreakpoint);
  expectDone(session.onChangeFold);
  expectDone(session.onChangeFrontMarker);
  expectDone(session.onChangeOverwrite);
  expectDone(session.onChangeScrollLeft);
  expectDone(session.onChangeScrollTop);
  expectDone(session.onChangeTabSize);
  expectDone(session.onChangeWrapLimit);
  expectDone(session.onChangeWrapMode);
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
  session.onChangeTabSize.listen(expectAsync((_) {    
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
  expectTwoEvents(session.onChangeWrapMode);
  session.useWrapMode = true;
  expect(session.useWrapMode, isTrue);
  session.useWrapMode = true; // Should not fire an event.
  expect(session.useWrapMode, isTrue);
  session.useWrapMode = false;
  expect(session.useWrapMode, isFalse);
}

@Test()
void testSetWrapLimit() {
  session.onChangeWrapMode.listen(expectAsync((_) {  
    final wrapLimitRange = session.getWrapLimitRange();
    expect(wrapLimitRange.min, equals(42));
    expect(wrapLimitRange.max, equals(42));
  }));
  session.wrapLimit = 42;
}

@Test()
void testSetWrapLimitRange() {
  session.onChangeWrapMode.listen(expectAsync((_) {    
    final wrapLimitRange = session.getWrapLimitRange();
    expect(wrapLimitRange.min, equals(63));
    expect(wrapLimitRange.max, equals(65));
  }));
  session.setWrapLimitRange(min: 63, max: 65);
}

@Test()
void testSetWrapLimitRangeMin() {
  session.onChangeWrapMode.listen(expectAsync((_) { 
    final wrapLimitRange = session.getWrapLimitRange();
    expect(wrapLimitRange.min, equals(63));
    expect(wrapLimitRange.max, equals(null));
  }));
  session.setWrapLimitRange(min: 63);
}

@Test()
void testSetWrapLimitRangeMax() {
  session.onChangeWrapMode.listen(expectAsync((_) {    
    final wrapLimitRange = session.getWrapLimitRange();
    expect(wrapLimitRange.min, equals(null));
    expect(wrapLimitRange.max, equals(65));
  }));
  session.setWrapLimitRange(max: 65);
}

@Test()
void testAdjustWrapLimit() {
  session.useWrapMode = true;
  session.setWrapLimitRange(min: 63, max: 65);  
  session.onChangeWrapLimit.listen(expectAsync((_) {    
    expect(session.wrapLimit, equals(64));
  }));  
  expect(session.adjustWrapLimit(64, 80), isTrue);
  expect(session.wrapLimit, equals(64));
}

@Test()
void testSetScrollLeft() {
  session.onChangeScrollLeft.listen(expectAsync((int scrollLeft) {
    expect(scrollLeft, equals(13));
    expect(session.scrollLeft, equals(13));
  })); 
  session.scrollLeft = 13;
}

@Test()
void testSetScrollTop() {
  session.onChangeScrollTop.listen(expectAsync((int scrollTop) {
    expect(scrollTop, equals(42));
    expect(session.scrollTop, equals(42));
  })); 
  session.scrollTop = 42;
}

@Test()
void testSetOverwrite() {
  final bool initialValue = session.overwrite;
  session.onChangeOverwrite.listen(expectAsync((_) {
    expect(session.overwrite, isNot(initialValue));
  })); 
  session.overwrite = !initialValue;
}

@Test()
void testToggleOverwrite() {
  final bool initialValue = session.overwrite;
  session.onChangeOverwrite.listen(expectAsync((_) {
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

class MockUndoManager extends UndoManagerBase {  
  final mock = new Mock<UndoManager>();
  noSuchMethod(Invocation invocation) => mock.noSuchMethod(invocation);
}

@Test()
void testSetUndoManager() {
  final undoManager = new MockUndoManager();
  session.undoManager = undoManager;
  session.value = 'snarf';    
  session.insert(const Point(0, 0), 'ahoy');
  expect(undoManager.mock.calls(#reset), once);  
  final verify = expectAsync(() {
    expect(undoManager.mock.calls(#onExecuted), once);
  });
  // The UndoManager is notified internally after some delay; there does not 
  // seem to be any event that we can observe to reliably know when the 
  // UndoManager is updated.
  new Future.delayed(const Duration(seconds: 1), verify); 
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
void testScreenLength() {
  // Verify that we can invoke `EditSession.screenLength`.
  expect(session.screenLength, greaterThan(1));
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
  session.onChange.listen(expectAsync((Delta delta) {
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
  session.onChange.listen(expectAsync((Delta delta) {
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
  session.onChange.listen(expectAsync((Delta delta) {    
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
  expectOneEvent(session.onChangeBreakpoint); 
  session.addGutterDecoration(0, 'cssnarf');
}

@Test()
void testRemoveGutterDecoration() {
  expectOneEvent(session.onChangeBreakpoint); 
  session.removeGutterDecoration(0, 'cssnarf');
}

@Test()
void testGetAnnotations() {
  expect(session.getAnnotations(), isEmpty); 
}

@Test()
void testSetAnnotations() {
  session.onChangeAnnotation.listen(expectAsync((_) {
    final annotations = session.getAnnotations();
    expect(annotations.length, equals(2));
    expect(annotations[0], equals(const Annotation(
      row: 42,
      text: 'snarf')));
    expect(annotations[1], equals(const Annotation(
      row: 16,
      html: '<span>ruh-roh</span>', 
      type: Annotation.ERROR)));
  }));
  session.setAnnotations([
    const Annotation(row: 42, text: 'snarf'),
    const Annotation(
      row: 16,
      html: '<span>ruh-roh</span>', 
      type: Annotation.ERROR) 
  ]);
}

@Test()
void testClearAnnotations() {
  session.setAnnotations([const Annotation(row: 42, text: 'foo')]);
  final annotations = session.getAnnotations();
  expect(annotations.length, equals(1));
  expect(annotations[0], equals(
    const Annotation(row: 42, text: 'foo')));
  session.onChangeAnnotation.listen(expectAsync((_) {
    expect(session.getAnnotations(), isEmpty);
  }));
  session.clearAnnotations();
}

@Test() 
void testGetBreakpoints() {
  expect(session.getBreakpoints(), isEmpty);
}

@Test()
void testSetBreakpoint() {
  session.onChangeBreakpoint.listen(expectAsync((_) {
    expect(session.getBreakpoints()[2], equals('ace_breakpoint'));
  }));  
  session.setBreakpoint(2);
}

@Test()
void testSetBreakpoints() {
  session.onChangeBreakpoint.listen(expectAsync((_) {
    final breakpoints = session.getBreakpoints();
    expect(breakpoints[2], isNotNull);
    expect(breakpoints[3], isNotNull);
    expect(breakpoints[4], isNotNull);
  }));  
  session.setBreakpoints([2, 3, 4]);
}

@Test()
void testSetBreakpointWithClassName() {
  session.onChangeBreakpoint.listen(expectAsync((_) {
    expect(session.getBreakpoints()[4], equals('fancy_breakpoint'));
  }));  
  session.setBreakpoint(4, className: 'fancy_breakpoint');
}

@Test()
void testClearBreakpoint() {
  session.setBreakpoint(3);
  expect(session.getBreakpoints()[3], isNotNull);
  session.onChangeBreakpoint.listen(expectAsync((_) {
    expect(session.getBreakpoints()[3], isNull);
  }));
  session.clearBreakpoint(3);
}

@Test()
void testClearBreakpoints() {
  session.setBreakpoints([1, 4]);
  expect(session.getBreakpoints()[1], isNotNull);
  expect(session.getBreakpoints()[4], isNotNull);
  session.onChangeBreakpoint.listen(expectAsync((_) {
    expect(session.getBreakpoints(), isEmpty);
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

void _verifyFold(Fold actual, Fold expected) {
  expect(actual.range, expected.range);
  expect(actual.placeholder.length, expected.placeholder.length);
}
  
@Test()
void testAddFold() {
  Fold f = new Fold(
      new Range(0, 0, 0, 5),
      new Placeholder(session, 2, const Point(0, 1), [], 'snarf', 'foo'));
  session.onChangeFold.listen(expectAsync((FoldChangeEvent ev) {
    expect(ev.action, FoldChangeEvent.ADD);
    _verifyFold(ev.data, f);
  }));
  final added = session.addFold(f);
  _verifyFold(added, f);
  final folds = session.getAllFolds();
  expect(folds.length, 1);
  _verifyFold(folds[0], f);
}

@Test()
void testRemoveFold() {
  Fold f = new Fold(
      new Range(0, 8, 1, 15),
      new Placeholder(session, 7, const Point(1, 2), [], 'snarf', 'foo'));
  session.addFold(f);
  expect(session.getAllFolds().length, 1);
  session.onChangeFold.listen(expectAsync((FoldChangeEvent ev) {
    expect(ev.action, FoldChangeEvent.REMOVE);
    _verifyFold(ev.data, f);
  }));
  session.removeFold(f);
  expect(session.getAllFolds(), isEmpty);
}

@Test()
void testAddBackMarker() {
  final range = new Range(1, 2, 3, 4);
  final className = 'snarf';
  expectOneEvent(session.onChangeBackMarker);
  expectNoEvents(session.onChangeFrontMarker);
  final markerId = session.addMarker(range, className);
  expect(markerId, isNotNull);
  expect(session.getMarkers(inFront: true), isEmpty);
  final markers = session.getMarkers();
  expect(markers.length, 1);
  final marker = markers[markers.keys.first];
  expect(marker.id, markerId);
  expect(marker.range, new Range(1, 2, 3, 4));
  expect(marker.className, 'snarf');
  expect(marker.inFront, isFalse);
  expect(marker.type, Marker.LINE);
}

@Test()
void testAddFrontMarker() {
  final range = new Range(5, 6, 7, 8);
  final className = 'foo';
  expectOneEvent(session.onChangeFrontMarker);
  expectNoEvents(session.onChangeBackMarker);
  final markerId = session.addMarker(range, className, inFront: true);
  expect(markerId, isNotNull);
  expect(session.getMarkers(), isEmpty);
  final markers = session.getMarkers(inFront: true);
  expect(markers.length, 1);
  final marker = markers[markers.keys.first];
  expect(marker.id, markerId);
  expect(marker.range, new Range(5, 6, 7, 8));
  expect(marker.className, 'foo');
  expect(marker.inFront, isTrue);
  expect(marker.type, Marker.LINE);
}

@Test()
void testRemoveBackMarker() {
  final range = new Range(1, 2, 3, 4);
  final className = 'snarf';
  final markerId = session.addMarker(range, className);
  expect(markerId, isNotNull);
  expect(session.getMarkers(inFront: true), isEmpty);
  expect(session.getMarkers().length, 1);
  expectOneEvent(session.onChangeBackMarker);
  expectNoEvents(session.onChangeFrontMarker);
  session.removeMarker(markerId);
  expect(session.getMarkers(inFront: true), isEmpty);
  expect(session.getMarkers(), isEmpty);
}

@Test()
void testRemoveFrontMarker() {
  final range = new Range(5, 6, 7, 8);
  final className = 'foo';
  final markerId = session.addMarker(range, className, inFront: true);
  expect(markerId, isNotNull);
  expect(session.getMarkers(), isEmpty);
  expect(session.getMarkers(inFront: true).length, 1);
  expectOneEvent(session.onChangeFrontMarker);
  expectNoEvents(session.onChangeBackMarker);
  session.removeMarker(markerId);
  expect(session.getMarkers(inFront: true), isEmpty);
  expect(session.getMarkers(), isEmpty);
}

@Test()
void testGetOption() {
  session.tabSize = 7;
  expect(session.getOption('tabSize'), equals(7));
}

@Test()
void testGetOptions() {
  session.tabSize = 3;
  final tsMode = new Mode.named(Mode.TYPESCRIPT);
  session.mode = tsMode;
  var options = session.getOptions(['tabSize', 'mode']);
  expect(options.keys.length, equals(2));
  expect(options['tabSize'], equals(3));
  expect(options['mode'], equals(tsMode.path));
}

@Test()
void testSetOption() {
  session.setOption('tabSize', 1);
  expect(session.tabSize, equals(1));
}

@Test()
void testSetOptions() {
  final hamlMode = new Mode.named(Mode.HAML);
  session.setOptions({ 'tabSize' : 5, 'mode' : hamlMode.path });
  expect(session.tabSize, equals(5));
  expect(session.mode.path, equals(hamlMode.path));
}

@Test()
void testGetTokenAt() {
  Token t = session.getTokenAt(2);
  expect(t.type, equals(Token.TEXT));
  expect(t.value, equals(sampleTextLine2));
  expect(t.index, isZero);
  expect(t.start, isZero);
}

@Test()
void testGetTokens() {
  List<Token> tokens = session.getTokens(2);
  expect(tokens.length, equals(1));
  expect(tokens[0].type, equals(Token.TEXT));
  expect(tokens[0].value, equals(sampleTextLine2));
  expect(tokens[0].index, isNull);
  expect(tokens[0].start, isNull);  
}

