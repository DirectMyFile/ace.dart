library ace.example.basic;

import 'dart:html';
import 'package:ace/ace.dart' as ace;

main() {
  var editor = ace.edit(query('#editor'));
  editor.theme = "ace/theme/monokai";
  editor.session.setMode("ace/mode/dart");
}
