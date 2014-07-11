part of ace.example.kitchen_sink;

SelectElement modesSelect = new SelectElement();

Element buildModes() {
  for (String name in ace.Mode.MODES) {
    final option = new OptionElement()
    ..text = name
    ..value = name;
    modesSelect.append(option);
  }
  modesSelect.value = ace.Mode.DART;
  modesSelect.onChange.listen((_) {
    editor.session.mode = new ace.Mode.named(modesSelect.value);
  });  
  final control = new DivElement()
  ..append(new SpanElement()..text = 'Mode ')
  ..append(modesSelect)
  ..classes = ['control'];
  return control;
}
