part of ace;

abstract class Implementation {
  
  const Implementation();
  
  Anchor createAnchor(Document document, int row, int column);
  
  Command createCommand(String name, BindKey bindKey, exec(Editor), 
      {bool readOnly: false, String scrollIntoView, String multiSelectAction});
  
  CommandManager createCommandManager({String platform, 
      Iterable<Command> commands});
  
  Document createDocument(String text);
  
  EditSession createEditSession(String text, Mode mode);
  
  EditSession createEditSessionFromDocument(Document document, Mode mode);
  
  Fold createFold(Range range, Placeholder placeholder);
  
  KeyboardHandler createKeyboardHandler(String path);
  
  Mode createMode(String path);
  
  Placeholder createPlaceholder(
      EditSession session, 
      int length, 
      Point position,
      Iterable<Point> others,
      String mainClass,
      String othersClass);
  
  RangeList createRangeList();
  
  Search createSearch();
  
  Selection createSelection(EditSession session);
  
  Theme createTheme(String path);
  
  VirtualRenderer createVirtualRenderer(container, Theme theme);
  
  Editor edit(element);
  
  String getExtension(String path, {String separator: '.'}) {
    int index = path.lastIndexOf(separator);
    if (index < 0 || index + 1 >= path.length) return path;
    return path.substring(index + 1).toLowerCase();
  }
  
  require(String modulePath);
}
