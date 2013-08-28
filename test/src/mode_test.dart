@TestGroup('Mode')
library ace.test.mode;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

final _noop = (_){};

@Test()
void testCreateModeFromModePath() {
  final verifyMode = (String modePath) {
    expect(new Mode(modePath)..onHasProxy.then(expectAsync1(_noop)), isNotNull);
  };
  verifyMode('ace/mode/batchfile');
  verifyMode('ace/mode/c_cpp');
  verifyMode('ace/mode/csharp');
  verifyMode('ace/mode/css');
  verifyMode('ace/mode/dart');
  verifyMode('ace/mode/html');
  verifyMode('ace/mode/javascript');  
  verifyMode('ace/mode/text');  
}

@Test()
void testCreateModeFromFilePath() {
  final verifyMode = (String filePath) {
    expect(new Mode.forFile(filePath)..onHasProxy.then(expectAsync1(_noop)), 
           isNotNull);
  };
  verifyMode('some/script.bat');
  verifyMode('vm/allocator.cpp');
  verifyMode('vm/allocator.h');
  verifyMode('vm/gc.cs');
  verifyMode('twit/boot.css');
  verifyMode('ftw.dart');
  verifyMode('browser.html');
  verifyMode('some/legacy.js');  
}
