@TestGroup('Mode')
library ace.test.mode;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

@Test()
void testCreateModeFromModePath() {
  final Mode mode = new Mode('ace/mode/text');
  expect(mode, isNotNull);  
  mode.onHasProxy.then(expectAsync1((_) {}));
}

@Test()
void testCreateModeFromFilePath() {
  final Mode mode = new Mode.forFile('path/to/file.js');
  expect(mode, isNotNull);
  mode.onHasProxy.then(expectAsync1((_) {})); 
}
