library ace.test._;

import 'package:ace/ace.dart';

const PROXY = 'proxy';
const PURE = 'pure';
const IMPLEMENTATIONS = const [PROXY, PURE];

final noop1 = (_){};

const String sampleTextLine0 = 
'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod ';

const String sampleTextLine1 =
'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,';

const String sampleTextLine2 =
' quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ';

const String sampleTextLine3 =
'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse';

const String sampleTextLine4 =
' cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat ';

const String sampleTextLine5 =
'non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

const String sampleText = 
'''$sampleTextLine0
$sampleTextLine1
$sampleTextLine2
$sampleTextLine3
$sampleTextLine4
$sampleTextLine5''';

const List<String> sampleTextLines = const [ sampleTextLine0 
                                           , sampleTextLine1 
                                           , sampleTextLine2
                                           , sampleTextLine3
                                           , sampleTextLine4
                                           , sampleTextLine5 ];

final Map<int, List<String>> sampleTextWords = 
    sampleTextLines
        .map((line) => new RegExp(r'([\w]+)|(\s+)').allMatches(line)
            .map((match) => match.group(0))
            .toList(growable: false))
        .toList(growable: false)
        .asMap();

Point sampleTextWordStart(int row, int word) {
  int start = 0;  
  String wordString = sampleTextWords[row][word];
    if (word > 0 && wordString == ' ') {
      start = sampleTextLines[row].indexOf(sampleTextWords[row][word - 1]);    
    }
  return new Point(row, sampleTextLines[row].indexOf(wordString, start));
}

Point sampleTextWordEnd(int row, int word) => 
    new Point(row, 
        sampleTextWordStart(row, word).column + 
        sampleTextWords[row][word].length);
