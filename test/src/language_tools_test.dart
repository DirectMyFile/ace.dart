library ace.test.language_tools;

import 'dart:async';
import 'dart:html' as html;
import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';
import '_.dart';

html.Element container;
Editor editor;

setup() {  
  implementation = ACE_PROXY_IMPLEMENTATION;
  container = new html.Element.div();
  html.document.body.append(container);
  editor = edit(container)
  ..setValue(sampleText, -1);
}

void teardown() {
  html.document.body.children.remove(container);  
  editor.dispose();  
  editor = null;
  container = null;
}

void testAddCompleter() {
  LanguageTools langTools = require('ace/ext/language_tools');
  expect(langTools, isNotNull);  
  Point wordStart = sampleTextWordStart(3, 2);
  Point wordMiddle = new Point(wordStart.row, wordStart.column + 1);
  String wordPrefix = sampleTextWords[3][2].substring(0, 1);  
  AutoCompleter completer = new AutoCompleter(expectAsync(
      (editor, session, position, prefix) {
    expect(position, equals(wordMiddle));
    expect(prefix, equals(wordPrefix));
    return new Future.value([const Completion('snarf')]);
  }));
  langTools.addCompleter(completer);
  editor.setOption('enableBasicAutocompletion', true);  
  editor.navigateTo(wordMiddle.row, wordMiddle.column);
  editor.execCommand('startAutocomplete');
}
