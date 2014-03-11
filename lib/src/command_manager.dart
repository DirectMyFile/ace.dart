part of ace;

abstract class CommandManager extends Disposable {

  factory CommandManager(String platform, Iterable<Command> commands) => 
      implementation.createCommandManager(platform, commands);
  
  /// Adds the given [command] to this manager.
  /// 
  /// This method will replace any existing command with the same `name` as the
  /// given [command].
  void addCommand(Command command);
  
  void addCommands(Iterable<Command> commands);
  
  /// Executes the given [commandName] using this manager.
  /// 
  /// This method is called internally and not designed to be called from 
  /// outside this library.
  bool exec(String commandName);
  
  /// Returns a copy of the current commands for this manager.
  List<Command> getCommands();
  
  /// Removes any command with the given [commandName] from this manager.
  void removeCommand(String commandName);
}
