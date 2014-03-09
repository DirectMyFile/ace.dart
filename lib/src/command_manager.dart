part of ace;

abstract class CommandManager extends Disposable {

  void addCommand(Command command);
  
  Map<String, Command> getCommands();
  
  void removeCommand(Command command);  
}
