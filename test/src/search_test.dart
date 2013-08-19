@Group('Search')
library ace.test.search;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';

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
