library ace.example.basic;

import 'dart:html';
import 'package:ace/ace.dart' as ace;

main() {
  var editor = ace.edit(query('#editor'))
      ..theme = "ace/theme/monokai"
      ..session.setMode("ace/mode/dart");
}
