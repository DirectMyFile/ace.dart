part of ace;

abstract class Command extends Disposable {
  
  static const SCROLL_NONE            = null;
  static const SCROLL_CENTER          = 'center';
  static const SCROLL_ANIMATE         = 'animate';
  static const SCROLL_CURSOR          = 'cursor';
  static const SCROLL_SELECTION_PART  = 'selectionPart'; 
  static const List<String> SCROLL_ACTIONS = const [ 
    SCROLL_NONE, SCROLL_CENTER, SCROLL_ANIMATE, SCROLL_CURSOR, 
    SCROLL_SELECTION_PART
  ];
  
  static const SELECT_NONE            = null;
  static const SELECT_FOR_EACH        = 'forEach';
  static const SELECT_FOR_EACH_LINE   = 'forEachLine';
  static const SELECT_SINGLE          = 'single';
  static const List<String> SELECT_ACTIONS = const [ 
    SELECT_NONE, SELECT_FOR_EACH, SELECT_FOR_EACH_LINE, SELECT_SINGLE
  ];
  
  /// The unique name for this command.
  String get name;
  
  BindKey get bindKey;
 
  /// The function to execute for this command.
  /// 
  /// This function receives an [Editor] instance when called.  As an example
  /// consider a function to indent the current line of an editor:
  /// 
  ///     (editor) => editor.indent();
  Function get exec;
  
  /// Whether or not this command applies to read-only [Editor] instances.
  bool get readOnly;
  
  /// The scroll action for this command.
  /// 
  /// The scroll action is one of the values in [SCROLL_ACTIONS].
  String get scrollIntoView;
  
  /// The select action for this command.
  /// 
  /// The select action is one of the values in [SELECT_ACTIONS].
  String get multiSelectAction;
  
  factory Command(String name, BindKey bindKey, exec(Editor), 
      {bool readOnly: false, String scrollIntoView: SCROLL_NONE, 
      String multiSelectAction: SELECT_NONE}) {
    assert(SCROLL_ACTIONS.contains(scrollIntoView));
    assert(SELECT_ACTIONS.contains(multiSelectAction));
    return implementation.createCommand(name, bindKey, exec, readOnly: readOnly, 
        scrollIntoView: scrollIntoView, multiSelectAction: multiSelectAction);
  }
}

class BindKey {
  final String mac;
  final String win;  
  const BindKey({this.mac, this.win});
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! BindKey) return false; 
    final o = other;
    return mac == o.mac && win == o.win;
  }    
  int get hashCode => mac.hashCode ^ win.hashCode;
  String toString() => 'BindKey(mac: $mac, win: $win)';
}
