part of ace.kitchen_sink;

InputElement _rowInput;

Element buildLineSelector() {
  _rowInput = new InputElement(type: 'number')
    ..value = '5'
    ..text = "Line number:";
  
  final lineSelector = new DivElement();
  lineSelector.append(new SpanElement()..text = 'Line number');
  lineSelector.append(_rowInput);
  lineSelector.classes.add('control');
  return lineSelector;
}

SelectElement _annotationTypeSelector = new SelectElement();

Element buildAnnotationSelector() {
  final annotationSelector = new DivElement();
  for (String type in [ace.Annotation.INFO, 
                       ace.Annotation.WARNING, 
                       ace.Annotation.ERROR]) {
    final option = new OptionElement()
    ..text = type
    ..value = type;
    _annotationTypeSelector.append(option);
  }
  
  annotationSelector.append(new SpanElement()..text = 'Type');
  annotationSelector.append(_annotationTypeSelector);
  annotationSelector.classes.add('control');
  return annotationSelector;
}

bool _decorateGutter = false;
Element buildGutterOption() {
  return _buildOption("Use gutter decoration", _decorateGutter, (b){
    _decorateGutter = b;
  });
}

Element buildInsertAnnotationButton() {
  final textMap = {
                       ace.Annotation.INFO: 'just some information',
                       ace.Annotation.WARNING: 'maybe something is wrong',
                       ace.Annotation.ERROR: 'Oh dear...'
  };
  return new ButtonElement()..onClick.listen((_) {
    int row;
    try {
      row = int.parse(_rowInput.value);
      _rowInput.value = (row + 1).toString();
    } catch(e) {
      print('row number must be an integer');
    }
    if (_decorateGutter){
      editor.session.addGutterDecoration(row-1,
          '${_annotationTypeSelector.value}-custom-css');
    }
    editor.session.setAnnotations(editor.session.getAnnotations()..add(
       new ace.Annotation(row: row-1,
           type: _annotationTypeSelector.value,
           text: textMap[_annotationTypeSelector.value])
       ));
  })..text = "Insert annotation";
}

Element buildClearAnnotationButton() {
  final cssClasses = ['info-custom-css',
                      'warning-custom-css',
                      'error-custom-css'];
  
  return new ButtonElement()
  ..text = "Clear annotations"
  ..onClick.listen((_) {
    var rows = editor.session.getAnnotations().map((annot) => annot.row);
    for (var row in rows) {
      for (var cssClass in cssClasses) {
        editor.session.removeGutterDecoration(row, cssClass);
      }
    }
    editor.session.clearAnnotations();
  });
}

Element buildHeader() => new Element.tag('h2')..text = "Annotations";

Element buildAnnotator() => new DivElement()..children.addAll([
                                                 buildHeader(),
                                                 buildLineSelector(),
                                                 buildAnnotationSelector(),
                                                 buildGutterOption(),
                                                 buildInsertAnnotationButton(),
                                                 buildClearAnnotationButton()
                                                               ]);
