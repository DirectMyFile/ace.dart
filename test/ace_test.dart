library ace.test;

import 'package:bench/bench.dart' as bench;
import 'package:unittest/html_enhanced_config.dart';
import 'src/document_test.dart';
import 'src/editor_test.dart';
import 'src/point_test.dart';
import 'src/range_test.dart';

main() {
  useHtmlEnhancedConfiguration();
  bench.main();
}
