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

String _ext(String path) {
  int index = path.lastIndexOf('.');
  if (index < 0 || index + 1 >= path.length) return path;
  return path.substring(index + 1).toLowerCase();
}

class Mode extends _HasProxy {
  
  final String _modePath;
  
  get _mode => hasProxy ? _proxy : _modePath;
  
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
  Mode(String modePath) : super.async(new Future<js.Proxy>(() {
    final completer = new Completer<js.Proxy>();
    _context.ace.config.loadModule(js.array(['mode', modePath]), 
        new js.Callback.once((module) {
            completer.complete(js.retain(new js.Proxy(module.Mode)));
        }));
    return completer.future;
  })), _modePath = modePath ;
  
  Mode._(js.Proxy proxy) : super(proxy), _modePath = null;
}
