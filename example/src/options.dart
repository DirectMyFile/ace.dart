part of ace.kitchen_sink;

Element buildShowInvisibles() => _buildOption('Show Invisibles ', false,
    (bool value) => editor.setOption('showInvisibles', value));

Element buildShowGutter() => _buildOption('Show Gutter ', true,
    (bool value) => editor.setOption('showGutter', value));

Element buildShowPrintMargin() => _buildOption('Show Print Margin ', true, 
    (bool value) => editor.setOption('showPrintMargin', value));

Element buildUseSoftTabs() => _buildOption('Use Soft Tabs ', true, 
    (bool value) => editor.session.setOption('useSoftTabs', value));

Element _buildOption(String desc, bool defaultValue, onChange(bool value)) {
  final input = new InputElement();
  input
  ..type = 'checkbox'
  ..checked = defaultValue
  ..onChange.listen((_) => onChange(input.checked));  
  final control = new DivElement()
  ..append(new SpanElement()..text = desc)
  ..append(input)
  ..classes = ['control'];
  return control;
}
