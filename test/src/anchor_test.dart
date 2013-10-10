@TestGroup(description: 'Anchor', runs: IMPLEMENTATIONS)
library ace.test.anchor;

import 'package:ace/ace.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

Anchor anchor;
Document document;
bool useExperimental;
@Setup
setup(TestRun run) {
  document = new Document(text: sampleText, useExperimental: run.id == PURE);
  anchor = new Anchor(document, 0, 0, useExperimental: run.id == PURE);
  useExperimental = run.id == PURE;
}

@Test()
void testAnchorCtor() {
  final Anchor anchor = 
      new Anchor(document, 0, 0, useExperimental: useExperimental);
  expect(anchor, isNotNull);
  expect(anchor.position, equals(const Point(0, 0)));
  expect(anchor.document.value, equals(document.value));
}

@Test()
void testAnchorDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  anchor.onChange.listen(noop1, onDone: expectAsync0(noop0));
  anchor.dispose();
}

@Test()
void testAnchorSetPosition() {
  anchor.onChange.listen((AnchorChangeEvent ev) {
    expect(ev.oldPosition, equals(const Point(0, 0)));
    expect(ev.newPosition, equals(const Point(2, 14)));
  });
  anchor.setPosition(2, 14, clip: false);
}
