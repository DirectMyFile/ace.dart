@TestGroup(description: 'Browser')
library bench.example.browser;

import 'package:bench/bench.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';

main() {
  useHtmlEnhancedConfiguration();
  reflectTests();
}

@Test('An example test case that passes.')
void testPass() {
  expect(true, isTrue);
}
