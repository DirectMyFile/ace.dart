library ace.pure;

import 'dart:async';
import 'dart:html' as html;
import 'dart:math' as math;
import 'ace.dart';

part 'src/pure/_.dart';
part 'src/pure/anchor.dart';
part 'src/pure/command.dart';
part 'src/pure/command_manager.dart';
part 'src/pure/document.dart';

/// An implementation written in pure Dart.
const Implementation ACE_PURE_IMPLEMENTATION = const _PureImplementation();

class _PureImplementation extends Implementation {
  
  const _PureImplementation();
  
  Anchor createAnchor(Document document, int row, int column) {
    assert(document is _Document);
    return new _Anchor(document, row, column);
  }
  
  AutoCompleter createAutoCompleter(Future<List<Completion>> getCompletions(
      Editor editor, EditSession session, Point position, String prefix)) =>
      throw new UnimplementedError();
  
  Command createCommand(String name, BindKey bindKey, exec(Editor), 
      {bool readOnly: false, String scrollIntoView, String multiSelectAction}) 
      => new _Command(name, bindKey, exec, readOnly: readOnly, 
          scrollIntoView: scrollIntoView, multiSelectAction: multiSelectAction);
     
  CommandManager createCommandManager(String platform, 
      Iterable<Command> commands) => new _CommandManager(platform, commands);
  
  Document createDocument(String text) => new _Document(text);
  
  Editor createEditor(VirtualRenderer renderer, EditSession session) =>
      throw new UnimplementedError();
  
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
