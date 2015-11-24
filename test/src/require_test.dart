library ace.test.require;

import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';

setup() {  
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
}

void testRequireLanguageTools() {
  var langTools = ace.require('ace/ext/language_tools');
  expect(langTools, isNotNull);  
  expect(langTools, const isInstanceOf<ace.LanguageTools>());
}
