part of bench;

/// An annotation that declares an expectation that a [Test] function will
/// throw an error or complete an async error.
/// 
/// There can be only one [ExpectError] annotation per [Test] function.
class ExpectError {
  
  /// An optional [unit.Matcher] for this expectation.
  /// 
  /// The default value of this matcher will be [unit.anything] unless specified
  /// otherwise.
  final Matcher matcher;
  
  /// Create a constant error expectation with the given [matcher].
  const ExpectError([this.matcher = anything]);
}

/// An annotation that declares a top-level function to be a setup procedure.
/// 
/// There can be only one [Setup] function per library.  The setup function will
/// be called one time before each [Test] function in the library is called.
const Setup = const _Setup();
class _Setup {
  const _Setup();
}

/// An annotation that declares a top-level function to be a teardown procedure.
/// 
/// There can be only one [Teardown] function per library.  The teardown
/// function will be called one time after each [Test] function in the library
/// is completed.
const Teardown = const _Teardown();
class _Teardown {
  const _Teardown();
}

/// An annotation that declares a top-level function to be a test case.
class Test {
  
  /// An optional description for this test.
  /// 
  /// If the default value `''` is set then the qualified name of the annotated 
  /// function will be used in generated output; else the given description will
  /// be used.
  final String description;
  
  /// An optional reason to skip this test.
  ///
  /// If a non-null value is given, this test shall be skipped by a [TestDriver]
  /// and the given string may be used in test run summary information.
  final String skip;
  
  /// Create a constant test annotation with the given optional [description].
  const Test([this.description = '', this.skip]) 
  : this.test = null
  , this.expectError = null;
  
  Test._(this.description, this.skip, this.test, this.expectError);
  
  final MethodMirror test;
  
  final ExpectError expectError;
}

/// An annotation that declares a library to contain a group of [Test] 
/// functions.
/// 
/// This annotation is optional.  Any library that contains one or more [Test]
/// function will be reflected even if this annotation is absent.  However, this
/// annotation allows for the customization of the test group's [description]
/// and provides an explicit cue that the library contains tests.
class TestGroup {
  
  /// An optional description for this test group.
  /// 
  /// If the default value `''` is set then the qualified name of the library
  /// will be used in generated output; else the given description will be used.
  final String description;
  
  /// An optional list of test run identifiers.
  /// 
  /// By default this will be a list with a single element `''`.  Specify a 
  /// list of identifiers to declare multiple runs of this test group.
  final List<String> runs;
  
  /// Create a constant test group annotation with the given [description] and
  /// list of test [runs].
  const TestGroup({this.description: '', this.runs: const ['']})
      : this.owner = null
      , this.setup = null
      , this.teardown = null      
      , this.tests = null
      , this.testRuns = null;
      
  TestGroup._(
      this.description, 
      this.runs, 
      this.owner, 
      this.setup, 
      this.teardown, 
      this.tests, 
      this.testRuns);

  final ObjectMirror owner;
  final MethodMirror setup;
  final MethodMirror teardown;
  final List<Test> tests;
  final List<TestRun> testRuns;
}

/// The context of a single run of a [TestGroup].
/// 
/// A new instance of this class is created internally for each run in
/// [TestGroup.runs] and passed as the 1 argument to a [Setup] or [Teardown]
/// function in the [TestGroup] which declares 1 parameter of this type.
class TestRun {
  
  /// The number of times a [TestGroup] has been run thus far.
  final int count;
  
  /// An identifier for this test run.
  final String id;
  
  const TestRun._(this.count, this.id);
}
