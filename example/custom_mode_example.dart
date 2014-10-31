library custom_mode_example;

import 'dart:html';

import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';

ace.Editor editor = ace.edit(querySelector('#editor'));

void main() {
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
  ace.config.setModuleUrl('ace/mode/test','mode-test.js');
  editor
  ..theme = new ace.Theme.named(ace.Theme.VIBRANT_INK)
  ..session = ace.createEditSession(
      '''//this is a micro language that doesn't do much
x = 5 //but it can do assignments!
s = "double quoted string with 'single quotes'"
s2 = 'single quoted string with "double quotes"'
// ... it should be doing SOMETHING though :S
''',
      new ace.Mode.named('test')
//      new ace.Mode('test')
  );
      
}