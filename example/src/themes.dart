part of ace.example.kitchen_sink;

Element buildThemes() {  
  final select = new SelectElement();
  for (String name in ace.Theme.THEMES) {
    final option = new OptionElement()
    ..text = name
    ..value = name;
    select.append(option);
  }
  select.value = ace.Theme.CHROME;
  select.onChange.listen((_) {
    editor.theme = new ace.Theme.named(select.value);
  });
  final control = new DivElement()
  ..append(new SpanElement()..text = 'Theme ')
  ..append(select);
  return control;
}
