library custom_mode_example;

import 'dart:html';

import 'package:ace/ace.dart' as ace;
import 'package:ace/proxy.dart';

ace.Editor editor = ace.edit(querySelector('#editor'));

String customDoc = 
'''In this super simple custom mode, everything is considered a keyword
Except numbers. Like 42.
"Oh, and strings. Either the double kind with 'inner single quotes' "
and also the 'single kind, with "double inners" allowable'.
//Comments are only comments if the mode dicates they are 
/*which this one doesnt!*/

See the javascript package for details about creating custom modes.
''';

void main() {
  ace.implementation = ACE_PROXY_IMPLEMENTATION;
  ace.config.setModuleUrl('ace/mode/custom','mode-custom.js');
  editor
  ..theme = new ace.Theme.named(ace.Theme.VIBRANT_INK)
  ..session = ace.createEditSession(customDoc, new ace.Mode.named('custom'));
      
}