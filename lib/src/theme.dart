part of ace;

class Theme extends _HasProxy {
  static const AMBIANCE                 = 'ambiance';
  static const CHAOS                    = 'chaos';
  static const CHROME                   = 'chrome';
  static const CLOUDS                   = 'clouds';
  static const CLOUNDS_MIDNIGHT         = 'clouds_midnight';
  static const COBALT                   = 'cobalt';
  static const CRIMSON_EDITOR           = 'crimson_editor';
  static const DAWN                     = 'dawn';
  static const DREAMWEAVER              = 'dreamweaver';
  static const ECLIPSE                  = 'eclipse';
  static const GITHUB                   = 'github';
  static const IDLE_FINGERS             = 'idle_fingers';
  static const KR                       = 'kr';
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
  
  final String _themePath;
  
  get _theme => hasProxy ? _proxy : _themePath;
  
  bool get isDark {
    if (!hasProxy) throw new StateError('$_themePath is not yet loaded.');
    return _proxy.isDark;
  }
  
  String get cssClass {
    if (!hasProxy) throw new StateError('$_themePath is not yet loaded.');
    return _proxy.cssClass;
  }
  
  String get cssText {
    if (!hasProxy) throw new StateError('$_themePath is not yet loaded.');
    return _proxy.cssText;
  }
  
  /// Creates a theme for the given [name].
  /// 
  /// The [name] must be a constant defined in this class such as [MONOKAI].
  Theme.named(String name) : this('ace/theme/$name');
  
  /// Creates a theme for the given [themePath].
  /// 
  /// The [themePath] is a path such as `ace/theme/monokai`.
  Theme(String themePath) : super.async(new Future<js.Proxy>(() {
    final completer = new Completer<js.Proxy>();
    _context.ace.config.loadModule(js.array(['theme', themePath]), 
        new js.Callback.once((module) {
            completer.complete(js.retain(module));
        }));
    return completer.future;
  })), _themePath = themePath;
  
  Theme._(js.Proxy proxy) : super(proxy), _themePath = null;
}
