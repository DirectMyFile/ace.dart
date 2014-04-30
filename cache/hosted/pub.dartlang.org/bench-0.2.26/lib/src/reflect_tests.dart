part of bench;

void reflectTests({
  Duration timeout: const Duration(seconds: 30),
  MirrorSystem mirrorSystem,
  TestDriver testDriver}) {
  
  if (mirrorSystem == null) mirrorSystem = currentMirrorSystem();
  if (testDriver == null) testDriver = new UnittestDriver();
  
  mirrorSystem.libraries.values.forEach((LibraryMirror libraryMirror) {    
    _logger.fine('Scanning library ${libraryMirror.qualifiedName}');
    
    final isGroup = (instance) => instance.reflectee is TestGroup;
    final isTest = (instance) => instance.reflectee is Test;
    final isSetup = (instance) => instance.reflectee == Setup;
    final isTeardown = (instance) => instance.reflectee == Teardown;
    final isExpectError = (instance) => instance.reflectee is ExpectError;
    
    final topLevelFunctions = 
        libraryMirror.declarations.values.where((DeclarationMirror mirror) =>
            mirror is MethodMirror && mirror.isTopLevel);
    
    final testFunctions = 
        topLevelFunctions.where((MethodMirror mirror) => 
            mirror.metadata.any(isTest));
    
    _logger.fine('Found ${testFunctions.length} test functions');
        
    final setupFunctions = 
        topLevelFunctions.where((MethodMirror mirror) =>
            mirror.metadata.any(isSetup));
    
    MethodMirror setupFunction;
    if (setupFunctions.length > 1) {
      throw new UnsupportedError(
          '${libraryMirror.qualifiedName} cannot declare >1 @Setup function.');
    } else if (setupFunctions.isNotEmpty) {
      // TODO(rms): validate the function has 0 or 1 parameter (of type TestRun)
      setupFunction = setupFunctions.single;
    }
    
    final teardownFunctions = 
        topLevelFunctions.where((MethodMirror mirror) =>
            mirror.metadata.any(isTeardown));

    MethodMirror teardownFunction;
    if (teardownFunctions.length > 1) {
      throw new UnsupportedError('${libraryMirror.qualifiedName}'
                                 ' cannot declare >1 @Teardown function.');
    } else if (teardownFunctions.isNotEmpty) {
      // TODO(rms): validate the function has 0 or 1 parameter (of type TestRun)
      teardownFunction = teardownFunctions.single;
    }
    
    if (testFunctions.isNotEmpty) {
                  
      final groups = libraryMirror.metadata
          .where(isGroup)
          .map((instance) => instance.reflectee);
      
      if (groups.length > 1)
        throw new UnsupportedError(
            '${libraryMirror.qualifiedName} cannot declare >1 @Group.');
      
      var groupDescription = '';
      var groupRuns = [''];
      
      if (groups.isNotEmpty) {
        final group = groups.single;
        groupDescription = group.description;
        groupRuns = group.runs;
      }
      
      if (groupDescription == '') {
        groupDescription = MirrorSystem.getName(libraryMirror.qualifiedName);
      }
      
      final tests = new List<Test>();      
      for (MethodMirror testFunction in testFunctions) {
        Test testAnnotation = 
            testFunction.metadata.singleWhere(isTest).reflectee;
        
        if (testFunction.parameters.isNotEmpty) {
          throw new UnsupportedError(
              '${testFunction.qualifiedName} cannot declare parameters.');
        }
        
        ExpectError expectError;
        if (testFunction.metadata.any(isExpectError)) {
          expectError = 
              testFunction.metadata.singleWhere(isExpectError).reflectee;
        }
        
        final description = (testAnnotation.description == '') 
            ? MirrorSystem.getName(testFunction.simpleName)
                : testAnnotation.description;
        
        tests.add(new Test._(
          description, 
          testAnnotation.skip,
          testFunction, 
          expectError));
      }
      
      final testRuns = new List<TestRun>();
      for (int i = 0; i < groupRuns.length; i++) {
        testRuns.add(new TestRun._(i, groupRuns[i]));
      }

      testDriver.add(new TestGroup._(
          groupDescription,
          groupRuns,
          libraryMirror,
          setupFunction,
          teardownFunction,
          tests,
          testRuns));
    }
  });
  
  testDriver.run(timeout);
}
