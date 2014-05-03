part of ace.proxy;

class _CommandManagerProxy extends HasProxy implements CommandManager {
  
  _CommandManagerProxy(String platform, Iterable<Command> commands)
  : this._(new js.JsObject(
      _modules['ace/commands/command_manager']['CommandManager'], 
      [platform, _jsArray(commands.map((command) => 
          (command as dynamic)._proxy))]));
  
  _CommandManagerProxy._(js.JsObject proxy) : super(proxy);
  
  void addCommand(Command command) {
    assert(command is _CommandReverseProxy || command is _CommandProxy);
    call('addCommand', [(command as dynamic)._proxy]);
  }
  
  void addCommands(Iterable<Command> commands) => commands.forEach(addCommand);
  
  bool exec(String commandName) => call('exec', [commandName]);
  
  List<Command> getCommands() {
    final proxies = _proxy['commands'];
    final keys = _objectProto.callMethod('keys', [proxies]);
    return keys.map((String k) => new _CommandProxy._(proxies[k])).toList();
  }
    
  void removeCommand(String commandName) => 
      call('removeCommand', [commandName]);
}
