library ace.example;

import 'package:ace/ace.dart' as ace;

main() {  
  var editor = ace.edit("editor");
  editor.theme = "ace/theme/monokai";
  editor.session.setMode("ace/mode/dart");
  
  print('----Editor----');
  print('readOnly: ${editor.readOnly}');
  print('scrollSpeed: ${editor.scrollSpeed}');
  print('dragDelay: ${editor.dragDelay}');
  print('overwrite: ${editor.overwrite}');
  print('printMarginColumn: ${editor.printMarginColumn}');
  print('firstVisibleRow: ${editor.firstVisibleRow}');
  print('highlightActiveLine: ${editor.highlightActiveLine}');
  print('highlightGutterLine: ${editor.highlightGutterLine}');
  print('highlightSelectedWord: ${editor.highlightSelectedWord}');
  
  print('----EditSession----');
  print('length: ${editor.session.length}');
  print('overwrite: ${editor.session.overwrite}');
  print('tabSize: ${editor.session.tabSize}');
  print('useSoftTabs: ${editor.session.useSoftTabs}');
  print('useWorker: ${editor.session.useWorker}');
  print('wrapLimit: ${editor.session.wrapLimit}');
  print('newLineMode: ${editor.session.newLineMode}');
  print('screenWidth: ${editor.session.screenWidth}');
  print('scrollLeft: ${editor.session.scrollLeft}');
  print('scrollTop: ${editor.session.scrollTop}');
  print('tabString: ${editor.session.tabString}');
  
  editor.onBlur.listen((_) => print('BLUR'));  
  editor.onFocus.listen((_) => print('FOCUS'));
  editor.onChange.listen((ace.Delta delta) => print('CHANGE ${delta.action}'));
  editor.onCopy.listen((String text) => print('COPY $text'));
  editor.onPaste.listen((String text) => print('PASTE $text'));
}
