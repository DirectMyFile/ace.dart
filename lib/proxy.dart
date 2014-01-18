library ace.proxy;

import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;
import 'ace.dart';

part 'src/proxy/_.dart';
part 'src/proxy/anchor.dart';
part 'src/proxy/document.dart';
part 'src/proxy/editor.dart';
part 'src/proxy/edit_session.dart';
part 'src/proxy/fold.dart';
part 'src/proxy/keyboard_handler.dart';
part 'src/proxy/key_binding.dart';
part 'src/proxy/mode.dart';
part 'src/proxy/placeholder.dart';
part 'src/proxy/range_list.dart';
part 'src/proxy/search.dart';
part 'src/proxy/selection.dart';
part 'src/proxy/text_input.dart';
part 'src/proxy/theme.dart';
part 'src/proxy/undo_manager.dart';
part 'src/proxy/virtual_renderer.dart';

/// An implementation that uses `dart:js` to proxy calls to `ace.js`.
const Implementation ACE_PROXY_IMPLEMENTATION = const _ProxyImplementation();

class _ProxyImplementation extends Implementation {
  
  const _ProxyImplementation();
  
  Anchor createAnchor(Document document, int row, int column) {
    assert(document is _DocumentProxy);
    return new _AnchorProxy(document, row, column);
  }
  
  Document createDocument(String text) => new _DocumentProxy(text);
  
  EditSession createEditSession(String text, Mode mode) {
    assert(mode is _ModeProxy);
    return new _EditSessionProxy._(_ace.callMethod('createEditSession', 
        [text, (mode as _ModeProxy)._mode]));
  }
  
  EditSession createEditSessionFromDocument(Document document, Mode mode) {
    assert(document is _DocumentProxy);
    assert(mode is _ModeProxy);
    return new _EditSessionProxy(document, mode);
  }
  
  Fold createFold(Range range, Placeholder placeholder) {
    assert(placeholder is _PlaceholderProxy);
    return new _FoldProxy(range, placeholder);
  }
  
  KeyboardHandler createKeyboardHandler(String path) {
    if (path == KeyboardHandler.DEFAULT) {
      return new _KeyboardHandlerProxy._(KeyboardHandler.DEFAULT);
    } else {
      return new _KeyboardHandlerProxy(path);
    }
  }
  
  Mode createMode(String path) => new _ModeProxy(path);
  
  Placeholder createPlaceholder(
      EditSession session, 
      int length, 
      Point position,
      Iterable<Point> others,
      String mainClass,
      String othersClass) {
    assert(session is _EditSessionProxy);
    return new _PlaceholderProxy(
      session, length, position, others, mainClass, othersClass);
  }
  
  RangeList createRangeList() => new _RangeListProxy();
  
  Search createSearch() => new _SearchProxy();
  
  Selection createSelection(EditSession session) {
    assert(session is _EditSessionProxy);
    return new _SelectionProxy(session);
  }
  
  Theme createTheme(String path) => new _ThemeProxy(path);
  
  VirtualRenderer createVirtualRenderer(container, Theme theme) {
    assert(theme is _ThemeProxy);
    return new _VirtualRendererProxy(container, theme);
  }
  
  Editor edit(element) => 
      new _EditorProxy._(_ace.callMethod('edit', [element]));
  
  require(String modulePath) { 
    return _ace.callMethod('require', [modulePath]);
  }
}
