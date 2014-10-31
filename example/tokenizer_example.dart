library tokenizer_example;

import 'dart:html';

import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';

ace.Editor editor = ace.edit(querySelector('#editor'));

void main() {
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
  editor
  ..theme = new ace.Theme.named(ace.Theme.VIBRANT_INK)
    ..session = ace.createEditSession('''class Greeter{
  void greet() => print('Hello world!');
}

void main(){ 
  new Greeter().greet();
  // Click around!
  // Token types depend on the session's mode - we're currently using Dart.
  // Ace comes with many modes prepackaged, but making your own is easy too! See http://ace.c9.io/#nav=higlighter
}
''', new ace.Mode.named(ace.Mode.DART));
  
  var results = querySelector('#results');
  
  editor.selection.onChangeCursor.listen((_){
    results.children.insert(1, new DivElement()..classes.add('result')..text = 
        'Type: ${editor.session.getTokenAt(editor.selection.cursor.row, editor.selection.cursor.column).type}');  
  });
  
  editor.session.useSoftTabs = true;
  editor.session.tabSize = 2;
}