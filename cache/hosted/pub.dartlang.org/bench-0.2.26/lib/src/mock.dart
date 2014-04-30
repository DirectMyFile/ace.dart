part of bench;

typedef dynamic MockGetter();
typedef dynamic MockMethod(List positionalArgs, Map<Symbol, dynamic> namedArgs);
typedef dynamic MockSetter(dynamic);

class Mock<T> {
  
  final List<Invocation> _calls = new List<Invocation>();
  final Map<Symbol, MockGetter> getters = new Map<Symbol, MockGetter>();
  final Map<Symbol, MockSetter> setters = new Map<Symbol, MockSetter>();
  final Map<Symbol, MockMethod> methods = new Map<Symbol, MockMethod>();
    
  Iterable<Invocation> calls(Symbol memberName) => 
      _calls.where((invocation) => invocation.memberName == memberName);
  
  void clearCalls() => _calls.clear();
    
  noSuchMethod(Invocation invocation) {
    _calls.add(invocation);    
    if (invocation.isGetter) {
      if (getters.containsKey(invocation.memberName)) {
        return getters[invocation.memberName]();
      }
    } else if (invocation.isSetter) {
      if (setters.containsKey(invocation.memberName)) {
        return setters[invocation.memberName]
            (invocation.positionalArguments[0]);
      }
    } else if (invocation.isMethod) {
      if (methods.containsKey(invocation.memberName)) {
        return methods[invocation.memberName]
            (invocation.positionalArguments, invocation.namedArguments);
      }
    } 
  }
}
