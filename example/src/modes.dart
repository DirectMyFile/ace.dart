part of ace.example.kitchen_sink;

Element buildModes() {  
  final select = new SelectElement();
  for (String name in ace.Mode.MODES) {
    final option = new OptionElement()
    ..text = name
    ..value = name;
    select.append(option);
  }
  select.value = ace.Mode.DART;
  select.onChange.listen((_) {
    editor.session.mode = new ace.Mode.named(select.value);
  });  
  final control = new DivElement()
  ..append(new SpanElement()..text = 'Mode ')
  ..append(select);
  return control;
}
