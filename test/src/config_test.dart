@TestGroup('ace.config')
library ace.test.config;

import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

@Setup
setup() {  
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
}

@Test()
void testGetConfig() {
  expect(ace.config, isNotNull);
}

@Test()
void testSetModuleUrl() {
 expect(ace.config.moduleUrl('ace/theme/snarf', 'theme'), 
     isNot('app/theme-snarf.js'));
 expect(ace.config.setModuleUrl('ace/theme/snarf', 'app/theme-snarf.js'),
     equals('app/theme-snarf.js'));
 expect(ace.config.moduleUrl('ace/theme/snarf', 'theme'), 
     equals('app/theme-snarf.js'));
}
