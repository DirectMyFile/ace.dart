library ace.example.annotations;

import 'dart:html';
import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';

main() {
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
  var editor = ace.edit(querySelector('#editor'))
  ..theme = new ace.Theme('ace/theme/monokai')
  ..session.mode = new ace.Mode('ace/mode/dart')
  ..session.setAnnotations([
    const ace.Annotation(
      row: 1,
      text: 'hello'),
    const ace.Annotation(
      row: 3,
      html: '<span><i>ruh-roh</i></span>', 
      type: ace.Annotation.ERROR)
  ]);
}
