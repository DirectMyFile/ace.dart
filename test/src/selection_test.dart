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
  expect(selection.cursor, equals(new Point(0, 0)));
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
  expect(selection.cursor, equals(new Point(0, 0)));
  int changeCount = 0;
  selection.onChangeCursor.listen(expectAsync1((_) {
    switch (changeCount++) {
      case 0:
        expect(selection.cursor, equals(new Point(3, 20)));
        selection.moveCursorBy(-1, -19);
        break;
      case 1:
        expect(selection.cursor, equals(new Point(2, 1)));
        break;
    }   
  }, count: 2));
  selection.moveCursorBy(3, 20);  
}

@Test()
void testMoveCursorTo() {
  selection.onChangeCursor.listen(expectAsync1((_) {
    expect(selection.cursor, equals(new Point(4, 42)));
  }));
  selection.moveCursorTo(4, 42, false);
}

@Test()
void testSelectAll() {
  expect(selection.cursor, equals(new Point(0, 0)));
  expect(selection.range, equals(new Range(0, 0, 0, 0)));
  // TODO(rms): investigate why `onChangeSelection` fires 2 times.
  selection.onChangeSelection.listen(expectAsync1((_) {}, count: 2));
  selection.onChangeCursor.listen(expectAsync1((_) {}));
  selection.selectAll();
  Point endPoint = new Point(sampleTextLines.length - 1, 
      sampleTextLines[sampleTextLines.length - 1].length);
  expect(selection.cursor, equals(endPoint));
  expect(selection.range, 
      equals(new Range.fromPoints(new Point(0, 0), endPoint)));
}

@Test()
void testSelectAWord() {
  expect(selection.cursor, equals(new Point(0, 0)));
  expect(selection.range, equals(new Range(0, 0, 0, 0)));
  // TODO(rms): investigate why `onChangeSelection` fires 2 times.
  selection.onChangeSelection.listen(expectAsync1((_) {}, count: 2));
  selection.onChangeCursor.listen(expectAsync1((_) {}));
  selection.selectAWord();
  Point endWord = new Point(0, sampleTextWords[0][0].length + 1/*space*/);
  expect(selection.cursor, equals(endWord));
  expect(selection.range, 
      equals(new Range.fromPoints(new Point(0, 0), endWord)));
}
