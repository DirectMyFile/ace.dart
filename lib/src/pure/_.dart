part of ace.pure;

List _spliceList(List list, int start, int howMany, [List elements]) {
  final end = start + howMany;
  final removed = list.sublist(start, end);
  list.removeRange(start, end);
  if (elements != null) {
    list.insertAll(start, elements);
  }
  return removed;
}
