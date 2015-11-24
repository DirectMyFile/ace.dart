library ace.test.command_manager;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';

int commandExecCount;
Command command;
CommandManager manager;

setup() {
  implementation = ACE_PROXY_IMPLEMENTATION;  
  commandExecCount = 0;
  command = new Command(
      'gotoline', 
      const BindKey(mac: 'Command-L', win: 'Ctrl-L'),
      (editor) {
        commandExecCount++;
      });  
  manager = new CommandManager('mac', [command]);
}

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

void testRemoveCommand() {
  manager.removeCommand(command.name);
  expect(manager.getCommands(), isEmpty);
}

void testAddCommand() {
  final c = new Command(
      'find',
      const BindKey(mac: 'Command-F', win: 'Ctrl-F'),
      (_) {});
  manager.addCommand(c);
  final commands = manager.getCommands();
  expect(commands.length, equals(2));
  final find = commands.singleWhere((command) => command.name == 'find');
  expect(find.bindKey, const BindKey(mac: 'Command-F', win: 'Ctrl-F'));
}

void testAddCommandSameName() {
  int count = 0;
  final c = new Command(
      'gotoline',
      const BindKey(mac: 'Command-F', win: 'Ctrl-F'),
      (editor) {
        count++;
      });  
  manager.addCommand(c);
  final commands = manager.getCommands();
  expect(commands.length, equals(1));
  expect(commands[0].bindKey, const BindKey(mac: 'Command-F', win: 'Ctrl-F'));  
  manager.exec(c.name);
  expect(commandExecCount, isZero);
  expect(count, equals(1));
}

void testExec() {
  expect(commandExecCount, isZero);
  expect(manager.exec(command.name), isTrue);
  expect(commandExecCount, equals(1));
}
