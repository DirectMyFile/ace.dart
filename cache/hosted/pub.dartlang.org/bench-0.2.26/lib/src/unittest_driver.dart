part of bench;

class UnittestDriver extends TestDriver {
  
  final List<TestGroup> _groups = new List<TestGroup>();
  
  void add(TestGroup testGroup) => _groups.add(testGroup);
  
  void run(Duration timeout) {    
    unittestConfiguration.timeout = timeout;    
    for (TestGroup testGroup in _groups) {
      for (TestRun testRun in testGroup.testRuns) {
        var description = testGroup.description;
        if (testRun.id != '') {
          description += '[${testRun.id}]';
        }
        group(description, () {        
          if (testGroup.setup != null) {
            _setup(testGroup.owner, testGroup.setup, testRun);
          }
          if (testGroup.teardown != null) {
            _teardown(testGroup.owner, testGroup.teardown, testRun);
          }
          for (Test test in testGroup.tests) {
            if (test.skip != null) {
              _logger.info('Skipping ${test.description} due to ${test.skip}');
              continue;
            }
            _test(testGroup.owner, test.test, test.description, 
                test.expectError);  
          }
        });
      }
    }
  }
  
  void _setup(ObjectMirror owner, MethodMirror setupFunction, TestRun testRun) {
    assert(owner != null);
    assert(setupFunction != null);
    assert(testRun != null);
    final setupArgs = [];
    if (setupFunction.parameters.length == 1) {
      setupArgs.add(testRun);
    }                  
    _logger.finer('Invoking setup: ${setupFunction.simpleName}');          
    setUp(() => owner.invoke(setupFunction.simpleName, setupArgs).reflectee);
  }
  
  void _teardown(ObjectMirror owner, 
                 MethodMirror teardownFunction, 
                 TestRun testRun) {    
    assert(owner != null);
    assert(teardownFunction != null);
    assert(testRun != null);
    final teardownArgs = [];   
    if (teardownFunction.parameters.length == 1) {
      teardownArgs.add(testRun);
    }
    _logger.finer('Invoking teardown: ${teardownFunction.simpleName}');          
    tearDown(() => 
        owner.invoke(teardownFunction.simpleName, teardownArgs).reflectee);
  }
  
  void _test(ObjectMirror owner, 
             MethodMirror testFunction, 
             String description,
             ExpectError expectError) {
    test(description, () {
      if (expectError != null) {              
        try {
          final result = owner.invoke(testFunction.simpleName, []).reflectee;
          if (result is Future) {
            final completer = new Completer();
            result
            .then((_) {
              try {
                fail('Expected error.');
              } catch(e) {
                completer.completeError(e);
              }
            })
            ..catchError((e) {
              try {
                expect(e, expectError.matcher);
                completer.complete();
              } catch(e) {
                completer.completeError(e);
              }
            });
            return completer.future;
          }                
          fail('Expected error.');
        } catch(e) {                
          expect(e, expectError.matcher);
        }
      } else {
        return owner.invoke(testFunction.simpleName, []).reflectee;
      }
    });
  }
}
