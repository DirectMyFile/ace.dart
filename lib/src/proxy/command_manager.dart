part of ace.proxy;

class _CommandManagerProxy extends _HasProxy implements CommandManager {
  
  _CommandManagerProxy(String platform, Iterable<Command> commands)
  : this._(new js.JsObject(
      _modules['ace/commands/command_manager']['CommandManager'], 
      [platform, _jsArray(commands.map((command) => 
          (command as dynamic)._proxy))]));
  
  _CommandManagerProxy._(js.JsObject proxy) : super(proxy);
  
  void addCommand(Command command) {
    assert(command is _CommandReverseProxy);
    call('addCommand', [(command as _CommandReverseProxy)._proxy]);
  }
  
  List<Command> getCommands() => _map(_proxy['commands']).values
      .map((v) => new _CommandProxy._(v)).toList();
  
  void removeCommand(Command command) {
    assert(command is _CommandReverseProxy);
    call('removeCommand', [(command as _CommandReverseProxy)._proxy]);
  }
}
