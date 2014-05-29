@TestGroup('ace.require')
library ace.test.require;

import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

@Setup
setup() {  
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
}

@Test()
void testRequireLanguageTools() {
  var langTools = ace.require('ace/ext/language_tools');
  expect(langTools, isNotNull);  
  expect(langTools, const isInstanceOf<ace.LanguageTools>());
}
