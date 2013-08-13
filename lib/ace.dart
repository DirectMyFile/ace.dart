library ace;

import 'dart:async';
import 'dart:html' as html;
import 'package:js/js.dart' as js;

part 'src/anchor.dart';
part 'src/delta.dart';
part 'src/document.dart';
part 'src/editor.dart';
part 'src/edit_session.dart';
part 'src/point.dart';
part 'src/range.dart';
part 'src/search.dart';
part 'src/selection.dart';

// TODO(rms): recommend that the js package return `dynamic` to avoid warnings.
get _context => js.context as dynamic;

Editor edit(html.Element element) {
  assert(element != null);
  return new Editor._(_context.ace.edit(element));
}
