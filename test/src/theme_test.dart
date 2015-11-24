library ace.test.theme;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';

const _ACE_THEME_PATH = 'ace/theme/';

setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
}

void testCreateThemeNamed() {
  final verifyTheme = (String themeName) {
    final theme = new Theme.named(themeName);
    theme.onLoad.then(expectAsync((_) {
      expect(theme.isLoaded, isTrue);
      expect(theme.isDark, isNotNull);
      expect(theme.cssClass, isNotNull);
      expect(theme.cssText, isNotNull);
    }));
    expect(theme, isNotNull);    
    expect(theme.name, themeName);
    expect(theme.path, '${_ACE_THEME_PATH}$themeName');
  };
  Theme.THEMES.forEach(verifyTheme);
}
