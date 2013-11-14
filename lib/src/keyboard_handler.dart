part of ace;

abstract class KeyboardHandler extends _Disposable {

  static const EMACS = 'emacs';
  static const VIM   = 'vim';

  /// A list of the available bindings for use with the [new KeyboardHandler]
  /// constructor.
  static const List<String> BINDINGS = const [ EMACS, VIM ];

  /// Whether or not this keyboard has finished loading.
  bool get isLoaded;
      
  /// Completes when this keyboard [isLoaded].
  Future get onLoad;
  
  String get path;
  
  /// Creates a keyboard for the given [binding].
  /// 
  /// The [binding] should be one of the values in [BINDINGS].
  factory KeyboardHandler.bind(String binding) => 
      new _KeyboardHandlerProxy('ace/keyboard/$binding');
  
  /// Creates a keyboard for the given [path].
  /// 
  /// The [path] is a path such as `ace/keyboard/emacs`.
  factory KeyboardHandler(String path) => new _KeyboardHandlerProxy(path);
}
