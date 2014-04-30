# Bench Changes

## 0.2.26

- Added an `isStackOverflowError` matcher.
- Added `Usage` section to the `README`.

## 0.2.25

- Added an `isTimeoutException` matcher.
- Updated API documentation generation to use the new `docgen` tool.

## 0.2.24

- Renamed `Mock.clear` -> `Mock.clearCalls` to remove conflict with a method 
named `clear` on the class being mocked.

## 0.2.23

- Removed some type annotations on locals that were causing type errors to be 
thrown as of Dart SDK 1.2.0.dev_04_00.

## 0.2.22

- Update to `unittest` version `0.10.0`.

## 0.2.21

- Added functions `expectOneEvent`, `expectTwoEvents`, `expectNEvents`, 
`expectNoEvents`, and `expectDone` which set expectations for stream event 
counts but not data.
- Changed `Mock.clear` to only clear the `calls` and not the setup; the setup
may be cleared separately if desired.
- Moved mock mirror system into its own library `bench.mock.mirrors`.

## 0.2.20

- Added an optional `skip` reason string to the `@Test` annotation.  If given,
the test driver will skip the annotated test function and use the reason string
to log a message.

## 0.2.19

- Added a very simple yet useful `Mock` class.
- Removed the `main.dart` library that was previously used to run the 
`content_shell` executable for headless dartium testing.  This had been broken
since the Dart SDK removal of `content_shell`.
- Added an optional `testDriver` parameter to the `reflectTests` function; the
default `TestDriver` uses the `unittest` package as before but this change
allows for other future implementations.

## 0.2.18

- Added an optional `timeout` parameter to the `reflectTests()` function with
default value of 30 seconds.

## 0.2.17

- Updated to SDK 0.8.10_r29803.

## 0.2.16

- Updated to SDK 0.8.7_r29341.

## 0.2.15

- Reverted the support for `TestRun` in `Test` functions that was added in the
previous version.  This was decidedly a bad idea, as the goal of the `TestRun`
context is to allow a set of test functions to be run across multiple 
implementations.  As such, only the `Setup` and `Teardown` functions should 
have access to the implementation context.

## 0.2.14

- Add support for `Test` functions to declare 1 parameter of type `TestRun` to
receive the run context in addition to the `Setup` and `Teardown` functions.

## 0.2.13

- Updated to SDK 0.7.6_r28108.
- Added an optional `runs` parameter to the `@TestGroup` annotation, which
defaults to `['']`.  This provides a mechanism to declare multiple runs of a 
test group as a list of identifiers.  Any `Setup` or `Teardown` function may 
now declare 1 parameter of type `TestRun`.  The `TestRun` object provides a 
context specific to each run of the test group, including its identifer and run
count.
- Changed the `description` parameter of the `TestGroup` constructor from an 
optional to a named optional; this is a breaking change that was necessary to
accomodate the new `runs` named optional parameter.

## 0.2.12

- Updated to SDK 0.7.5_r27776.

## 0.2.11

- Updated to SDK 0.7.1_r27025.
- Renamed the `@ExpectThrows()` annotation to `@ExpectError()` to clarify that
it may be used to expect both thrown errors and errors that are completed
asynchronously through the test's future.

## 0.2.10

- Updated documentation.

## 0.2.9

- Renamed the `@Group()` annotation to `@TestGroup()` to disambiguate.
- Added support for `@ExpectThrows()` on asynchronous test functions.
- Removed the snapshot and replaced it with the `lib/main.dart` script; the
trouble with the snapshot was that every time a new Dart SDK release was being
pushed the snapshot would be corrupt, so packages relying on it to perform
continuous integration tests (on drone.io, for example) would _fail_ when the
new SDK release was pushed.  I don't see a good solution in the short-term so it
is best to use a dart script.  The `tool/make_snapshot.dart` script remains for
those interested in generating a snapshot on their own.

## 0.2.8

- Updated to SDK 0.6.21_r26639.

## 0.2.7

- Merged all library code into a single `bench.dart` library for users to 
import.  The `main()` function was renamed to `reflectTests()` to better reflect
what it does, and to free up `main()` for future work.  
- Renamed the snapshot from `runner` to `bench`.

## 0.2.6

- Add a very primitive test runner for running headless browser tests via
`content_shell --dump-render-tree`.  The snapshot is in the `lib/` directory for
now so that it is visible to applications that list `bench` as a dependency.  It
can be used from such an application's root directory in the following manner:

    `dart packages/bench/runner test/my_browser_harness.html`

## 0.2.5

- Fixed an issue regarding `Setup` / `Teardown` / `Test` mirrored invocations 
that return `Future`; the returned future is now passed correctly to the 
`unittest` library functions.

## 0.2.4

- Added support for `@Group()` in the test runner.

## 0.2.3

- Added support for `@Setup` and `@Teardown` invocation in the test runner.
- Use each test library's `qualifiedName` as the default group name when none
is specified with `@Group(description)`; currently `@Group()` annotations are 
ignored because support for reflection of metadata on library declarations is 
not yet implemented.

## 0.2.2

- Added `@ExpectThrows()` annotation which takes an optional `Matcher` from the
`unittest` package.  The default matcher is `anything`.

## 0.2.1

- Added an `example/browser.html` to demonstrate usage with html configuration.
- Workaround the lack of library declaration metadata reflection (@Group) by
setting a single top-level group named '*'; the html configuration renderer
will only render tests in groups.

## 0.2.0

- Repurposed this package to provide metadata and a reflective test runner for
Dart's `unittest` package.  For benchmarks, please use the `benchmark_harness`
package.  We may enhance this package to provide support for the 
`benchmark_harness` in the future, if there is demand.

## 0.1.4

- Updated to SDK 0.5.1_r22072.

## 0.1.3

- Updated to SDK 0.5.0_r21823.

## 0.1.2

- Updated to SDK 0.4.7_r21548.

## 0.1.1

- Refactored a large portion of the async code to simplify things thanks to the
lib_v2 changes; Completers are no longer used unless necessary.

## 0.1.0

- Updated to SDK 0.4.2_r20259.

## 0.0.10

- Updated to SDK 0.3.7_r18717.

## 0.0.9

- Updates for the lib v2 SDK (0.3.1_r17328). 

## 0.0.8

- Better dependency version constraints.
- Removed function literal from example that was causing error in latest SDK.

## 0.0.7

- Updated the pubspec dependencies (logging and unittest are now on pub)

## 0.0.6

- Ramped up the documentation and added link to blog article.
- Libraries and their benchmarks are now sorted alphabetically to provide
consistent run results.
