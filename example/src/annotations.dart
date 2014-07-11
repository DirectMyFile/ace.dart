part of ace.example.kitchen_sink;

void showAnnotations() {
  editor.session.setAnnotations([
    const ace.Annotation(
      row: 1,
      text: 'hello'),
    const ace.Annotation(
      row: 3,
      html: '<span><i>ruh-roh</i></span>', 
      type: ace.Annotation.ERROR)
  ]);
}
