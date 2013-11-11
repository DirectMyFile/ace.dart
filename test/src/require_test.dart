@TestGroup(description: 'ace.require')
library ace.test.require;

import 'package:ace/ace.dart' as ace;
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

@Test()
void testRequireLanguageTools() {
  var langTools = ace.require('ace/ext/language_tools');
  expect(langTools, isNotNull);  
}
