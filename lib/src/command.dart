part of ace;

abstract class Command extends Disposable {
  
  String get name;
  
  BindKey get bindKey;
 
  Function get exec;
  
  bool get readOnly;
  
  // one of `null`, `center`, `animate`, `cursor` or `selectionPart`
  String get scrollIntoView;
  
  // one of `null`, `forEach`, `forEachLine` or `single`
  String get multiSelectAction;
  
  factory Command(String name, BindKey bindKey, exec(Editor), 
      {bool readOnly: false, String scrollIntoView, String multiSelectAction})
      => implementation.createCommand(name, bindKey, exec, readOnly: readOnly, 
          scrollIntoView: scrollIntoView, multiSelectAction: multiSelectAction);
}

class BindKey {
  final String win;
  final String mac;
  const BindKey({this.win, this.mac});
}
