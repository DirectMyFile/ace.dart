library ace.test.browser;

import 'package:bench/bench.dart' as bench;
import 'package:unittest/html_enhanced_config.dart';
import 'editor_test.dart';
import 'point_test.dart';
import 'range_test.dart';

main() {
  useHtmlEnhancedConfiguration();
  bench.main();
}
