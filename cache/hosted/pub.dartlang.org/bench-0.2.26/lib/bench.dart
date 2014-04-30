library bench;

import 'dart:async';
import 'dart:mirrors';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';

part 'src/matcher.dart';
part 'src/meta.dart';
part 'src/mock.dart';
part 'src/reflect_tests.dart';
part 'src/test_driver.dart';
part 'src/unittest_driver.dart';

final Logger _logger = new Logger('bench');

final noop = ([_]){};
final _noop1 = (_){};
expectOneEvent(Stream s) => s.listen(expectAsync(_noop1));
expectTwoEvents(Stream s) => s.listen(expectAsync(_noop1, count: 2));
expectNEvents(Stream s, int n) => s.listen(expectAsync(_noop1, count: n));
expectDone(Stream s) => s.listen(_noop1, onDone: expectAsync(noop));
expectNoEvents(Stream s) => s.listen((_) => fail('Unexpected call'));
expectThen(Future f) => f.then(expectAsync(_noop1));
