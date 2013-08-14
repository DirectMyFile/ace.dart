@Group('Document')
library ace.test.document;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';

final String sampleText =
'''
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu 
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in 
culpa qui officia deserunt mollit anim id est laborum.
''';

Document document;
// TODO(rms): figure out how to invoke the js `new Document(text)` ctor...
@Setup
setup() => document = createEditSession(sampleText, 'ace/mode/dart').document;

@Test()
void testGetLength() {
  expect(document.length, equals(7));
}

@Test()
void testGetAllLines() {
  final lines = document.allLines;
  expect(lines.length, equals(7));
  expect(lines[0], equals('Lorem ipsum dolor sit amet, consectetur '
                          'adipisicing elit, sed do eiusmod tempor'));
  expect(lines[1], equals('incididunt ut labore et dolore magna aliqua. Ut '
                          'enim ad minim veniam, quis'));
  expect(lines[2], equals('nostrud exercitation ullamco laboris nisi ut '
                          'aliquip ex ea commodo consequat. '));
  expect(lines[3], equals('Duis aute irure dolor in reprehenderit in '
                          'voluptate velit esse cillum dolore eu '));
  expect(lines[4], equals('fugiat nulla pariatur. Excepteur sint occaecat '
                          'cupidatat non proident, sunt in '));
  expect(lines[5], equals('culpa qui officia deserunt mollit anim id est '
                          'laborum.'));
  expect(lines[6], equals(''));
}

@Test()
void testGetLine() {
  expect(document.getLine(0), 
      equals('Lorem ipsum dolor sit amet, consectetur '
             'adipisicing elit, sed do eiusmod tempor'));
  expect(document.getLine(1), 
      equals('incididunt ut labore et dolore magna aliqua. Ut '
             'enim ad minim veniam, quis'));
  expect(document.getLine(2), 
      equals('nostrud exercitation ullamco laboris nisi ut '
             'aliquip ex ea commodo consequat. '));
  expect(document.getLine(3), 
      equals('Duis aute irure dolor in reprehenderit in '
             'voluptate velit esse cillum dolore eu '));
  expect(document.getLine(4), 
      equals('fugiat nulla pariatur. Excepteur sint occaecat '
             'cupidatat non proident, sunt in '));
  expect(document.getLine(5), 
      equals('culpa qui officia deserunt mollit anim id est laborum.'));
  expect(document.getLine(6), equals(''));
}
