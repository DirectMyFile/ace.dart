library ace.test.anchor;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

Anchor anchor;
Document document;

setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;
  document = new Document(text: sampleText);
  anchor = new Anchor(document, 0, 0);
}

void testAnchorCtor() {
  final Anchor anchor = 
      new Anchor(document, 0, 0);
  expect(anchor, isNotNull);
  expect(anchor.position, equals(const Point(0, 0)));
  expect(anchor.document.value, equals(document.value));
}

void testAnchorSetPosition() {
  anchor.onChange.listen((AnchorChangeEvent ev) {
    expect(ev.oldPosition, equals(const Point(0, 0)));
    expect(ev.newPosition, equals(const Point(2, 14)));
  });
  anchor.setPosition(2, 14, clip: false);
}
