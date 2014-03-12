part of ace.pure;

class _CommandManager extends Disposable implements CommandManager {
  
  final String _platform;
  final List<Command> _commands = new List<Command>();
  final Map<int, Map<String, Command>> _commandKeyBinding = 
      new Map<int, Map<String, Command>>();
  
  _CommandManager(String platform, Iterable<Command> commands)
      : _platform = (platform == null) ? _htmlPlatform : platform {
    addCommands(commands);
  }
  
  void addCommand(Command command) => throw new UnimplementedError();
  
  void addCommands(Iterable<Command> commands) => commands.forEach(addCommand);
  
  bool exec(String commandName) => throw new UnimplementedError();
  
  List<Command> getCommands() => _commands.toList();
  
  void removeCommand(String commandName) {
    _commands.removeWhere((c) => c.name == commandName);
    var key;
    for (Map m in _commandKeyBinding.values) {
      for (int k in m.keys) {
        if (m[k].name == commandName) {
          key = k;
          break;
        }
      }
      if (key != null) {
        m.remove(key);
        break;
      }
    }
  }
  
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
  
  List _parseKeys(String keys) => throw new UnimplementedError();
}
