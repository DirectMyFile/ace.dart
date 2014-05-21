part of ace;

class Token {
  
  static const TEXT = 'text';
  
  final int index;
    
  final int start;
    
  /// The type of this token; defaults to [TEXT].
  final String type;
  
  /// The value of this token.
  final String value;
      
  const Token({this.index, this.start, this.type, this.value});
  
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    if(other is! Token) return false; 
    final o = other;
    return index == o.index && start == o.start && type == o.type && 
        value == o.value;
  }  
  
  int get hashCode => 
      index.hashCode ^ start.hashCode ^ type.hashCode ^ value.hashCode;
}
