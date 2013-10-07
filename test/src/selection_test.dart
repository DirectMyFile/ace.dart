@TestGroup(description: 'Selection')
library ace.test.selection;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

EditSession session;
Selection selection;

@Setup
setup() {
  session = new EditSession(new Document(text: sampleText), 
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
  selection.onChangeCursor.listen(noop1, onDone: expectAsync0(noop0));
  selection.onChangeSelection.listen(noop1, onDone: expectAsync0(noop0));
  selection.dispose();
}

// Utility function for testing the various 'move*' methods.
void testMoveMethod(Function moveMethod,
                   {List positionalArgs: const [],
                    Point beforeCursor: const Point(0, 0),
                    Point afterCursor: const Point(0, 0)}) {
  expect(selection.cursor, equals(beforeCursor));
  selection.onChangeCursor.listen(expectAsync1((_) {}));
  Function.apply(moveMethod, positionalArgs);
  expect(selection.cursor, equals(afterCursor));
}

@Test()
void testMoveCursorBy() {
  testMoveMethod(selection.moveCursorBy, 
      positionalArgs: [3, 20],
      afterCursor: const Point(3, 20));
}

@Test()
void testMoveCursorByNegative() {
  selection.moveCursorTo(4, 25);  
  testMoveMethod(selection.moveCursorBy, 
      positionalArgs: [-1, -19],
      beforeCursor: const Point(4, 25),
      afterCursor: const Point(3, 6));
}

@Test()
void testMoveCursorDown() {
  selection.moveCursorTo(0, 15);  
  testMoveMethod(selection.moveCursorDown,
      beforeCursor: const Point(0, 15),
      afterCursor: const Point(1, 15));
}

@Test()
void testMoveCursorFileEnd() {
  int lastRow = sampleTextLines.length - 1;
  testMoveMethod(selection.moveCursorFileEnd,
      afterCursor: new Point(lastRow, sampleTextLines[lastRow].length));
}

@Test()
void testMoveCursorFileStart() {
  selection.moveCursorTo(3, 37); 
  testMoveMethod(selection.moveCursorFileStart,
      beforeCursor: const Point(3, 37),
      afterCursor: const Point(0, 0));
}

@Test()
void testMoveCursorLeft() {
  selection.moveCursorTo(4, 4);  
  testMoveMethod(selection.moveCursorLeft,
      beforeCursor: const Point(4, 4),
      afterCursor: const Point(4, 3));
}

@Test()
void testMoveCursorLineEnd() {
  selection.moveCursorTo(3, 3);  
  testMoveMethod(selection.moveCursorLineEnd,
      beforeCursor: const Point(3, 3),
      afterCursor: new Point(3, sampleTextLine3.length));
}

@Test()
void testMoveCursorLineStart() {
  selection.moveCursorTo(3, 3);  
  testMoveMethod(selection.moveCursorLineStart,
      beforeCursor: const Point(3, 3),
      afterCursor: new Point(3, 0));
}

@Test()
void testMoveCursorRight() {
  selection.moveCursorTo(2, 63);  
  testMoveMethod(selection.moveCursorRight,
      beforeCursor: const Point(2, 63),
      afterCursor: const Point(2, 64));
}

@Test()
void testMoveCursorTo() {
  testMoveMethod(selection.moveCursorTo, 
      positionalArgs: [4, 42],
      afterCursor: const Point(4, 42));
}

@Test()
void testMoveCursorToScreen() {
  int desiredLimit = 20;
  session.useWrapMode = true;  
  expect(session.adjustWrapLimit(desiredLimit, 80), isTrue);
  expect(session.wrapLimit, equals(desiredLimit));
  Point word = sampleTextWordStart(2, 7);  
  int screenRow = session.documentToScreenRow(word.row, word.column);
  int screenColumn = session.documentToScreenColumn(word.row, word.column);
  testMoveMethod(selection.moveCursorToScreen, 
      positionalArgs: [screenRow, screenColumn],
      afterCursor: word);
}

@Test()
void testMoveCursorUp() {
  selection.moveCursorTo(1, 52);  
  testMoveMethod(selection.moveCursorUp,
      beforeCursor: const Point(1, 52),
      afterCursor: const Point(0, 52));
}

@Test()
void testMoveCursorWordLeft() {
  Point start = sampleTextWordStart(2, 4);
  selection.moveCursorTo(start.row, start.column);  
  testMoveMethod(selection.moveCursorWordLeft,
      beforeCursor: start,
      afterCursor: sampleTextWordStart(2, 3));
}

@Test()
void testMoveCursorWordRight() {
  Point start = sampleTextWordStart(4, 6);
  selection.moveCursorTo(start.row, start.column);  
  testMoveMethod(selection.moveCursorWordRight,
      beforeCursor: start,
      afterCursor: sampleTextWordStart(4, 7));
}

// Utility function for testing the various 'select*' methods.
void testSelectMethod(Function selectionMethod,
                     {List positionalArgs: const [],
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
  selection.moveCursorTo(2, 20);  
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
  selection.moveCursorTo(1, 10);  
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
  selection.moveCursorTo(2, 2);  
  Point startCursor = const Point(2, 2);
  
  testSelectMethod(selection.selectFileStart,
      beforeCursor: startCursor,
      afterRangeEnd: startCursor);
}

@Test()
void testSelectLeft() {
  selection.moveCursorTo(1, 14);  
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
  selection.moveCursorTo(1, 14);  
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
  selection.moveCursorTo(2, 20);  
  Point startCursor = const Point(2, 20);
  Point endCursor = const Point(1, 20);
  
  testSelectMethod(selection.selectUp,
      beforeCursor: startCursor,
      afterCursor: endCursor,
      afterRangeStart: endCursor,
      afterRangeEnd: startCursor);
}

@Test()
void testSelectWord() {
  selection.moveCursorTo(3, 4);
  Point startCursor = const Point(3, 4);  
  Point afterRangeStart = sampleTextWordStart(3, 0);
  Point afterRangeEnd = sampleTextWordEnd(3, 0);
  
  testSelectMethod(selection.selectWord,
      beforeCursor: startCursor,
      afterCursor: afterRangeEnd,
      afterRangeStart: afterRangeStart,
      afterRangeEnd: afterRangeEnd);
}

@Test()
void testSelectWordLeft() {
  Point start = sampleTextWordStart(3, 2);  
  selection.moveCursorTo(start.row, start.column);  
  Point startCursor = start;  
  Point afterRangeStart = sampleTextWordStart(3, 1);
  Point afterRangeEnd = sampleTextWordEnd(3, 1);
  
  testSelectMethod(selection.selectWordLeft,
      beforeCursor: startCursor,
      afterCursor: afterRangeStart,
      afterRangeStart: afterRangeStart,
      afterRangeEnd: afterRangeEnd);
}

@Test()
void testSelectWordRight() {
  Point start = sampleTextWordEnd(4, 6);  
  selection.moveCursorTo(start.row, start.column);  
  Point startCursor = start;
  Point afterRangeStart = sampleTextWordStart(4, 7);
  Point afterRangeEnd = sampleTextWordEnd(4, 7);
  
  testSelectMethod(selection.selectWordRight,
      beforeCursor: startCursor,
      afterCursor: afterRangeEnd,
      afterRangeStart: afterRangeStart,
      afterRangeEnd: afterRangeEnd);
}
