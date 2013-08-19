@Group('Anchor')
library ace.test.anchor;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

@Test()
void testAnchorCtor() {
  final Document doc = new Document(sampleText);
  final Anchor anchor = new Anchor(doc, 0, 0);
  expect(anchor, isNotNull);
  expect(anchor.position, equals(new Point(0, 0)));
  expect(anchor.document.value, equals(doc.value));
}
