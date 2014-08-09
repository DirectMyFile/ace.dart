part of ace.kitchen_sink;

Element buildShowInvisibles() => 
    _buildEditorOption('showInvisibles', 'Show Invisibles ', false);

Element buildShowGutter() => 
    _buildEditorOption('showGutter', 'Show Gutter ', true);

Element _buildEditorOption(String name, String desc, bool defaultValue) {
  final input = new InputElement();
  input
  ..type = 'checkbox'
  ..checked = defaultValue
  ..onChange.listen((_) {
    editor.setOption(name, input.checked);
  });  
  final control = new DivElement()
  ..append(new SpanElement()..text = desc)
  ..append(input)
  ..classes = ['control'];
  return control;
}
