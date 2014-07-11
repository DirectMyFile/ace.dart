library ace.example.kitchen_sink;

import 'dart:async';
import 'dart:html';
import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';

part 'src/annotations.dart';
part 'src/autocomplete.dart';
part 'src/key_bindings.dart';

const SAMPLE_CODE =
'''
main() {
  var x = "All this is syntax highlighted";          
}
''';

ace.Editor editor = ace.edit(querySelector('#editor'));
Element controls = querySelector('#controls');

main() {
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
    
  editor
  ..theme = new ace.Theme.named(ace.Theme.CHROME)
  ..session.mode = new ace.Mode.named(ace.Mode.DART)
  ..setValue(SAMPLE_CODE);
  
  showAnnotations();
  enableAutocomplete();
  controls.append(keyBindings());
}
