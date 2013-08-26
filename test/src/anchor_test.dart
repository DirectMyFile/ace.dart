@Group('Anchor')
library ace.test.anchor;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

Anchor anchor;
Document document;

@Setup
setup() {
  document = new Document(sampleText);
  anchor = new Anchor(document, 0, 0); 
}

@Test()
void testAnchorCtor() {
  final Anchor anchor = new Anchor(document, 0, 0);
  expect(anchor, isNotNull);
  expect(anchor.position, equals(new Point(0, 0)));
  expect(anchor.document.value, equals(document.value));
}

@Test()
void testAnchorDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  expect(anchor.hasProxy, isTrue);
  anchor.onChange.listen(noop1, onDone: expectAsync0(noop0));
  anchor.dispose();
  expect(anchor.hasProxy, isFalse);
}

@Test()
void testAnchorSetPosition() {
  anchor.onChange.listen((AnchorChangeEvent ev) {
    expect(ev.oldPosition, equals(new Point(0, 0)));
    expect(ev.newPosition, equals(new Point(2, 14)));
  });
  anchor.setPosition(2, 14, true);
}
