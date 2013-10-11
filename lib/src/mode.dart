part of ace;

const Map<String, String> _extensionMap = const {
  'bat'       : 'batchfile',
  'cpp'       : 'c_cpp',
  'cs'        : 'csharp',
  'css'       : 'css',
  'dart'      : 'dart',  
  'h'         : 'c_cpp',
  'html'      : 'html',
  'java'      : 'java',
  'js'        : 'javascript',
  'json'      : 'json',
  'markdown'  : 'markdown',
  'md'        : 'markdown',
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
  
  /// Creates a mode for the given [modePath].
  /// 
  /// The [modePath] is a path such as `ace/mode/text`.
  factory Mode(String modePath) => new _ModeProxy(modePath);
}
