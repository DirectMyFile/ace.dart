@Group('Document')
library ace.test.document;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

Document document;
@Setup
setup() => document = new Document(sampleText);

@Test()
void testGetLength() {
  expect(document.length, equals(6));
}

@Test()
void testGetAllLines() {
  final lines = document.allLines;
  expect(lines.length, equals(6));
  expect(lines[0], equals(sampleTextLine0));
  expect(lines[1], equals(sampleTextLine1));
  expect(lines[2], equals(sampleTextLine2));
  expect(lines[3], equals(sampleTextLine3));
  expect(lines[4], equals(sampleTextLine4));
  expect(lines[5], equals(sampleTextLine5));
}

@Test()
void testGetLine() {
  expect(document.getLine(0), equals(sampleTextLine0));
  expect(document.getLine(1), equals(sampleTextLine1));
  expect(document.getLine(2), equals(sampleTextLine2));
  expect(document.getLine(3), equals(sampleTextLine3));
  expect(document.getLine(4), equals(sampleTextLine4));
}

@Test()
void testInsert() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0,0,0,5)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals('snarf'));    
  }));
  final point = document.insert(new Point(0, 0), 'snarf');
  expect(point, equals(new Point(0, 5)));
}

@Test()
void testInsertInLine() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0,0,0,5)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals('snarf'));    
  }));
  final point = document.insertInLine(new Point(0, 0), 'snarf');
  expect(point, equals(new Point(0, 5)));
}

@Test()
void testInsertLines() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertLinesDelta>());
    expect(delta.range, equals(new Range(0,0,2,0)));
    InsertLinesDelta insertLinesDelta = delta;
    expect(insertLinesDelta.lines.length, equals(2));
    expect(insertLinesDelta.lines, equals(['foo', 'bar']));
  }));
  final point = document.insertLines(0, ['foo', 'bar']);
  expect(point, equals(new Point(2, 0)));
}

@Test()
void testInsertNewLine() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<InsertTextDelta>());
    expect(delta.range, equals(new Range(0,0,1,0)));
    InsertTextDelta insertTextDelta = delta;
    expect(insertTextDelta.text, equals(document.newLineCharacter));    
  }));
  final point = document.insertNewLine(new Point(0, 0));
  expect(point, equals(new Point(1, 0)));
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
  expect(document.positionToIndex(new Point(1, 0), 0),
      // + 1 for the newline character
      equals(sampleTextLine0.length + 1));
}

@Test()
void testRemove() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0,0,0,10)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals(sampleTextLine0.substring(0,10)));    
  }));
  final point = document.remove(new Range(0, 0, 0, 10));
  expect(point, equals(new Point(0, 0)));
}

@Test()
void testRemoveInLine() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveTextDelta>());
    expect(delta.range, equals(new Range(0,10,0,20)));
    RemoveTextDelta removeTextDelta = delta;
    expect(removeTextDelta.text, equals(sampleTextLine0.substring(10,20)));    
  }));
  final point = document.removeInLine(0, 10, 20);
  expect(point, equals(new Point(0, 10)));
}

@Test()
void testRemoveLines() {
  document.onChange.listen(expectAsync1((Delta delta) {
    expect(delta, const isInstanceOf<RemoveLinesDelta>());
    expect(delta.range, equals(new Range(2,0,4,0)));
    RemoveLinesDelta removeLinesDelta = delta;
    expect(removeLinesDelta.lines.length, equals(2));
    expect(removeLinesDelta.lines, equals([sampleTextLine2, sampleTextLine3]));
  }));
  final lines = document.removeLines(2, 3);
  expect(lines.length, equals(2));
  expect(lines[0], equals(sampleTextLine2));
  expect(lines[1], equals(sampleTextLine3));
}
