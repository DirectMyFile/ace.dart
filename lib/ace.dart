library ace;

import 'dart:async';
import 'dart:html' as html;
import 'dart:json' as json;
import 'package:js/js.dart' as js;
import 'package:mime/mime.dart';

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
part 'src/undo_manager.dart';
part 'src/virtual_renderer.dart';

/// Creates a new [EditSession] with the given [text] and language [mode].
EditSession createEditSession(String text, Mode mode) {
  assert(text != null);
  assert(mode != null);
  return new EditSession._( _context.ace.createEditSession(text, mode._mode));
}

/// Embed an Ace [Editor] instance into the DOM, at the given [element].
Editor edit(html.Element element) {
  assert(element != null);
  return new Editor._(_context.ace.edit(element));
}
