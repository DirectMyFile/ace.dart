ace.define(function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var DocCommentHighlightRules = require("./doc_comment_highlight_rules").DocCommentHighlightRules;
var TextHighlightRules = require("./text_highlight_rules").TextHighlightRules;

var TestHighlightRules = function() {
  this.$rules = {
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
  {
    token : "constant.numeric",
    regex : "[+-]?\\d+(?:(?:\\.\\d*)?(?:[eE][+-]?\\d+)?)?\\b"
  },
  {
    token : "string",
    regex : "'",
    next : "qString"
  },
  {
    token : "string",
    regex : "\"",
    next : "qqString"
  },
  {
    token : "keyword",
    regex : "\\b(?:for|in|let)\\b"
  },
  {
    token : "keyword.control.ternary",
    regex : "//?|:"
  },
  {
    token : "keyword.operator.comparison",
    regex : "=|<=?|>=?"
  },
  {
    token : "keyword.operator.arithmetic",
    regex : "(\\-|\\+|\\*|\\/)"
  },
  {
    token : "keyword.operator.arithmetic",
    regex : "\\b(?:and|or)\\b"
  },
  {
    token : "constant.language",
    regex : "\\b(?:true|false)\\b"
  }
],
"comment" : [
  {
    token : "comment",
    regex : ".*?\\*\\/",
    next : "start"
  },
  {
    token : "comment",
    regex : ".*"
  }
],
"qString" : [
  {
    token : "string",
    regex : "[^\\\\']*(?:\\\\.[^\\\\']*)*'",
    next : "start"
  }
],
"qqString" : [
  {
    token : "string",
    regex : "[^\\\\\"]*(?:\\\\.[^\\\\\"]*)*\"",
    next : "start"
  }
]
};

  this.embedRules(DocCommentHighlightRules, "doc-",
        [ DocCommentHighlightRules.getEndRule("start") ]);
};

oop.inherits(TestHighlightRules, TextHighlightRules);

exports.TestHighlightRules = TestHighlightRules;
});