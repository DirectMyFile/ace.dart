part of ace.pure;

class _CommandManager extends Disposable implements CommandManager {
  
  final String _platform;
  final Map<String, Command> _commands = new Map<String, Command>();
  final Map<int, Map<String, Command>> _commandKeyBinding = 
      new Map<int, Map<String, Command>>();
  
  _CommandManager(String platform, Iterable<Command> commands)
      : _platform = (platform == null) ? _htmlPlatform : platform {
    addCommands(commands);
  }
  
  void addCommand(Command command) => throw new UnimplementedError();
  
  void addCommands(Iterable<Command> commands) => commands.forEach(addCommand);
  
  bool exec(String commandName) => throw new UnimplementedError();
  
  List<Command> getCommands() => throw new UnimplementedError();
  
  void removeCommand(String commandName) => throw new UnimplementedError();
  
  void _bindKey(String key, Command command) {    
    key.split('|').forEach((String keyPart) {
      final binding = _parseKeys(keyPart);
      final int hashId = binding[1];
      if (_commandKeyBinding[hashId] == null) {
        _commandKeyBinding[hashId] = new Map<String, Command>();
      }
      _commandKeyBinding[hashId][binding[0]] = command;      
    });
  }
  
  List _parseKeys(String keys) {
    // TODO:
    return null;
  }
}
