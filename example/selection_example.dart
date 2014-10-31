library selection_example;

import 'dart:html';

import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';

ace.Editor editor = ace.edit(querySelector('#editor'));

void main() {
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
  editor
  ..theme = new ace.Theme.named(ace.Theme.VIBRANT_INK)
    ..session = ace.createEditSession('''void main(){
  print('Hello world!');
  //Click around!

  //Editor.selection fires onChangeCursor events
}
''', new ace.Mode.named(ace.Mode.DART));
  
  var results = querySelector('#results');
  
  editor.selection.onChangeCursor.listen((_){
    results.children.insert(1, new DivElement()..classes.add('result')..text = 'Cursor now at ${editor.selection.cursor}');  
  });
}