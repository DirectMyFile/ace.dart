part of ace;

abstract class KeyboardHandler extends _Disposable {

  static const EMACS = 'emacs';
  static const VIM   = 'vim';

  /// A list of the available bindings for use with the [new KeyboardHandler]
  /// constructor.
  static const List<String> BINDINGS = const [ EMACS, VIM ];

  /// [binding] can be one of either [EMACS] or [VIM].
  factory KeyboardHandler(String binding) => new _KeyboardHandlerProxy(binding);
  
  String get id;
}
