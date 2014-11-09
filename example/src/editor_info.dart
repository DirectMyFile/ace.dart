part of ace.kitchen_sink;

Element buildDeltaTracker() {
  var labels = [new SpanElement()..text = "last change:",
                new SpanElement()..text = "2nd last change:",
                new SpanElement()..text = "3rd last change:",];
  
  var deltaDisplays = new List.generate(3, (i) => new SpanElement());
  editor.onChange.listen((delta) {
    for (int i = 2; i > 0; --i) {
      deltaDisplays[i].text = deltaDisplays[i-1].text;  
    }
    deltaDisplays[0].text = delta.action;
  });
  
  var singleTrackers = new List.generate(3, (i) => new DivElement());
  for (int i = 0; i < 3; ++i) {
      singleTrackers[i]..classes.add('control')
      ..append(labels[i])
      ..append(deltaDisplays[i]);
  }
  
  return new DivElement()..children.addAll(singleTrackers);
}

Element buildTokenClickTracker() {
  var tokenDisplay = new SpanElement();
  
  var tokenTracker = new DivElement()
    ..classes.add('control')
    ..append(new SpanElement()..text = "Token at cursor:")
    ..append(tokenDisplay);
  
  editor.selection.onChangeCursor.listen((_) {
    int r = editor.selection.cursor.row;
    int c = editor.selection.cursor.column;
    if (c + 1 == editor.session.getRowLength(r)) {
      tokenDisplay.text = "";
    } else {
      tokenDisplay.text = editor.session.getTokenAt(r, c).type.toString();
    }
  });
  
  return tokenTracker;
}
