library bench.test.reflect_tests;

import 'package:bench/bench.dart';
import 'package:bench/mock_mirrors.dart';
import 'package:unittest/unittest.dart';

main() {
  group('reflectTests', () {
    setUp(() {
      // TODO(rms):
    });
    test('testReflectNoLibraries', testReflectNoLibraries);
  });
}

class MockTestDriver extends Mock<TestDriver> implements TestDriver {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void testReflectNoLibraries() {
  final mockMirrorSystem = new MockMirrorSystem()
  ..getters[#libraries] = () => {};
  final mockTestDriver = new MockTestDriver();      
  reflectTests(mirrorSystem: mockMirrorSystem, testDriver: mockTestDriver);
  expect(mockTestDriver.calls(#add), never);
  expect(mockTestDriver.calls(#run), once);
}
