library annotations_example;

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
  // Warnings and errors achieved through css and editor.session.addGutterDecoration
  // Note while Ace automatically tokenizes input, the parsing is up to you (though there are tools for common languages).
  //
  These errors are for example only - they dont match up with legal/illegal dart expressions/syntax. 
  // Make things really stand out with gutter decorations too!
}
''', new ace.Mode.named(ace.Mode.DART));
  
  //Note row line discrepencies between here and row number in browser - programatically we count from 0, the view counts from 1.
  //So a the new ace.Annotation(row: 4, ...) is being applied to the row labeled 5 in the browser.
  editor.session.setAnnotations([
                                 new ace.Annotation(row: 4, type:ace.Annotation.INFO, text: 'some helpful information!')
                               , new ace.Annotation(row: 6, type:ace.Annotation.WARNING, text: 'oh dear, not so great...')
                               , new ace.Annotation(row: 8, type:ace.Annotation.ERROR, text: 'BOOM!')
                               , new ace.Annotation(row: 10, type:ace.Annotation.ERROR, text: 'Throw in some gutter decorations!')
                                 ]);
  
  editor.session.addGutterDecoration(10, 'error-css-class');
}