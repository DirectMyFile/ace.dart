part of ace;

class Annotation {
  
  static const ERROR    = 'error';
  static const INFO     = 'info';
  static const WARNING  = 'warning';
  
  /// The html of this annotation; may be `null` if none.
  ///
  /// If this annotation has non-null [text] then this html is ignored.
  final String html;
  
  /// The row of this annotation; defaults to `0`.
  final int row;
  
  /// The text of this annotation; may be `null` if none.
  /// 
  /// If specified, this text takes precedence over this annotation's [html].
  final String text;
  
  /// The type of this annotation; defaults to [INFO].
  final String type;
  
  const Annotation({
    this.html : null,
    this.row  : 0,
    this.text : null,
    this.type : INFO
  });
    
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Annotation) return false; 
    final o = other;
    return html == o.html && row == o.row && text == o.text && type == o.type;
  }  
  
  int get hashCode => 
      html.hashCode ^ row.hashCode ^ text.hashCode ^ type.hashCode;
}
