part of ace.pure;

class _Command extends Disposable implements Command {
  
  final String name;
  final BindKey bindKey;
  final Function exec;
  final bool readOnly;
  final String scrollIntoView;
  final String multiSelectAction;
  
  _Command(this.name, this.bindKey, exec(Editor), 
      {this.readOnly: false, this.scrollIntoView, this.multiSelectAction})
  : this.exec = exec;
}
