library ace.example.autocomplete;

import 'dart:html';
import 'package:ace/ace.dart' as ace;

main() {
  ace.require('ace/ext/language_tools');
  var editor = ace.edit(querySelector('#editor'))
  ..theme = new ace.Theme.named(ace.Theme.TOMORROW)
  ..session.mode = new ace.Mode('ace/mode/html')
  ..setOptions({
    'enableBasicAutocompletion' : true,
    'enableSnippets' : true
  });  
}
