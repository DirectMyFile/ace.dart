// The TestGroup annotation is optional.
@TestGroup(description: 'Console', runs: const ['a', 'b'])
library bench.example.console;

import 'dart:async';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

void main() => reflectTests();

// The @Setup function is optional; there may be 0 or 1 per test library.
@Setup
// The TestRun argument is optional; it carries context based on @TestGroup.
setup(TestRun run) {
  if (run.id == 'a') {
    print('Setup is invoked one time before each test.');
  } else {
    print('And it can do different work each time the test group runs!');
  }
}

// The @Teardown function is optional; there may be 0 or 1 per test library.
@Teardown
// The optional TestRun argument may also be received here.
teardown() => print('Teardown is invoked one time after each test');

@Test('An example test case that passes.')
void testPass() {
  expect(true, isTrue);
}

@Test()
@ExpectError(isStateError)
void testError() {
  throw new StateError('snarf');
}

@Test()
@ExpectError(isUnimplementedError)
testAsyncError() {
  return new Future.delayed(const Duration(milliseconds: 100), () {
    throw new UnimplementedError();    
  }); 
}

@Test('Known to fail.', 'http://issue/42')
testSkipKnownFailure() {
  expect(false, isTrue);  
}
