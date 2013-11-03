@TestGroup(description: 'Mode')
library ace.test.mode;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

final _noop = (_){};

@Test()
void testCreateModeFromModePath() {
  final verifyMode = (String modePath) {
    expect(new Mode(modePath)..onLoad.then(expectAsync1(_noop)), isNotNull);
  };
  verifyMode('ace/mode/batchfile');
  verifyMode('ace/mode/c_cpp');
  verifyMode('ace/mode/coffee');
  verifyMode('ace/mode/csharp');
  verifyMode('ace/mode/css');
  verifyMode('ace/mode/dart');
  verifyMode('ace/mode/html');
  verifyMode('ace/mode/java'); 
  verifyMode('ace/mode/javascript'); 
  verifyMode('ace/mode/json');
  verifyMode('ace/mode/less');
  verifyMode('ace/mode/markdown');
  verifyMode('ace/mode/php');
  verifyMode('ace/mode/properties');
  verifyMode('ace/mode/python');
  verifyMode('ace/mode/ruby');
  verifyMode('ace/mode/scss');
  verifyMode('ace/mode/sh');
  verifyMode('ace/mode/text');
  verifyMode('ace/mode/typescript');
  verifyMode('ace/mode/xml');
  verifyMode('ace/mode/yaml');
}

@Test()
void testCreateModeFromFilePath() {
  final verifyMode = (String filePath) {
    expect(new Mode.forFile(filePath)..onLoad.then(expectAsync1(_noop)), 
        isNotNull);
  };
  verifyMode('some/script.bat');
  verifyMode('vm/allocator.cpp');
  verifyMode('vm/allocator.h');
  verifyMode('strong.coffee');
  verifyMode('vm/gc.cs');
  verifyMode('twit/boot.css');
  verifyMode('ftw.dart');
  verifyMode('browser.html');
  verifyMode('midp/midlet.java');
  verifyMode('some/legacy.js');  
  verifyMode('data.json');
  verifyMode('styles.less');
  verifyMode('README.md');
  verifyMode('CHANGELOG.markdown');
  verifyMode('server/run.php');
  verifyMode('build.properties');
  verifyMode('goog/devserver.py');
  verifyMode('converter.rb');
  verifyMode('converter.scss');
  verifyMode('run.sh');
  verifyMode('omg.ts');
  verifyMode('verbose.xml');
  verifyMode('pubspec.yaml');
}
