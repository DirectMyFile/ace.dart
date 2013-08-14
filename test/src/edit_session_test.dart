@Group('EditSession')
library ace.test.edit_session;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

@Test()
void testCreateEditSession() {  
  final EditSession session = createEditSession(sampleText, 'ace/mode/dart');
  expect(session, isNotNull); 
  expect(session.value, equals(sampleText));
}

@Test()
void testGetDocument() {
  final EditSession session = createEditSession(sampleText, 'ace/mode/dart');
  var document = session.document;
  expect(document, const isInstanceOf<Document>());
  expect(document.value, equals(sampleText));
}