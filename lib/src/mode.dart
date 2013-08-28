part of ace;

// TODO(rms): this map is very incomplete
const Map<String, String> _mimeTypeToMode = const {
  'application/dart'        : 'dart',
  'application/javascript'  : 'javascript',
  'application/json'        : 'json',
  'application/xml'         : 'xml',
  'text/css'                : 'css',
  'text/html'               : 'html',
  'text/x-markdown'         : 'markdown'
};

class Mode extends _HasProxy {  
  final String _modePath;
  
  get _mode => _proxy != null ? _proxy : _modePath;
  
  /// Creates a mode for the given [filePath], based on its resolved mime type.
  factory Mode.forFile(String filePath) {
    final mimeType = lookupMimeType(filePath);
    var mode = _mimeTypeToMode[mimeType];
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
