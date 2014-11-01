ace.define('ace/mode/custom', function(require, exports, module) {

  var oop = require("ace/lib/oop");
  var TextMode = require("ace/mode/text").Mode;
  var Tokenizer = require("ace/tokenizer").Tokenizer;
  var ExampleHighlightRules = require("ace/mode/example_highlight_rules").ExampleHighlightRules;

  var Mode = function() {
    this.$tokenizer = new Tokenizer(new ExampleHighlightRules().getRules());
  };
  oop.inherits(Mode, TextMode);

  (function() {
    // Extra logic goes here. (see below)
  }).call(Mode.prototype);

  exports.Mode = Mode;
});

ace.define('ace/mode/example_highlight_rules', function(require, exports, module) {

  var oop = require("ace/lib/oop");
  var TextHighlightRules = require("ace/mode/text_highlight_rules").TextHighlightRules;

  var ExampleHighlightRules = function() {

    //this.$rules = new TextHighlightRules().getRules();

    this.$rules = {
      "start": [
        /*{        
          token : "comment",
          regex : "//.*$"
        },*/
        {
          token: "constant.number",
          regex: "[0-9]+"
        }, {
          token: "keyword",
          regex: "[a-zA-Z]+"
        }, {
          token: "string",
          regex: "'",
          next: "qString"
        }, {
          token: "string",
          regex: "\"",
          next: "qqString"
        }
      ],
      "qString": [{
        token: "string",
        regex: "[^\\\\']*(?:\\\\.[^\\\\']*)*'",
        next: "start"
      }],
      "qqString": [{
        token: "string",
        regex: "[^\\\\\"]*(?:\\\\.[^\\\\\"]*)*\"",
        next: "start"
      }]
    };

    /*this.$rules = {
       "start" : [
         {
           token : "comment",
           regex : "/\\*",
           next : "comment"
         },
         {
           token : "comment",
           regex : "//.*$"
         },
       ],

       ],
       "qqString" : [
         {
           token : "string",
           regex : "[^\\\\\"]*(?:\\\\.[^\\\\\"]*)*\"",
           next : "start"
         }
       ]
       };*/
  }

  oop.inherits(ExampleHighlightRules, TextHighlightRules);

  exports.ExampleHighlightRules = ExampleHighlightRules;
});