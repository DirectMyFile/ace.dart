library ace;

import 'dart:async';
import 'package:js/js.dart' as js;

part 'src/anchor.dart';
part 'src/delta.dart';
part 'src/document.dart';
part 'src/editor.dart';
part 'src/edit_session.dart';
part 'src/range.dart';
part 'src/search.dart';

Editor edit(String elementId) => new Editor._(js.context.ace.edit(elementId));
