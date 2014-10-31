library delta_example;

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
  //Make changes here and see what happens on left.
  //Note that if you remove entire lines plus partial lines with a single delete, it will fire two events:
  // - one remove lines, to remove the entire lines; and
  // - one remove text, to remove partial lines.
}
''', new ace.Mode.named(ace.Mode.DART));
  
  var results = querySelector('#results');
  
  editor.onChange.listen((delta){
    results.children.insert(1, new DivElement()..classes.add('result')..text = '${delta.action}, (${delta.range.start.row}, ${delta.range.start.column}) -> (${delta.range.end.row}, ${delta.range.end.column})');  
  });
}