part of ace;

const Map<String, String> _extensionMap = const {
  'bat'       : 'batchfile',
  'c'         : 'c_cpp',
  'cc'        : 'c_cpp',
  'cpp'       : 'c_cpp',
  'coffee'    : 'coffee',
  'cs'        : 'csharp',
  'css'       : 'css',
  'dart'      : 'dart',
  'go'        : 'golang',
  'h'         : 'c_cpp',
  'html'      : 'html',
  'java'      : 'java',
  'js'        : 'javascript',
  'json'      : 'json',
  'less'      : 'less',
  'markdown'  : 'markdown',
  'md'        : 'markdown',
  'php'       : 'php',
  'properties': 'properties',
  'py'        : 'python',
  'rb'        : 'ruby',
  'scss'      : 'scss',
  'sh'        : 'sh',
  'ts'        : 'typescript',
  'xml'       : 'xml',
  'yaml'      : 'yaml'
};

abstract class Mode extends _Disposable {
  
  /// Creates a mode for the given [filePath], based on its file extension.
  factory Mode.forFile(String filePath) {
    final ext = _ext(filePath);
    var mode = _extensionMap[ext];
    if (mode == null) mode = 'text';
    return new Mode('ace/mode/$mode');
  }
  
  /// Whether or not this mode has finished loading.
  bool get isLoaded;
      
  /// Completes when this mode [isLoaded].
  Future get onLoad;
  
  /// The path of this mode.
  /// 
  /// This is a path such as `ace/mode/text`.
  String get path;
  
  /// Creates a mode for the given [path].
  /// 
  /// The [path] is a path such as `ace/mode/text`.
  factory Mode(String path) => new _ModeProxy(path);
}
