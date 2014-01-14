@TestGroup(description: 'Mode')
library ace.test.mode;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

const _ACE_MODE_PATH = 'ace/mode/';

@Test()
void testCreateModeNamed() {
  final verifyMode = (String modeName) {
    final mode = new Mode.named(modeName)
    ..onLoad.then(expectAsync1(noop1));
    expect(mode, isNotNull);
    expect(mode.name, modeName);
    expect(mode.path, '${_ACE_MODE_PATH}$modeName');
  };
  Mode.MODES.forEach((String modeName) => verifyMode(modeName));
}

@Test()
void testCreateModeFromFilePath() {
  final verifyMode = (String filePath, String expectedPath) {
    final mode = new Mode.forFile(filePath)
    ..onLoad.then(expectAsync1(noop1));
    expect(mode, isNotNull);
    expect(mode.path, equals(expectedPath));
  };
  verifyMode('some/script.bat',     '${_ACE_MODE_PATH}batchfile');
  verifyMode('vm/allocator.c',      '${_ACE_MODE_PATH}c_cpp');
  verifyMode('vm/allocator.cc',     '${_ACE_MODE_PATH}c_cpp');
  verifyMode('vm/allocator.cpp',    '${_ACE_MODE_PATH}c_cpp');
  verifyMode('vm/allocator.h',      '${_ACE_MODE_PATH}c_cpp');
  verifyMode('strong.coffee',       '${_ACE_MODE_PATH}coffee');
  verifyMode('vm/gc.cs',            '${_ACE_MODE_PATH}csharp');
  verifyMode('twit/boot.css',       '${_ACE_MODE_PATH}css');
  verifyMode('ftw.dart',            '${_ACE_MODE_PATH}dart');
  verifyMode('ready/set.go',        '${_ACE_MODE_PATH}golang');
  verifyMode('ro/bot.hx',           '${_ACE_MODE_PATH}haxe');
  verifyMode('browser.html',        '${_ACE_MODE_PATH}html');
  verifyMode('safe.hs',             '${_ACE_MODE_PATH}haskell');
  verifyMode('midp/midlet.java',    '${_ACE_MODE_PATH}java');
  verifyMode('some/legacy.js',      '${_ACE_MODE_PATH}javascript');  
  verifyMode('data.json',           '${_ACE_MODE_PATH}json');
  verifyMode('styles.less',         '${_ACE_MODE_PATH}less');
  verifyMode('flexible.lua',        '${_ACE_MODE_PATH}lua');
  verifyMode('README.md',           '${_ACE_MODE_PATH}markdown');
  verifyMode('CHANGELOG.markdown',  '${_ACE_MODE_PATH}markdown');
  verifyMode('server/run.php',      '${_ACE_MODE_PATH}php');
  verifyMode('build.properties',    '${_ACE_MODE_PATH}properties');
  verifyMode('goog/devserver.py',   '${_ACE_MODE_PATH}python');
  verifyMode('converter.rb',        '${_ACE_MODE_PATH}ruby');
  verifyMode('actor.scala',         '${_ACE_MODE_PATH}scala');
  verifyMode('converter.scss',      '${_ACE_MODE_PATH}scss');
  verifyMode('run.sh',              '${_ACE_MODE_PATH}sh');
  verifyMode('flower.svg',          '${_ACE_MODE_PATH}svg');
  verifyMode('omg.ts',              '${_ACE_MODE_PATH}typescript');
  verifyMode('verbose.xml',         '${_ACE_MODE_PATH}xml');
  verifyMode('pubspec.yaml',        '${_ACE_MODE_PATH}yaml');
}
