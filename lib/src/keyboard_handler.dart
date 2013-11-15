part of ace;

abstract class KeyboardHandler extends _Disposable {

  static const EMACS = 'emacs';
  static const VIM   = 'vim';

  /// A list of the available keyboard bindings for use with the 
  /// [new KeyboardHandler.named] constructor.
  static const List<String> BINDINGS = const [ EMACS, VIM ];

  /// Whether or not this keyboard handler has finished loading.
  bool get isLoaded;
      
  /// Completes when this keyboard handler [isLoaded].
  Future get onLoad;
  
  /// The path of this keyboard handler, may be `null`.
  /// 
  /// This is a path such as `ace/keyboard/emacs`.
  /// 
  /// A `null` value represents the default keyboard handler.
  String get path;
  
  /// Creates a keyboard for the given [name].
  /// 
  /// The [name] should be one of the values in [BINDINGS].
  factory KeyboardHandler.named(String name) => 
      new KeyboardHandler('ace/keyboard/$name');
  
  /// Creates a keyboard for the given [path].
  /// 
  /// The [path] is a path such as `ace/keyboard/emacs`.
  factory KeyboardHandler(String path) => new _KeyboardHandlerProxy(path);
}
