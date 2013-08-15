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
  session.onChangeWrapLimit.listen(noop1, onDone: expectAsync0(noop0));
  session.onChangeWrapMode.listen(noop1, onDone: expectAsync0(noop0));
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
void testGetLength() {
  expect(session.length, equals(6));
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

@Test()
void testUseSoftTabs() {
  session.useSoftTabs = true;
  session.tabSize = 5;
  expect(session.useSoftTabs, isTrue);
  expect(session.tabString, equals('     '));
  session.useSoftTabs = false;
  expect(session.useSoftTabs, isFalse);
  expect(session.tabString, equals('\t'));
}

@Test()
void testUseWrapMode() {
  session.onChangeWrapMode.listen(expectAsync1((_){}, count: 2));
  session.useWrapMode = true;
  expect(session.useWrapMode, isTrue);
  session.useWrapMode = true; // Should not fire an event.
  expect(session.useWrapMode, isTrue);
  session.useWrapMode = false;
  expect(session.useWrapMode, isFalse);
}

@Test()
void testSetWrapLimitRange() {
  session.onChangeWrapMode.listen(expectAsync1((_) {    
    expect(session.wrapLimitRange['min'], equals(63));
    expect(session.wrapLimitRange['max'], equals(65));
  }));
  session.setWrapLimitRange(min: 63, max: 65);
}

@Test()
void testSetWrapLimitRangeMin() {
  session.onChangeWrapMode.listen(expectAsync1((_) {    
    expect(session.wrapLimitRange['min'], equals(63));
    expect(session.wrapLimitRange['max'], equals(null));
  }));
  session.setWrapLimitRange(min: 63);
}

@Test()
void testSetWrapLimitRangeMax() {
  session.onChangeWrapMode.listen(expectAsync1((_) {    
    expect(session.wrapLimitRange['min'], equals(null));
    expect(session.wrapLimitRange['max'], equals(65));
  }));
  session.setWrapLimitRange(max: 65);
}

@Test()
void testAdjustWrapLimit() {
  session.useWrapMode = true;
  session.setWrapLimitRange(min: 63, max: 65);  
  session.onChangeWrapLimit.listen(expectAsync1((_) {    
    expect(session.wrapLimit, equals(64));
  }));  
  expect(session.adjustWrapLimit(64, 80), isTrue);
  expect(session.wrapLimit, equals(64));
}
