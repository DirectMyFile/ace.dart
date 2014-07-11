part of ace.example.kitchen_sink;

Element keyBindings() {  
  final select = new SelectElement();
  for (String name in ace.KeyboardHandler.BINDINGS) {
    final value = (name == ace.KeyboardHandler.DEFAULT) ? 'ace' : name;
    final option = new OptionElement()
    ..text = value
    ..value = value;
    select.append(option);
  }
  select.onChange.listen((_) {
    final value = (select.value == 'ace') ? ace.KeyboardHandler.DEFAULT 
        : select.value;
    editor.keyboardHandler = new ace.KeyboardHandler.named(value);
  });
  final control = new DivElement()
  ..append(new SpanElement()..text = 'Key binding')
  ..append(select);
  return control;
}
