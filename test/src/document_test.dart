@TestGroup(description: 'Document', runs: IMPLEMENTATIONS)
library ace.test.document;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

Document document;
bool useExperimental;

@Setup
setup(TestRun run) { 
  document = new Document(text: sampleText, useExperimental: run.id == PURE);
  useExperimental = run.id == PURE;
}

@Test()
void testDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  document.onChange.listen(noop1, onDone: expectAsync0(noop0));
  document.dispose();
}

@Test()
void testGetLength() {
  expect(document.length, equals(6));
}

@Test()
void testGetAllLines() {
  final lines = document.getAllLines();
  expect(lines.length, equals(6));
  for (int i = 0; i < sampleTextLines.length - 1; i++)
    expect(lines[i], equals(sampleTextLines[i]));
}

@Test()
void testGetLines() {
  final lines = document.getLines(2, 5);
  expect(lines.length, equals(4));
  expect(lines[0], equals(sampleTextLine2));
  expect(lines[1], equals(sampleTextLine3));
  expect(lines[2], equals(sampleTextLine4));
  expect(lines[3], equals(sampleTextLine5));
}

@Test()
void testGetLine() {
  for (int i = 0; i < sampleTextLines.length - 1; i++)
    expect(document.getLine(i), equals(sampleTextLines[i]));
}

@Test()
void testIndexToPosition() {
  int index = 
      sampleTextLine0.length + 
      sampleTextLine1.length + 
      sampleTextLine2.length + 
      3 * document.newLineCharacter.length;  
  expect(document.indexToPosition(index), equals(const Point(3, 0))); 
  index = 
      sampleTextLine1.length + 
      sampleTextLine2.length + 
      2 * document.newLineCharacter.length;  
  expect(document.indexToPosition(index, startRow: 1), 
      equals(const Point(3, 0)));
}

@Test()
void testInsert() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals('snarf'));    
  }));
  final point = document.insert(const Point(0, 0), 'snarf');
  expect(point, equals(const Point(0, 5)));
}

@Test()
void testInsertInLine() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals('snarf'));    
  }));
  final point = document.insertInLine(const Point(0, 0), 'snarf');
  expect(point, equals(const Point(0, 5)));
}

@Test()
void testInsertLines() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertLinesDelta>());
    expect(delta.range, equals(new Range(0, 0, 2, 0)));
    InsertLinesDelta insertLinesDelta = delta;
    expect(insertLinesDelta.lines.length, equals(2));
    expect(insertLinesDelta.lines, equals(['foo', 'bar']));
  }));
  final point = document.insertLines(0, ['foo', 'bar']);
  expect(point, equals(const Point(2, 0)));
}

@Test()
void testInsertNewLine() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 1, 0)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals(document.newLineCharacter));    
  }));
  final point = document.insertNewLine(const Point(0, 0));
  expect(point, equals(const Point(1, 0)));
}

@Test()
void testIsNewLine() {
  expect(document.isNewLine('\r\n'), isTrue);
  expect(document.isNewLine('\r'), isTrue);
  expect(document.isNewLine('\n'), isTrue);
  expect(document.isNewLine('\n\r'), isFalse);
}

@Test()
void testNewLineMode() {
  document.newLineMode = 'windows';
  expect(document.newLineMode, 'windows');
  expect(document.newLineCharacter, '\r\n');
  document.newLineMode = 'unix';
  expect(document.newLineMode, 'unix');
  expect(document.newLineCharacter, '\n');
  document.newLineMode = 'auto';
  expect(document.newLineMode, 'auto');
}

@Test()
void testPositionToIndex() {
  expect(document.positionToIndex(const Point(3, 0)),
      equals(
          sampleTextLine0.length + 
          sampleTextLine1.length + 
          sampleTextLine2.length + 
          3 * document.newLineCharacter.length)); 
  expect(document.positionToIndex(const Point(3, 0), startRow: 1),
      equals(
          sampleTextLine1.length + 
          sampleTextLine2.length + 
          2 * document.newLineCharacter.length));
}

@Test()
void testRemove() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0, 0, 0, 10)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals(sampleTextLine0.substring(0, 10)));    
  }));
  final point = document.remove(new Range(0, 0, 0, 10));
  expect(point, equals(const Point(0, 0)));
}

