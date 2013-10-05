library ace;

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:math' as math;
import 'package:js/js.dart' as js;

part 'src/_.dart';
part 'src/anchor.dart';
part 'src/delta.dart';
part 'src/document.dart';
part 'src/editor.dart';
part 'src/edit_session.dart';
part 'src/mode.dart';
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
part 'src/proxy/mode.dart';
part 'src/proxy/search.dart';
part 'src/proxy/selection.dart';
part 'src/proxy/theme.dart';
part 'src/proxy/undo_manager.dart';
part 'src/proxy/virtual_renderer.dart';
part 'src/vm/document.dart';

/// Creates a new [EditSession] with the given [text] and language [mode].
EditSession createEditSession(String text, Mode mode) {
  assert(text != null);
  assert(mode != null);
  assert(mode is _ModeProxy);
  return new EditSession._( _context.ace.createEditSession(text, 
      (mode as _ModeProxy)._mode));
}

/// Embed an Ace [Editor] instance into the DOM, at the given [element].
Editor edit(html.Element element) {
  assert(element != null);
  return new Editor._(_context.ace.edit(element));
}
