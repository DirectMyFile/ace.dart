part of ace;

class EditSession {
  js.Proxy _proxy;
  
  int get length => _proxy.getLength();
  
  String
    get newLineMode => _proxy.getNewLineMode();
    set newLineMode(String newLineMode) => _proxy.setNewLineMode(newLineMode);
  
  bool
    get overwrite => _proxy.getOverwrite();
    set overwrite(bool overwrite) => _proxy.setOverwrite(overwrite);
  
  int
    get tabSize => _proxy.getTabSize();
    set tabSize(int tabSize) => _proxy.setTabSize(tabSize);
    
  bool
    get useSoftTabs => _proxy.getUseSoftTabs();
    set useSoftTabs(bool useSoftTabs) => _proxy.setUseSoftTabs(useSoftTabs);
    
  bool
    get useWorker => _proxy.getUseWorker();
    set useWorker(bool useWorker) => _proxy.setUseWorker(useWorker);
    
  String
    get value => _proxy.getValue();
    set value(String text) => _proxy.setValue(text);
    
  int get wrapLimit => _proxy.getWrapLimit();
    
  EditSession._(js.Proxy proxy) : _proxy = js.retain(proxy) {
    // TODO(rms): add event listeners and expose as Streams
  }
  
  void dispose() {
    assert(_proxy != null);
    js.release(_proxy);
    _proxy = null;
  }
    
  void addGutterDecoration(int row, String className) =>
      _proxy.addGutterDecoration(row, className);
  void clearAnnotations() => _proxy.clearAnnotations();
  void clearBreakpoint(int row) => _proxy.clearBreakpoint(row);
  void clearBreakpoints() => _proxy.clearBreakpoints();
  int documentToScreenColumn(int docRow, int docColumn) =>
      _proxy.documentToScreenColumn(docRow, docColumn);
  int documentToScreenRow(int docRow, int docColumn) =>
      _proxy.documentToScreenRow(docRow, docColumn);
  int duplicateLines(int firstRow, int lastRow) =>
      _proxy.duplicateLines(firstRow, lastRow);
  Range getAWordRange(int row, int column) =>
      new Range._fromProxy(_proxy.getAWordRange(row, column));
  String getLine(int row) => _proxy.getLine(row);
  int getRowLength(int row) => _proxy.getRowLength(row);
  void indentRows(int startRow, int endRow, String indentString) =>
      _proxy.indentRows(startRow, endRow, indentString);
  int moveLinesDown(int firstRow, int lastRow) =>
      _proxy.moveLinesDown(firstRow, lastRow);
  int moveLinesUp(int firstRow, int lastRow) =>
      _proxy.moveLinesUp(firstRow, lastRow);
  void setMode(String mode) => _proxy.setMode(mode);
  void toggleOverwrite() => _proxy.toggleOverwrite();
  String toString() => _proxy.toString();
}