@Test()
void testRemoveInLine() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0, 10, 0, 20)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals(sampleTextLine0.substring(10, 20)));    
  }));
  final point = document.removeInLine(0, 10, 20);
  expect(point, equals(const Point(0, 10)));
}

@Test()
void testRemoveLines() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveLinesDelta>());
    expect(delta.range, equals(new Range(2, 0, 4, 0)));
    RemoveLinesDelta removeLinesDelta = delta;
    expect(removeLinesDelta.lines.length, equals(2));
    expect(removeLinesDelta.lines, equals([sampleTextLine2, sampleTextLine3]));
  }));
  final lines = document.removeLines(2, 3);
  expect(lines.length, equals(2));
  expect(lines[0], equals(sampleTextLine2));
  expect(lines[1], equals(sampleTextLine3));
}

@Test()
void testRemoveNewLine() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(3, sampleTextLine3.length, 4, 0)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals(document.newLineCharacter));    
  }));
  document.removeNewLine(3);  
}

@Test()
void testReplace() {
  int onChangeCount = 0;
  document.onChange.listen(expectAsync1((Delta delta) {    
    switch (onChangeCount++) {
      case 0:
        expect(delta, const isInstanceOf<RemoveTextDelta>());
        expect(delta.range, equals(new Range(0, 10, 0, 20)));
        RemoveTextDelta removeTextDelta = delta;
        expect(removeTextDelta.text, equals(sampleTextLine0.substring(10, 20)));
        break;
      case 1:
        expect(delta, const isInstanceOf<InsertTextDelta>());
        expect(delta.range, equals(new Range(0, 10, 0, 15)));
        InsertTextDelta insertTextDelta = delta;
        expect(insertTextDelta.text, equals('snarf'));
        break;
    }
  }, count: 2));
  final point = document.replace(new Range(0, 10, 0, 20), 'snarf');
  expect(point, equals(const Point(0, 15)));
}

@Test()
void testApplyDeltas() {
  final observedDeltas = new List<Delta>();
  final applyToNewDocument = () {
    var newDocument = new Document(text: sampleText);
    expect(newDocument.getAllLines(), isNot(equals(document.getAllLines())));        
    newDocument.onChange.listen(expectAsync1((_) {}, count: 3));    
    newDocument.applyDeltas(observedDeltas);
    expect(newDocument.getAllLines(), equals(document.getAllLines()));
  };    
  int observedDeltaCount = 0;
  document.onChange.listen(expectAsync1((Delta delta) { 
      observedDeltas.add(delta);
      if (++observedDeltaCount == 3) applyToNewDocument();
  }, count: 3));  
  document.insertLines(0, ['foo', 'bar']);  
  document.removeNewLine(4);
  document.insertNewLine(const Point(0, 2));
}

@Test()
void testRevertDeltas() {
  final deltas = new List<Delta>();
  int observedDeltaCount = 0;
  document.onChange.listen(expectAsync1((Delta delta) {    
    if (++observedDeltaCount <= 3) deltas.add(delta);
    if (observedDeltaCount == 3) document.revertDeltas(deltas);
    if (observedDeltaCount == 6) expect(document.value, equals(sampleText));
  }, count: 6));
  document.insertLines(0, ['foo', 'bar']);  
  document.removeNewLine(4);
  document.insertNewLine(const Point(0, 2));
  expect(document.value, isNot(equals(sampleText)));
}

@Test()
void testCreateAnchor() {
  final Anchor anchor = document.createAnchor(1, 42);
  expect(anchor, isNotNull);
  expect(anchor.position, equals(const Point(1, 42)));
}

@Test()
void testSplitTextContainsNewlineLiterals() {
  final dogfood = 
r'''
if ("aaa".split(/a/).length == 0)
  this.$split = function(text) {
    return text.replace(/\r\n|\r/g, "\n").split("\n");
  }
''';    
  final doc = new Document(text: dogfood, useExperimental: useExperimental);
  expect(doc.value, equals(dogfood));
}

@Test()
void testDocumentStartsWithNewline() {
  final startsWithNewLine =
r'''

after a newline some text.

and then a little bit more.

''';
  final doc = new Document(text: startsWithNewLine, 
      useExperimental: useExperimental);
  expect(doc.value, equals(startsWithNewLine));
}
