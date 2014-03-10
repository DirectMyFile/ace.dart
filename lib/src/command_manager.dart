part of ace;

abstract class CommandManager extends Disposable {

  factory CommandManager(String platform, Iterable<Command> commands) => 
      implementation.createCommandManager(platform, commands);
  
  /// Adds the given [command] to this manager.
  /// 
  /// This method will replace any existing command with the same `name` as the
  /// given [command].
  void addCommand(Command command);
  
  bool exec(Command command);
  
  List<Command> getCommands();
  
  /// Removes the given [command] from this manager.
  /// 
  /// This method will remove _any_ existing command with the same `name` as the
  /// given [command].
  void removeCommand(Command command);  
}
