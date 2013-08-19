part of ace;

class SearchOptions {
  /// The string or regular expression you are looking for.
  final String needle;
  
  /// Whether to search backwards from where the cursor currently is; defaults 
  /// to `false`.
  final bool backwards;
  
  /// Whether the search is case-sensitive; defaults to `false`.
  final bool caseSensitive;
  
  /// The [Range] to search within. Set this to `null` for the whole document.
  final Range range;
  
  /// Whether the search is a regular expression or not; defaults to `false`.
  final bool regExp;
  
  /// Whether or not to include the current line in the search; defaults to 
  /// `false`.
  final bool skipCurrent;
  
  /// The starting [Range] or cursor position to begin the search.
  final Range start;
  
  /// Whether the search matches only on whole words; defaults to `false`.
  final bool wholeWord;
  
  /// Whether to wrap the search back to the beginning when it hits the end; 
  /// defaults to `false`.
  final bool wrap;
  
  SearchOptions({this.backwards: false,
                       this.caseSensitive: false,
                       this.needle: '',
                       this.range,
                       this.regExp: false,
                       this.skipCurrent: false,
                       this.start,
                       this.wholeWord: false,
                       this.wrap: false});  
  
  SearchOptions._(proxy) : this.__(json.parse(_context.JSON.stringify(proxy)));    
  
  SearchOptions.__(Map m) : this(
      backwards: m['backwards'] == null ? false : m['backwards'],
      caseSensitive: m['caseSensitive'] == null ? false : m['caseSensitive'],
      needle: m['needle'] == null ? '' : m['needle'],
      range: m['range'] == null ? null : new Range._(js.map(m['range'])),
      regExp: m['regExp'] == null ? false : m['regExp'],
      skipCurrent: m['skipCurrent'] == null ? false : m['skipCurrent'],
      start: m['start'] == null ? null : new Range._(js.map(m['start'])),
      wholeWord: m['wholeWord'] == null ? false : m['wholeWord'],
      wrap: m['wrap'] == null ? false : m['wrap']);
  
  js.Proxy _toProxy() =>
      js.map({ 'backwards': backwards,
               'caseSensitive': caseSensitive,
               'needle': needle,
               'range': range == null ? null : range._toProxy(),
               'regExp': regExp,
               'skipCurrent': skipCurrent,
               'start': start == null ? null : start._toProxy(),
               'wholeWord': wholeWord,
               'wrap': wrap });
}

/// Handles text searches within a [Document].
class Search extends _HasProxy {
  
  /// The current [SearchOptions].
  SearchOptions
    get options => new SearchOptions._(_proxy.getOptions());
    set options(SearchOptions options) => _proxy.setOptions(options._toProxy());
  
  /// Creates a new Search with default [SearchOptions]. 
  Search()
    : super(new js.Proxy(_context.ace.define.modules['ace/search'].Search));   
}
