library ace;

import 'dart:async';
import 'dart:html' as html;
import 'package:js/js.dart' as js;

part 'src/_.dart';
part 'src/anchor.dart';
part 'src/delta.dart';
part 'src/document.dart';
part 'src/editor.dart';
part 'src/edit_session.dart';
part 'src/point.dart';
part 'src/range.dart';
part 'src/search.dart';
part 'src/selection.dart';
part 'src/virtual_renderer.dart';

/// Creates a new [EditSession] and returns the associated [Document].
/// 
/// A new [Document] is created with the given [text] and language [mode].
Document createEditSession(String text, String mode) {
  assert(text != null);
  assert(mode != null);
  return new Document._( _context.ace.createEditSession(text, mode));
}

/// Embed an Ace [Editor] instance into the DOM, at the given [element].
Editor edit(html.Element element) {
  assert(element != null);
  return new Editor._(_context.ace.edit(element));
}
