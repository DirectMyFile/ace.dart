library ace.example.basic;

import 'dart:html';
import 'package:ace/ace.dart' as ace;

main() {
  var editor = ace.edit(query('#editor'))
      ..theme = new ace.Theme("ace/theme/monokai")
      ..session.mode = new ace.Mode("ace/mode/dart");
}
