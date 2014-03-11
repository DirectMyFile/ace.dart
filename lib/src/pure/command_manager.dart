part of ace.pure;

class _CommandManager extends Disposable implements CommandManager {
  
  final String _platform;
  
  _CommandManager(String platform, Iterable<Command> commands)
      : _platform = (platform == null) ? _htmlPlatform : platform {
    addCommands(commands);
  }
  
  void addCommand(Command command) => throw new UnimplementedError();
  
  void addCommands(Iterable<Command> commands) => commands.forEach(addCommand);
  
  bool exec(String commandName) => throw new UnimplementedError();
  
  List<Command> getCommands() => throw new UnimplementedError();
  
  void removeCommand(String commandName) => throw new UnimplementedError();  
}
