library ace.test.document;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

Document document;

setup() { 
  implementation = ACE_PROXY_IMPLEMENTATION;
  document = new Document(text: sampleText);
}

void testGetLength() {
  expect(document.length, equals(6));
}

void testGetAllLines() {
  final lines = document.getAllLines();
  expect(lines.length, equals(6));
  for (int i = 0; i < sampleTextLines.length - 1; i++)
    expect(lines[i], equals(sampleTextLines[i]));
}

void testGetLines() {
  final lines = document.getLines(2, 5);
  expect(lines.length, equals(4));
  expect(lines[0], equals(sampleTextLine2));
  expect(lines[1], equals(sampleTextLine3));
  expect(lines[2], equals(sampleTextLine4));
  expect(lines[3], equals(sampleTextLine5));
}

void testGetLine() {
  for (int i = 0; i < sampleTextLines.length - 1; i++)
    expect(document.getLine(i), equals(sampleTextLines[i]));
}

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

void testInsert() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.INSERT_TEXT));
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    expect(delta.text, equals('snarf'));    
  }));
  final point = document.insert(const Point(0, 0), 'snarf');
  expect(point, equals(const Point(0, 5)));
}

void testInsertInLine() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.INSERT_TEXT));
    expect(delta.range, equals(new Range(0, 0, 0, 5)));
    expect(delta.text, equals('snarf'));    
  }));
  final point = document.insertInLine(const Point(0, 0), 'snarf');
  expect(point, equals(const Point(0, 5)));
}

void testInsertLines() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.INSERT_LINES));
    expect(delta.range, equals(new Range(0, 0, 2, 0)));
    expect(delta.lines.length, equals(2));
    expect(delta.lines, equals(['foo', 'bar']));
  }));
  final point = document.insertLines(0, ['foo', 'bar']);
  expect(point, equals(const Point(2, 0)));
}

void testInsertNewLine() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.INSERT_TEXT));
    expect(delta.range, equals(new Range(0, 0, 1, 0)));
    expect(delta.text, equals(document.newLineCharacter));    
  }));
  final point = document.insertNewLine(const Point(0, 0));
  expect(point, equals(const Point(1, 0)));
}

void testIsNewLine() {
  expect(document.isNewLine('\r\n'), isTrue);
  expect(document.isNewLine('\r'), isTrue);
  expect(document.isNewLine('\n'), isTrue);
  expect(document.isNewLine('\n\r'), isFalse);
}

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

void testRemove() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_TEXT));
    expect(delta.range, equals(new Range(0, 0, 0, 10)));
    expect(delta.text, equals(sampleTextLine0.substring(0, 10)));    
  }));
  final point = document.remove(new Range(0, 0, 0, 10));
  expect(point, equals(const Point(0, 0)));
}

void testRemoveInLine() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_TEXT));
    expect(delta.range, equals(new Range(0, 10, 0, 20)));
    expect(delta.text, equals(sampleTextLine0.substring(10, 20)));    
  }));
  final point = document.removeInLine(0, 10, 20);
  expect(point, equals(const Point(0, 10)));
}

void testRemoveLines() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_LINES));
    expect(delta.range, equals(new Range(2, 0, 4, 0)));
    expect(delta.lines.length, equals(2));
    expect(delta.lines, equals([sampleTextLine2, sampleTextLine3]));
  }));
  final lines = document.removeLines(2, 3);
  expect(lines.length, equals(2));
  expect(lines[0], equals(sampleTextLine2));
  expect(lines[1], equals(sampleTextLine3));
}

void testRemoveNewLine() {
  document.onChange.listen(expectAsync((Delta delta) {
    expect(delta.action, equals(Delta.REMOVE_TEXT));
    expect(delta.range, equals(new Range(3, sampleTextLine3.length, 4, 0)));
    expect(delta.text, equals(document.newLineCharacter));    
  }));
  document.removeNewLine(3);  
}

void testReplace() {
  int onChangeCount = 0;
  document.onChange.listen(expectAsync((Delta delta) {    
    switch (onChangeCount++) {
      case 0:
        expect(delta.action, equals(Delta.REMOVE_TEXT));
        expect(delta.range, equals(new Range(0, 10, 0, 20)));
        expect(delta.text, equals(sampleTextLine0.substring(10, 20)));
        break;
      case 1:
        expect(delta.action, equals(Delta.INSERT_TEXT));
        expect(delta.range, equals(new Range(0, 10, 0, 15)));
        expect(delta.text, equals('snarf'));
        break;
    }
  }, count: 2));
  final point = document.replace(new Range(0, 10, 0, 20), 'snarf');
  expect(point, equals(const Point(0, 15)));
}

void testApplyDeltas() {
  final observedDeltas = new List<Delta>();
  final applyToNewDocument = () {
    var newDocument = new Document(text: sampleText);
    expect(newDocument.getAllLines(), isNot(equals(document.getAllLines()))); 
    newDocument.applyDeltas(observedDeltas);
    expect(newDocument.getAllLines(), equals(document.getAllLines()));
  };    
  int observedDeltaCount = 0;
  document.onChange.listen(expectAsync((Delta delta) { 
      observedDeltas.add(delta);
      if (++observedDeltaCount == 3) applyToNewDocument();
  }, count: 3));  
  document.insertLines(0, ['foo', 'bar']);  
  document.removeNewLine(4);
  document.insertNewLine(const Point(0, 2));
}

void testRevertDeltas() {
  final deltas = new List<Delta>();
  int observedDeltaCount = 0;
  document.onChange.listen(expectAsync((Delta delta) {    
    if (++observedDeltaCount <= 3) deltas.add(delta);
    if (observedDeltaCount == 3) document.revertDeltas(deltas);
    if (observedDeltaCount == 6) expect(document.value, equals(sampleText));
  }, count: 6));
  document.insertLines(0, ['foo', 'bar']);  
  document.removeNewLine(4);
  document.insertNewLine(const Point(0, 2));
  expect(document.value, isNot(equals(sampleText)));
}

void testCreateAnchor() {
  final Anchor anchor = document.createAnchor(1, 42);
  expect(anchor, isNotNull);
  expect(anchor.position, equals(const Point(1, 42)));
}

void testSplitTextContainsNewlineLiterals() {
  final dogfood = 
r'''
if ("aaa".split(/a/).length == 0)
  this.$split = function(text) {
    return text.replace(/\r\n|\r/g, "\n").split("\n");
  }
''';    
  final doc = new Document(text: dogfood);
  expect(doc.value, equals(dogfood));
}

void testDocumentStartsWithNewline() {
  final startsWithNewLine =
r'''

after a newline some text.

and then a little bit more.

''';
  final doc = new Document(text: startsWithNewLine);
  expect(doc.value, equals(startsWithNewLine));
}
