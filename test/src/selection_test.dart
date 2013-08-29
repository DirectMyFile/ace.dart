@TestGroup('Selection')
library ace.test.selection;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

EditSession session;
Selection selection;

@Setup
setup() {
  session = new EditSession(new Document(sampleText), 
      new Mode('ace/mode/text'));
  selection = new Selection(session);
}

@Test()
void testSelectionCtor() {
  final Selection selection = new Selection(session);
  expect(selection, isNotNull);
  expect(selection.cursor, equals(const Point(0, 0)));
  expect(selection.isEmpty, isTrue);
  expect(selection.isMultiLine, isFalse);
}

@Test()
void testDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  expect(selection.hasProxy, isTrue);
  selection.onChangeCursor.listen(noop1, onDone: expectAsync0(noop0));
  selection.onChangeSelection.listen(noop1, onDone: expectAsync0(noop0));
  selection.dispose();
  expect(selection.hasProxy, isFalse);
}

@Test()
void testMoveCursorBy() {
  expect(selection.cursor, equals(const Point(0, 0)));
  int changeCount = 0;
  selection.onChangeCursor.listen(expectAsync1((_) {
    switch (changeCount++) {
      case 0:
        expect(selection.cursor, equals(const Point(3, 20)));
        selection.moveCursorBy(-1, -19);
        break;
      case 1:
        expect(selection.cursor, equals(const Point(2, 1)));
        break;
    }   
  }, count: 2));
  selection.moveCursorBy(3, 20);  
}

@Test()
void testMoveCursorTo() {
  selection.onChangeCursor.listen(expectAsync1((_) {
    expect(selection.cursor, equals(const Point(4, 42)));
  }));
  selection.moveCursorTo(4, 42, false);
}

// Utility function for testing the various 'select*' methods.
void testSelectMethod(Function selectionMethod,
                     {List positionalArgs,
                      Point beforeCursor: const Point(0, 0),
                      Point afterCursor: const Point(0, 0),
                      Point afterRangeStart: const Point(0, 0),
                      Point afterRangeEnd: const Point(0, 0)}) {
  expect(selection.cursor, equals(beforeCursor));
  expect(selection.range, 
      equals(new Range.fromPoints(beforeCursor, beforeCursor)));
  // TODO(rms): investigate why `onChangeSelection` fires 2 times.
  selection.onChangeSelection.listen(expectAsync1((_) {}, count: 2));
  selection.onChangeCursor.listen(expectAsync1((_) {}));
  Function.apply(selectionMethod, positionalArgs);
  expect(selection.cursor, equals(afterCursor));
  expect(selection.range, 
      equals(new Range.fromPoints(afterRangeStart, afterRangeEnd)));
}

@Test()
void testSelectAll() {  
  Point endCursor = new Point(sampleTextLines.length - 1, 
      sampleTextLines[sampleTextLines.length - 1].length);  
  
  testSelectMethod(selection.selectAll,
      afterCursor: endCursor,
      afterRangeEnd: endCursor);
}

@Test()
void testSelectAWord() {
  Point endCursor = new Point(0, sampleTextWords[0][0].length + 1/*space*/);
  
  testSelectMethod(selection.selectAWord,
      afterCursor: endCursor,
      afterRangeEnd: endCursor);
}

@Test()
void testSelectDown() {
  selection.moveCursorTo(2, 20, false);  
  Point startCursor = const Point(2, 20);
  Point endCursor = const Point(3, 20);
  
  testSelectMethod(selection.selectDown,
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: startCursor,
      afterRangeEnd: endCursor);
}

@Test()
void testSelectFileEnd() {
  selection.moveCursorTo(1, 10, false);  
  Point startCursor = const Point(1, 10);
  Point endCursor = new Point(sampleTextLines.length - 1, 
      sampleTextLines[sampleTextLines.length - 1].length);
  
  testSelectMethod(selection.selectFileEnd,
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: startCursor,
      afterRangeEnd: endCursor);
}

@Test()
void testSelectFileStart() {  
  selection.moveCursorTo(2, 2, false);  
  Point startCursor = const Point(2, 2);
  
  testSelectMethod(selection.selectFileStart,
      beforeCursor: startCursor,
      afterRangeEnd: startCursor);
}

@Test()
void testSelectLeft() {
  selection.moveCursorTo(1, 14, false);  
  Point startCursor = const Point(1, 14);
  Point endCursor = const Point(1, 13);
  
  testSelectMethod(selection.selectLeft,
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: endCursor,
      afterRangeEnd: startCursor);
}

@Test()
void testSelectLine() {
  selection.moveCursorBy(0, 21);  
  Point startCursor = const Point(0, 21);
  
  testSelectMethod(selection.selectLine,
      beforeCursor: startCursor,
      afterCursor: const Point(1, 0),
      afterRangeEnd: const Point(1, 0));
}

@Test()
void testSelectLineEnd() {
  selection.moveCursorBy(0, 15);
  Point startCursor = const Point(0, 15);
  Point endCursor = new Point(0, sampleTextLine0.length);
  
  testSelectMethod(selection.selectLineEnd,
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: startCursor,
      afterRangeEnd: endCursor);
}

@Test()
void testSelectLineStart() {
  selection.moveCursorBy(0, 42);
  Point startCursor = const Point(0, 42);
  
  testSelectMethod(selection.selectLineStart,
      beforeCursor: startCursor,
      afterRangeEnd: startCursor);
}

@Test()
void testSelectRight() {
  selection.moveCursorTo(1, 14, false);  
  Point startCursor = const Point(1, 14);
  Point endCursor = const Point(1, 15);
  
  testSelectMethod(selection.selectRight,
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: startCursor,
      afterRangeEnd: endCursor);
}

@Test()
void testSelectTo() {
  selection.moveCursorBy(0, 15);
  Point startCursor = const Point(0, 15);
  Point endCursor = new Point(4, 42);
  
  testSelectMethod(selection.selectTo,
      positionalArgs: [4, 42],
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: startCursor,
      afterRangeEnd: endCursor);
}

@Test()
void testSelectUp() {
  selection.moveCursorTo(2, 20, false);  
  Point startCursor = const Point(2, 20);
  Point endCursor = const Point(1, 20);
  
  testSelectMethod(selection.selectUp,
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: endCursor,
      afterRangeEnd: startCursor);
}

