@TestGroup('Mode')
library ace.test.mode;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

const _ACE_MODE_PATH = 'ace/mode/';

@Setup
setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
}

@Test()
void testCreateModeNamed() {
  final verifyMode = (String modeName) {
    final mode = new Mode.named(modeName);
    mode.onLoad.then(expectAsync((_) {
      expect(mode.isLoaded, isTrue);
      final session = createEditSession(sampleText, mode);
      expect(session, isNotNull); 
      expect(session.mode.name, equals(mode.name));
      expect(session.mode.path, equals(mode.path));
    }));
    expect(mode, isNotNull);
    expect(mode.name, modeName);
    expect(mode.path, '${_ACE_MODE_PATH}$modeName');
  };
  Mode.MODES
  // TODO: send a PR to fix applescript mode's path
  .where((mode) => mode != Mode.APPLESCRIPT)
  .forEach((String modeName) => verifyMode(modeName));
}

@Test()
void testCreateModeForFile() {
  final verifyMode = (String filePath, String modeName) {
    final mode = new Mode.forFile(filePath);
    expectThen(mode.onLoad);
    expect(mode, isNotNull);
    expect(mode.name, modeName);
    expect(mode.path, '${_ACE_MODE_PATH}$modeName');
  };
  verifyMode('flashy.as',           Mode.ACTIONSCRIPT);
  verifyMode('some/script.bat',     Mode.BATCHFILE);
  verifyMode('vm/allocator.c',      Mode.C_CPP);
  verifyMode('vm/allocator.cc',     Mode.C_CPP);
  verifyMode('vm/allocator.cpp',    Mode.C_CPP);
  verifyMode('vm/allocator.h',      Mode.C_CPP);
  verifyMode('strong.coffee',       Mode.COFFEE);
  verifyMode('vm/gc.cs',            Mode.CSHARP);
  verifyMode('twit/boot.css',       Mode.CSS);
  verifyMode('ftw.dart',            Mode.DART);
  verifyMode('ready/set.go',        Mode.GOLANG);
  verifyMode('ro/bot.hx',           Mode.HAXE);
  verifyMode('aol.htm',             Mode.HTML);
  verifyMode('browser.html',        Mode.HTML);
  verifyMode('safe.hs',             Mode.HASKELL);
  verifyMode('config.ini',          Mode.INI);
  verifyMode('midp/midlet.java',    Mode.JAVA);
  verifyMode('some/legacy.js',      Mode.JAVASCRIPT);  
  verifyMode('data.json',           Mode.JSON);
  verifyMode('styles.less',         Mode.LESS);
  verifyMode('flexible.lua',        Mode.LUA);
  verifyMode('README.md',           Mode.MARKDOWN);
  verifyMode('CHANGELOG.markdown',  Mode.MARKDOWN);
  verifyMode('scripts/regex.pl',    Mode.PERL);
  verifyMode('module.pm',           Mode.PERL);
  verifyMode('server/run.php',      Mode.PHP);
  verifyMode('build.properties',    Mode.PROPERTIES);
  verifyMode('goog/devserver.py',   Mode.PYTHON);
  verifyMode('converter.rb',        Mode.RUBY);
  verifyMode('cheeky.sass',         Mode.SASS);
  verifyMode('actor.scala',         Mode.SCALA);
  verifyMode('converter.scss',      Mode.SCSS);
  verifyMode('run.sh',              Mode.SH);
  verifyMode('flower.svg',          Mode.SVG);
  verifyMode('omg.ts',              Mode.TYPESCRIPT);
  verifyMode('source.vala',         Mode.VALA);
  verifyMode('verbose.xml',         Mode.XML);
  verifyMode('pubspec.yaml',        Mode.YAML);
  Mode.extensionMap.addAll({ 
    'a': Mode.DART,
    'b': Mode.COLDFUSION
  });
  verifyMode('custom.a',            Mode.DART);
  verifyMode('custom.b',            Mode.COLDFUSION);
}
