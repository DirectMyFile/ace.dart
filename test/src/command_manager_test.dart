@TestGroup(description: 'CommandManager')
library ace.test.command_manager;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:bench/bench.dart';
import 'package:unittest/unittest.dart';

int commandExecCount;
Command command;
CommandManager manager;
@Setup
setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;  
  commandExecCount = 0;
  command = new Command(
      "gotoline", 
      const BindKey(mac: 'Command-L', win: 'Ctrl-L'),
      (editor) {
        commandExecCount++;
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
  expect(commands[0].bindKey, const BindKey(mac: 'Command-L', win: 'Ctrl-L'));
  expect(commands[0].scrollIntoView, isNull);
  expect(commands[0].multiSelectAction, isNull);
}

@Test()
void testRemoveCommand() {
  manager.removeCommand(command);
  expect(manager.getCommands(), isEmpty);
}

@Test()
void testAddCommand() {
  final c = new Command(
      'find',
      const BindKey(mac: 'Command-F', win: 'Ctrl-F'),
      noop);
  manager.addCommand(c);
  final commands = manager.getCommands();
  expect(commands.length, equals(2));
  final find = commands.singleWhere((command) => command.name == 'find');
  expect(find.bindKey, const BindKey(mac: 'Command-F', win: 'Ctrl-F'));
}

@Test()
void testExec() {
  expect(commandExecCount, isZero);
  expect(manager.exec(command), isTrue);
  expect(commandExecCount, equals(1));
}
