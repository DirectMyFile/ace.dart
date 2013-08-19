@Group('Selection')
library ace.test.selection;

import 'package:ace/ace.dart';
import 'package:bench/meta.dart';
import 'package:unittest/unittest.dart';
import 'sample_text.dart';

EditSession session;
Selection selection;

@Setup
setup() {
  session = new EditSession(new Document(sampleText), 'ace/mode/text');
  selection = new Selection(session);
}

@Test()
void testSelectionCtor() {
  final Selection selection = new Selection(session);
  expect(selection, isNotNull);
  expect(selection.cursor, equals(new Point(0, 0)));
  expect(selection.isEmpty, isTrue);
  expect(selection.isMultiLine, isFalse);
}

@Test()
void testDispose() {
  final noop0 = (){};
  final noop1 = (_){};
  expect(selection.isDisposed, isFalse);
  selection.onChangeCursor.listen(noop1, onDone: expectAsync0(noop0));
  selection.onChangeSelection.listen(noop1, onDone: expectAsync0(noop0));
  selection.dispose();
  expect(selection.isDisposed, isTrue);
}
