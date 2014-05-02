@TestGroup(description: 'LanguageTools')
library ace.test.language_tools;

import 'dart:async';
import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

html.Element container;
Editor editor;

@Setup
setup() {  
  implementation = ACE_PROXY_IMPLEMENTATION;
  container = new html.Element.div();
  html.document.body.append(container);
  editor = edit(container)
  ..setValue(sampleText, -1);
}

@Teardown
void teardown() {
  html.document.body.children.remove(container);  
  editor.dispose();  
  editor = null;
  container = null;
}

@Test()
void testAddCompleter() {
  LanguageTools langTools = require('ace/ext/language_tools');
  expect(langTools, isNotNull);  
  AutoCompleter completer = new AutoCompleter(expectAsync(
      (editor, session, position, prefix) {    
    return new Future.value([new Completion('foo', 'bar', 42)]);
  }));  
  langTools.addCompleter(completer);
  editor.setOption('enableBasicAutocompletion', true);  
  editor.execCommand('startAutocomplete');
}
