part of ace;

abstract class Theme extends _Disposable {
  
  static const AMBIANCE                 = 'ambiance';
  static const CHAOS                    = 'chaos';
  static const CHROME                   = 'chrome';
  static const CLOUDS                   = 'clouds';
  static const CLOUDS_MIDNIGHT          = 'clouds_midnight';
  static const COBALT                   = 'cobalt';
  static const CRIMSON_EDITOR           = 'crimson_editor';
  static const DAWN                     = 'dawn';
  static const DREAMWEAVER              = 'dreamweaver';
  static const ECLIPSE                  = 'eclipse';
  static const GITHUB                   = 'github';
  static const IDLE_FINGERS             = 'idle_fingers';
  static const KR                       = 'kr_theme';
  static const MERBIVORE                = 'merbivore';
  static const MERBIVORE_SOFT           = 'merbivore_soft';
  static const MONO_INDUSTRIAL          = 'mono_industrial';
  static const MONOKAI                  = 'monokai';
  static const PASTEL_ON_DARK           = 'pastel_on_dark';
  static const SOLARIZED_DARK           = 'solarized_dark';
  static const SOLARIZED_LIGHT          = 'solarized_light';
  static const TERMINAL                 = 'terminal';
  static const TEXTMATE                 = 'textmate';
  static const TOMORROW                 = 'tomorrow';
  static const TOMORROW_NIGHT           = 'tomorrow_night';
  static const TOMORROW_NIGHT_BLUE      = 'tomorrow_night_blue';
  static const TOMORROW_NIGHT_BRIGHT    = 'tomorrow_night_bright';
  static const TOMORROW_NIGHT_EIGHTIES  = 'tomorrow_night_eighties';
  static const TWILIGHT                 = 'twilight';
  static const VIBRANT_INK              = 'vibrant_ink';
  static const XCODE                    = 'xcode';
  
  /// A list of the available themes for use with the [new Theme.named] 
  /// constructor.
  /// 
  /// This list contains all of the themes in the ace package.  An application
  /// using this package may choose to include a subset or a superset of these
  /// themes.
  static const List<String> THEMES = 
      const [ AMBIANCE, CHAOS, CHROME, CLOUDS, CLOUDS_MIDNIGHT, COBALT,
              CRIMSON_EDITOR, DAWN, DREAMWEAVER, ECLIPSE, GITHUB, IDLE_FINGERS,
              KR, MERBIVORE, MERBIVORE_SOFT, MONO_INDUSTRIAL, MONOKAI, 
              PASTEL_ON_DARK, SOLARIZED_DARK, SOLARIZED_LIGHT, TERMINAL, 
              TEXTMATE, TOMORROW, TOMORROW_NIGHT, TOMORROW_NIGHT_BLUE, 
              TOMORROW_NIGHT_BRIGHT, TOMORROW_NIGHT_EIGHTIES, TWILIGHT, 
              VIBRANT_INK, XCODE ];
  
  String get cssClass;
  
  String get cssText;
  
  bool get isDark;
  
  /// Whether or not this theme has finished loading.
  bool get isLoaded;
  
  /// The name of this theme.
  /// 
  /// The [name] should be one of the values in [THEMES].
  String get name;
      
  /// Completes when this theme [isLoaded].
  Future get onLoad;
  
  /// The path of this theme.
  /// 
  /// This is a path such as `ace/theme/monokai`.
  String get path;
  
  /// Creates a theme for the given [name].
  /// 
  /// The [name] should be one of the values in [THEMES].
  factory Theme.named(String name) => new Theme('ace/theme/$name');
  
  /// Creates a theme for the given [path].
  /// 
  /// The [path] is a path such as `ace/theme/monokai`.
  factory Theme(String path) => new _ThemeProxy(path);
}
