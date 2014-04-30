library bench.test.mock;

import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

main() {
  group('mock', () {
    setUp(() {
      uut = new Mock<Stuff>();
    });
    test('testInstanceGetter', testInstanceGetter);
    test('testInstanceSetter', testInstanceSetter);
    test('testInstanceMethod', testInstanceMethod);
  });
}

abstract class Stuff {
  bool 
    get b;
    set b(bool v);
  int m(String v);
}

var uut;

void testInstanceGetter() {
  uut.getters[#b] = () => true;
  expect(uut.b, isTrue);
  expect(uut.calls(#b), once);
}

void testInstanceSetter() {
  uut.setters[const Symbol('b=')] = (v) => expect(v, equals(false));
  uut.b = false;
  expect(uut.calls(const Symbol('b=')), once);
}

void testInstanceMethod() {
  uut.methods[#m] = (pos, _) => int.parse(pos[0]);
  expect(uut.m('42'), equals(42));
  expect(uut.calls(#m), once);
}
