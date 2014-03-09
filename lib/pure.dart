library ace.pure;

import 'dart:async';
import 'dart:math' as math;
import 'ace.dart';

part 'src/pure/_.dart';
part 'src/pure/anchor.dart';
part 'src/pure/document.dart';

const Implementation ACE_PURE_IMPLEMENTATION = const _PureImplementation();

class _PureImplementation extends Implementation {
  
  const _PureImplementation();
  
  Anchor createAnchor(Document document, int row, int column) {
    assert(document is _Document);
    return new _Anchor(document, row, column);
  }
  
  Command createCommand(String name, BindKey bindKey, exec(Editor), 
      {bool readOnly: false, String scrollIntoView, String multiSelectAction}) 
      => throw new UnimplementedError();
     
  CommandManager createCommandManager({String platform, 
      Iterable<Command> commands}) => throw new UnimplementedError();
  
  Document createDocument(String text) => new _Document(text);
  
  EditSession createEditSession(String text, Mode mode) => 
      throw new UnimplementedError();
  
  EditSession createEditSessionFromDocument(Document document, Mode mode) =>
      throw new UnimplementedError();
  
  Fold createFold(Range range, Placeholder placeholder) =>
      throw new UnimplementedError();
  
  KeyboardHandler createKeyboardHandler(String path) => 
      throw new UnimplementedError();
  
  Mode createMode(String path) => throw new UnimplementedError();
  
  Placeholder createPlaceholder(
      EditSession session, 
      int length, 
      Point position,
      Iterable<Point> others,
      String mainClass,
      String othersClass) => throw new UnimplementedError();
  
  RangeList createRangeList() => throw new UnimplementedError();
  
  Search createSearch() => throw new UnimplementedError();
  
  Selection createSelection(EditSession session) => 
      throw new UnimplementedError();
  
  Theme createTheme(String path) => throw new UnimplementedError();
  
  VirtualRenderer createVirtualRenderer(container, Theme theme) => 
      throw new UnimplementedError();
  
  Editor edit(element) => throw new UnimplementedError();
  
  require(String modulePath) => throw new UnimplementedError();
}
