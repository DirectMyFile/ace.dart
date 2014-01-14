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
