# Bench

A test bench for Dart.

[![Build Status][status]][badge] | [API documentation][api]

## Usage

### 1. Declare Test Libraries.

```dart
// The TestGroup annotation is optional.
@TestGroup(description: 'Console', runs: const ['a', 'b'])
library bench.example.console;
```

### 2. Declare Setup and Teardown Functions.

```dart
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
```

### 3. Declare Test Functions.

```dart
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
```

### 4. Reflect and Run Tests.

```dart
import 'package:bench/bench.dart';

// TODO: import your test libraries here so that reflection can find them.

// You may also add a `main` to a test library so that it may be run standalone!
void main() => reflectTests();
```

_Bench uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

[api]: http://futureperfect.info/bench/index.html#bench
[badge]: https://drone.io/github.com/rmsmith/bench/latest
[license]: https://github.com/rmsmith/bench/blob/master/LICENSE
[semantic versioning]: http://semver.org/
[status]: https://drone.io/github.com/rmsmith/bench/status.png
