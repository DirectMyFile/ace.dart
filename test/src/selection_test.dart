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
void testSelectMethod(void selectMethod(),
                      {Point beforeCursor: const Point(0, 0),
                      Point afterCursor: const Point(0, 0),
                      Point afterRangeStart: const Point(0, 0),
                      Point afterRangeEnd: const Point(0, 0)}) {
  expect(selection.cursor, equals(beforeCursor));
  expect(selection.range, 
      equals(new Range.fromPoints(beforeCursor, beforeCursor)));
  // TODO(rms): investigate why `onChangeSelection` fires 2 times.
  selection.onChangeSelection.listen(expectAsync1((_) {}, count: 2));
  selection.onChangeCursor.listen(expectAsync1((_) {}));
  selectMethod();
  expect(selection.cursor, equals(afterCursor));
  expect(selection.range, 
      equals(new Range.fromPoints(afterRangeStart, afterRangeEnd)));
}

@Test()
void testSelectAll() {  
  Point endPoint = new Point(sampleTextLines.length - 1, 
      sampleTextLines[sampleTextLines.length - 1].length);  
  
  testSelectMethod(selection.selectAll,
                   afterCursor: endPoint,
                   afterRangeEnd: endPoint);
}

@Test()
void testSelectAWord() {
  Point endWord = new Point(0, sampleTextWords[0][0].length + 1/*space*/);
  
  testSelectMethod(selection.selectAWord,
                   afterCursor: endWord,
                   afterRangeEnd: endWord);
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
