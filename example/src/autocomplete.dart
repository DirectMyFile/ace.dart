part of ace.kitchen_sink;

void enableAutocomplete() {
  // Load the language tools extension.
  ace.LanguageTools langTools = ace.require('ace/ext/language_tools');
  
  // Add a custom auto-completer (advanced usage - not required)
  langTools.addCompleter(new ace.AutoCompleter(
     (editor, session, position, prefix) {    
   return new Future.value([const ace.Completion('answer', 
       snippet:'<answer></answer>', score: 42, meta: 'snarf')]);
  }));  
  
  // Enable autocompletion.
  editor.setOptions({
   // Use the `ctrl + SPACE` keys to trigger basic auto-completion.
   'enableBasicAutocompletion' : true,
   'enableSnippets' : true
  });
}
