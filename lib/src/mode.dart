part of ace;

abstract class Mode extends Disposable {
  
  static const ABAP                 = 'abap';
  static const ACTIONSCRIPT         = 'actionscript';
  static const ADA                  = 'ada';
  static const APACHE_CONF          = 'apache_conf';
  static const ASCIIDOC             = 'asciidoc';
  static const ASSEMBLY_X86         = 'assembly_x86';
  static const AUTOHOTKEY           = 'autohotkey';
  static const BATCHFILE            = 'batchfile';
  static const C9SEARCH             = 'c9search';
  static const C_CPP                = 'c_cpp';
  static const CIRRU                = 'cirru';
  static const CLOJURE              = 'clojure';
  static const COBOL                = 'cobol';
  static const COFFEE               = 'coffee';
  static const COLDFUSION           = 'coldfusion';
  static const CSHARP               = 'csharp';
  static const CSS                  = 'css';
  static const CURLY                = 'curly';
  static const D                    = 'd';
  static const DART                 = 'dart';
  static const DIFF                 = 'diff';
  static const DJANGO               = 'django';
  static const DOT                  = 'dot';
  static const EJS                  = 'ejs';
  static const ERLANG               = 'erlang';
  static const FORTH                = 'forth';
  static const FTL                  = 'ftl';
  static const GHERKIN              = 'gherkin';
  static const GLSL                 = 'glsl';
  static const GOLANG               = 'golang';
  static const GROOVY               = 'groovy';
  static const HAML                 = 'haml';
  static const HANDLEBARS           = 'handlebars';
  static const HASKELL              = 'haskell';
  static const HAXE                 = 'haxe';
  static const HTML                 = 'html';
  static const HTML_RUBY            = 'html_ruby';
  static const INI                  = 'ini';
  static const JACK                 = 'jack';
  static const JADE                 = 'jade';
  static const JAVA                 = 'java';
  static const JAVASCRIPT           = 'javascript';
  static const JSON                 = 'json';
  static const JSONIQ               = 'jsoniq';
  static const JSP                  = 'jsp';
  static const JSX                  = 'jsx';
  static const JULIA                = 'julia';
  static const LATEX                = 'latex';
  static const LESS                 = 'less';
  static const LIQUID               = 'liquid';
  static const LISP                 = 'lisp';
  static const LIVESCRIPT           = 'livescript';
  static const LOGIQL               = 'logiql';
  static const LSL                  = 'lsl';
  static const LUA                  = 'lua';
  static const LUAPAGE              = 'luapage';
  static const LUCENE               = 'lucene';
  static const MAKEFILE             = 'makefile';
  static const MARKDOWN             = 'markdown';
  static const MATLAB               = 'matlab';
  static const MEL                  = 'mel';
  static const MUSHCODE             = 'mushcode';
  static const MYSQL                = 'mysql';
  static const NIX                  = 'nix';
  static const OBJECTIVEC           = 'objectivec';
  static const OCAML                = 'ocaml';
  static const PASCAL               = 'pascal';
  static const PERL                 = 'perl';
  static const PGSQL                = 'pgsql';
  static const PHP                  = 'php';
  static const PLAIN_TEXT           = 'plain_text';
  static const POWERSHELL           = 'powershell';
  static const PROLOG               = 'prolog';
  static const PROPERTIES           = 'properties';
  static const PROTOBUF             = 'protobuf';
  static const PYTHON               = 'python';
  static const R                    = 'r';
  static const RDOC                 = 'rdoc';
  static const RHTML                = 'rhtml';
  static const RUBY                 = 'ruby';
  static const RUST                 = 'rust';
  static const SASS                 = 'sass';
  static const SCAD                 = 'scad';
  static const SCALA                = 'scala';
  static const SCHEME               = 'scheme';
  static const SCSS                 = 'scss';
  static const SH                   = 'sh';
  static const SJS                  = 'sjs';
  static const SMARTY               = 'smarty';
  static const SNIPPETS             = 'snippets';
  static const SOY_TEMPLATE         = 'soy_template';
  static const SPACE                = 'space';
  static const SQL                  = 'sql';
  static const STYLUS               = 'stylus';
  static const SVG                  = 'svg';
  static const TCL                  = 'tcl';
  static const TEX                  = 'tex';
  static const TEXT                 = 'text';
  static const TEXTILE              = 'textile';
  static const TOML                 = 'toml';
  static const TWIG                 = 'twig';
  static const TYPESCRIPT           = 'typescript';
  static const VBSCRIPT             = 'vbscript';
  static const VELOCITY             = 'velocity';
  static const VERILOG              = 'verilog';
  static const VHDL                 = 'vhdl';
  static const XML                  = 'xml';
  static const XQUERY               = 'xquery';
  static const YAML                 = 'yaml';
  
