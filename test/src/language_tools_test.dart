@TestGroup(description: 'LanguageTools')
library ace.test.language_tools;

import 'dart:async';
import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

Editor editor;

@Setup
setup() {  
  implementation = ACE_PROXY_IMPLEMENTATION;
  html.document.body.append(new html.Element.div()..id = 'editor');
    editor = edit(html.querySelector('#editor'))
    ..setValue(sampleText, -1);
}

@Teardown
void teardown() {
  html.document.body.children.remove(html.querySelector('#editor'));  
  editor.dispose();  
  editor = null;
}

@Test()
void testAddCodeCompleter() {
  LanguageTools langTools = require('ace/ext/language_tools');
  expect(langTools, isNotNull);  
  CodeCompleter completer = new CodeCompleter(expectAsync(
      (editor, session, position, prefix) {
    return new Future.value([]);
  }));  
  langTools.addCompleter(completer);
  editor.setOptions({
    'enableBasicAutocompletion' : true,
    'enableSnippets' : true
  });  
  editor.execCommand('startAutocomplete');
}
