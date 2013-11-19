library ace.example.keybindings;

import 'dart:html';
import 'package:ace/ace.dart' as ace;

main() {
  var editor = ace.edit(querySelector('#editor'))
      ..theme = new ace.Theme('ace/theme/monokai')
      ..session.mode = new ace.Mode('ace/mode/dart');

  for (String name in ace.KeyboardHandler.BINDINGS) {
    _createButton(editor, new ace.KeyboardHandler.named(name), 
        name == ace.KeyboardHandler.DEFAULT ? 'Ace default' : name);
  }
}

void _createButton(ace.Editor editor, ace.KeyboardHandler handler, 
                   String name) {
  var parent = querySelector('#buttons');
  var button = new ButtonElement()
      ..text = name
      ..onClick.listen((_) {
        editor.keyBinding.keyboardHandler = handler;
        querySelector('#label').text = name;
      });

  parent.children.add(button);
}
