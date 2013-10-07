@TestGroup(description: 'Search')
library ace.test.search;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

Search search;
EditSession session;

@Setup
setup() {
  search = new Search();
  session = new EditSession(new Document(text: sampleText), 
      new Mode('ace/mode/text'));
}

@Test()
void testSearchCtor() {
  final Search search = new Search();
  expect(search, isNotNull);
  expect(search.options.backwards, isFalse);
  expect(search.options.caseSensitive, isFalse);
  expect(search.options.needle, isEmpty);
  expect(search.options.range, isNull);
  expect(search.options.regExp, isFalse);
  expect(search.options.skipCurrent, isFalse);
  expect(search.options.start, isNull);
  expect(search.options.wholeWord, isFalse);
  expect(search.options.wrap, isFalse);
}

@Test()
void testSetOptions() {
  search.options = new SearchOptions(backwards: true,
                                     caseSensitive: true,
                                     needle: 'snarf',
                                     range: new Range(1,2,3,4),
                                     regExp: true, 
                                     skipCurrent: true,
                                     start: new Range(5,6,7,8),
                                     wholeWord: true,
                                     wrap: true);
  expect(search.options.backwards, isTrue);
  expect(search.options.caseSensitive, isTrue);
  expect(search.options.needle, equals('snarf'));
  expect(search.options.range, new Range(1,2,3,4));
  expect(search.options.regExp, isTrue);
  expect(search.options.skipCurrent, isTrue);
  expect(search.options.start, new Range(5,6,7,8));
  expect(search.options.wholeWord, isTrue);
  expect(search.options.wrap, isTrue);
}

@Test()
void testFind() {
  search.options = new SearchOptions(needle: 'Lorem');
  expect(search.find(session), equals(new Range(0, 0, 0, 5)));  
}

@Test()
void testFindMissingNeedle() {
  search.options = new SearchOptions(needle: 'not gonna find me');
  expect(search.find(session), isNull);
}

@Test()
void testFindCaseSensitive() {
  search.options = new SearchOptions(needle: 'lorem');
  expect(search.find(session), equals(new Range(0, 0, 0, 5)));
  search.options = new SearchOptions(needle: 'lorem',
      caseSensitive: true);
  expect(search.find(session), isNull);
}

@Test()
void testFindStartAfterNeedle() {
  search.options = new SearchOptions(needle: 'Lorem',
      start: new Range(0, 6, 0, 6));
  expect(search.find(session), isNull);
}

@Test()
void testFindBackwards() {
  search.options = new SearchOptions(needle: 'Lorem',
      backwards: true,
      start: new Range(0, sampleTextLine0.length, 0, sampleTextLine0.length));
  expect(search.find(session), equals(new Range(0, 0, 0, 5)));  
}

@Test()
void testFindAll() {
  search.options = new SearchOptions(needle: 'ut');
  final ranges = search.findAll(session);
  expect(ranges.length, equals(4));
  expect(ranges.elementAt(0), equals(new Range(1, 18, 1, 20)));
  expect(ranges.elementAt(1), equals(new Range(1, 52, 1, 54)));
  expect(ranges.elementAt(2), equals(new Range(2, 48, 2, 50)));
  expect(ranges.elementAt(3), equals(new Range(3, 17, 3, 19)));
}

@Test()
void testFindAllWholeWord() {
  search.options = new SearchOptions(needle: 'ut',
      wholeWord: true);
  final ranges = search.findAll(session);
  expect(ranges.length, equals(3));
  expect(ranges.elementAt(0), equals(new Range(1, 18, 1, 20)));
  expect(ranges.elementAt(1), equals(new Range(1, 52, 1, 54)));
  expect(ranges.elementAt(2), equals(new Range(2, 48, 2, 50)));
}

@Test()
void testFindAllMissingNeedle() {
  search.options = new SearchOptions(needle: 'not gonna find me');
  expect(search.findAll(session), isEmpty);
}
