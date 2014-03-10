@TestGroup(description: 'CommandManager')
library ace.test.command_manager;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

Command command;
CommandManager manager;
@Setup
setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;  
  command = new Command(
      "gotoline", 
      const BindKey(mac: "Command-L", win: "Ctrl-L"),
      (editor) {
        // TODO
      });  
  manager = new CommandManager('mac', [command]);
}

@Test()
void testCtor() {
  expect(command, isNotNull);
  expect(manager, isNotNull);
  final commands = manager.getCommands();
  expect(commands.length, equals(1));
  expect(commands[0].name, equals('gotoline'));
  expect(commands[0].bindKey, const BindKey(mac: "Command-L", win: "Ctrl-L"));
  expect(commands[0].scrollIntoView, isNull);
  expect(commands[0].multiSelectAction, isNull);
}
