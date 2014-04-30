library bench.mock.mirrors;

import 'dart:mirrors';
import 'bench.dart';

class MockClassMirror extends Mock<ClassMirror> 
    implements ClassMirror {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockDeclarationMirror extends Mock<DeclarationMirror> 
    implements DeclarationMirror {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockInstanceMirror extends Mock<InstanceMirror>
    implements InstanceMirror {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockLibraryMirror extends Mock<LibraryMirror>
    implements LibraryMirror {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockMethodMirror extends Mock<MethodMirror> 
    implements MethodMirror {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockMirrorSystem extends Mock<MirrorSystem> 
    implements MirrorSystem {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockTypeMirror extends Mock<TypeMirror>
    implements TypeMirror {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
