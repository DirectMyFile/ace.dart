@Group('EditSession')
library ace.test.edit_session;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

EditSession session;
@Setup
setup() => session = new EditSession(new Document(sampleText), 'ace/mode/text');

@Test()
void testEditSessionCtor() {
  expect(session, isNotNull);
  expect(session.value, equals(sampleText));  
}

@Test()
void testCreateEditSession() {  
  session = createEditSession(sampleText, 'ace/mode/dart');
  expect(session, isNotNull); 
  expect(session.value, equals(sampleText));
}

@Test()
void testDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  expect(session.isDisposed, isFalse);
  session.onChangeTabSize.listen(noop1, onDone: expectAsync0(noop0));
  session.dispose();
  expect(session.isDisposed, isTrue);
}

@Test()
void testGetDocument() {
  var document = session.document;
  expect(document, const isInstanceOf<Document>());
  expect(document.value, equals(sampleText));
}

@Test()
void testValue() {
  final text = 'do re me fa so la ti do';
  session.value = text;
  expect(session.value, equals(text));
  expect(session.document.value, equals(text));
  session.document.value = sampleText;
  expect(session.value, equals(sampleText));
}

@Test()
void testSetTabSize() {
  session.onChangeTabSize.listen(expectAsync1((_) {    
    expect(session.tabSize, equals(7));    
  }));
  session.tabSize = 7;
}
