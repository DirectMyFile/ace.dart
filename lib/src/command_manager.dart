part of ace;

abstract class CommandManager extends Disposable {

  factory CommandManager(String platform, Iterable<Command> commands) => 
      implementation.createCommandManager(platform, commands);
  
  void addCommand(Command command);
  
  bool exec(Command command);
  
  List<Command> getCommands();
  
  void removeCommand(Command command);  
}
