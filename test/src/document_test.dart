@Group('Document')
library ace.test.document;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

Document document;
// TODO(rms): figure out how to invoke the js `new Document(text)` ctor...
@Setup
setup() => document = createEditSession(sampleText, 'ace/mode/dart').document;

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