  /// A list of the available modes for use with the [new Mode.named] 
  /// constructor.
  /// 
  /// This list contains all of the modes in the ace package.  An application
  /// using this package may choose to include a subset or a superset of these
  /// modes.
  static const List<String> MODES = const [ 
    ABAP, ACTIONSCRIPT, ADA, APACHE_CONF, ASCIIDOC, ASSEMBLY_X86, AUTOHOTKEY,
    BATCHFILE, C9SEARCH, C_CPP, CIRRU, CLOJURE, COBOL, COFFEE, COLDFUSION, 
    CSHARP, CSS, CURLY, D, DART, DIFF, DJANGO, DOT, EJS, ERLANG, FORTH, FTL, 
    GHERKIN, GLSL, GOLANG, GROOVY, HAML, HANDLEBARS, HASKELL, HAXE, HTML, 
    HTML_RUBY, INI, JACK, JADE, JAVA, JAVASCRIPT, JSON, JSONIQ, JSP, JSX, JULIA, 
    LATEX, LESS, LIQUID, LISP, LIVESCRIPT, LOGIQL, LSL, LUA, LUAPAGE, LUCENE, 
    MAKEFILE, MARKDOWN, MATLAB, MEL, MUSHCODE, MYSQL, NIX, OBJECTIVEC, OCAML, 
    PASCAL, PERL, PGSQL, PHP, PLAIN_TEXT, POWERSHELL, PROLOG, PROPERTIES, 
    PROTOBUF, PYTHON, R, RDOC, RHTML, RUBY, RUST, SASS, SCAD, SCALA, SCHEME, 
    SCSS, SH, SJS, SMARTY, SNIPPETS, SOY_TEMPLATE, SPACE, SQL, STYLUS, SVG, TCL, 
    TEX, TEXT, TEXTILE, TOML, TWIG, TYPESCRIPT, VBSCRIPT, VELOCITY, VERILOG, 
    VHDL, XML, XQUERY, YAML
  ];
  
  static const Map<String, String> _extensionMap = const {
    'as'        : ACTIONSCRIPT,
    'bat'       : BATCHFILE,
    'c'         : C_CPP,
    'cc'        : C_CPP,
    'cpp'       : C_CPP,
    'coffee'    : COFFEE,
    'cs'        : CSHARP,
    'css'       : CSS,
    'dart'      : DART,
    'go'        : GOLANG,
    'h'         : C_CPP,
    'hs'        : HASKELL,
    'htm'       : HTML,
    'html'      : HTML,
    'hx'        : HAXE,
    'ini'       : INI,
    'java'      : JAVA,
    'js'        : JAVASCRIPT,
    'json'      : JSON,
    'less'      : LESS,
    'lua'       : LUA,
    'markdown'  : MARKDOWN,
    'md'        : MARKDOWN,
    'pl'        : PERL,
    'pm'        : PERL,
    'php'       : PHP,    
    'properties': PROPERTIES,
    'py'        : PYTHON,
    'rb'        : RUBY,
    'sass'      : SASS,
    'scala'     : SCALA,
    'scss'      : SCSS,
    'sh'        : SH,
    'svg'       : SVG,
    'ts'        : TYPESCRIPT,
    'xml'       : XML,
    'yaml'      : YAML
  };
  
  /// A map from file extension to mode used by the [new Mode.forFile] factory.
  /// 
  /// This map is initialized with a default mapping; it may be modified to 
  /// customize the behavior of the [new Mode.forFile] factory.
  static final Map<String, String> extensionMap = new Map.from(_extensionMap);
  
  /// Whether or not this mode has finished loading.
  bool get isLoaded;
      
  /// The name of this mode.
  /// 
  /// The [name] is one of the values in [MODES] or a custom mode not defined
  /// in this package.
  String get name;
  
  /// Completes when this mode [isLoaded].
  Future get onLoad;
  
  /// The path of this mode.
  /// 
  /// This is a path such as `ace/mode/text`.
  String get path;
  
  /// Creates a mode for the given [filePath], based on its file extension.
  /// 
  /// This factory selects a mode using the current [extensionMap].  If there
  /// is no matching value for the extension in [filePath] then this returns
  /// the [TEXT] mode.
  factory Mode.forFile(String filePath) {
    final ext = implementation.getExtension(filePath);
    var mode = extensionMap[ext];
    if (mode == null) mode = TEXT;
    return new Mode.named(mode);
  }
  
  /// Creates a mode for the given [name].
  /// 
  /// The [name] should be one of the values in [MODES].
  factory Mode.named(String name) => new Mode('ace/mode/$name');
  
  /// Creates a mode for the given [path].
  /// 
  /// The [path] is a path such as `ace/mode/text`.
  factory Mode(String path) => implementation.createMode(path);
}
