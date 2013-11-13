library ace.test;

import 'package:bench/bench.dart' as bench;
import 'package:unittest/html_enhanced_config.dart';
import 'src/anchor_test.dart';
import 'src/document_test.dart';
import 'src/editor_test.dart';
import 'src/edit_session_test.dart';
import 'src/keyboard_handler_test.dart';
import 'src/mode_test.dart';
import 'src/point_test.dart';
import 'src/range_test.dart';
import 'src/require_test.dart';
import 'src/search_test.dart';
import 'src/selection_test.dart';
import 'src/virtual_renderer_test.dart';

main() {
  useHtmlEnhancedConfiguration();
  bench.reflectTests();
}
