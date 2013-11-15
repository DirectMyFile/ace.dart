library ace;

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:math' as math;

part 'src/_.dart';
part 'src/anchor.dart';
part 'src/delta.dart';
part 'src/document.dart';
part 'src/editor.dart';
part 'src/edit_session.dart';
part 'src/keyboard_handler.dart';
part 'src/key_binding.dart';
part 'src/mode.dart';
part 'src/options_provider.dart';
part 'src/point.dart';
part 'src/range.dart';
part 'src/search.dart';
part 'src/selection.dart';
part 'src/text_input.dart';
part 'src/theme.dart';
part 'src/undo_manager.dart';
part 'src/virtual_renderer.dart';
part 'src/proxy/anchor.dart';
part 'src/proxy/document.dart';
part 'src/proxy/editor.dart';
part 'src/proxy/edit_session.dart';
part 'src/proxy/keyboard_handler.dart';
part 'src/proxy/key_binding.dart';
part 'src/proxy/mode.dart';
part 'src/proxy/search.dart';
part 'src/proxy/selection.dart';
part 'src/proxy/text_input.dart';
part 'src/proxy/theme.dart';
part 'src/proxy/undo_manager.dart';
part 'src/proxy/virtual_renderer.dart';
part 'src/pure/anchor.dart';
part 'src/pure/document.dart';

/// Creates a new [EditSession] with the given [text] and language [mode].
EditSession createEditSession(String text, Mode mode) {
  assert(text != null);
  assert(mode != null);
  assert(mode is _ModeProxy);
  return new _EditSessionProxy._(
      _ace.callMethod('createEditSession', [text, (mode as _ModeProxy)._mode]));
}

/// Embed an Ace [Editor] instance into the DOM, at the given [element].
Editor edit(html.Element element) {
  assert(element != null);
  return new _EditorProxy._(_ace.callMethod('edit', [element]));
}

/// Loads the module for the given [modulePath].
/// 
/// The [modulePath] is a path such as `ace/ext/language_tools`.
require(String modulePath) { 
  return _ace.callMethod('require', [modulePath]);
}