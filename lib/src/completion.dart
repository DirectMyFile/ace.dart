part of ace;

class Completion {
  final String name;
  final String value;
  final num score;
  final String meta;

  Completion(this.name, this.value, this.score, [this.meta]);
}

typedef Future<List<Completion>> CodeCompleter(Editor editor,
    EditSession session, int position, String prefix);
