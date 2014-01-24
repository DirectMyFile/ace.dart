@TestGroup(description: 'Theme')
library ace.test.theme;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

const _ACE_THEME_PATH = 'ace/theme/';

@Setup
setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
}

@Test()
void testCreateThemeNamed() {
  final verifyTheme = (String themeName) {
    final theme = new Theme.named(themeName);
    theme.onLoad.then(expectAsync1((_) {
      expect(theme.isLoaded, isTrue);
    }));
    expect(theme, isNotNull);
    expect(theme.name, themeName);
    expect(theme.path, '${_ACE_THEME_PATH}$themeName');
  };
  Theme.THEMES.forEach((String themeName) => verifyTheme(themeName));
}
