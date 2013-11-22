# Ace.dart Changes

## 0.1.4-dev+10.28.2013

## 0.1.3+10.28.2013

- Added the `KeyBinding` and `KeyboardHandler` abstract classes and expose the
`Editor.keyBinding` getter and the `Editor.keyboardHandler` getter / setter.

## 0.1.2+10.28.2013

- Added a new `example/autocomplete`.
- Added the `require` top-level function.
- Added the `OptionsProvider` abstract class and have `Editor` implement it. 

## 0.1.1+10.28.2013

- Updated pubspec for Dart 1.0 release as requested.

## 0.1.0+10.28.2013

- Updated to ace-builds version 10.28.2013.
- Updated to SDK 0.8.10_r29803.
- Added documentation and test coverage to a number of public methods; please
consult the commit history for details.

## 0.0.9+10.21.2013

- Updated to ace-builds version 10.21.2013.
- Fixed a couple of bugs from the move to `dart:js`.

## 0.0.8+10.7.2013

- Updated to SDK 0.8.5_r28990.
- Removed dependency on `js` package and moved code to use the `dart:js` 
library instead.

## 0.0.7+10.7.2013

- Added several public methods to the `Range` class with documentation and test 
coverage.
- Changed the `noClip` parameter of `Anchor.setPosition` to a named optional
parameter `clip` which defaults to `true`.
- Changed the `dontSelect` parameter of `UndoManager.undo` and `redo` to a named 
optional parameter `select` which defaults to `true`.
- Changed the `cursorPos` parameter of `Editor.setValue` to an optional
parameter `cursorPosition` which defaults to `0` (select all) and documented the
method.
- Changed the `times` parameter of the `Editor` methods `navigateDown`, 
`navigateLeft`, `navigateRight`, and `navigateUp` to be optional with default 
value of `1`.

## 0.0.6+10.7.2013

- Pub doesn't seem to like a `0` in the version metadata just about anywhere.
This is really a pub bug but I'm going to drop the `0` to work around the issue.

## 0.0.5+10.07.2013

- Updated to ace-builds version 10.07.2013.
- Changed the `text` parameter of the `Document` constructor from an optional
to a named optional.

## 0.0.4+9.11.2013

- Updated to SDK 0.7.6_r28108.
- Added documentation and test coverage to a number of public methods; please
consult the commit history for details.
- Fixed `Editor.onChangeSession` stream type to `EditSessionChangeEvent` thanks
to a bug fix in the `js-interop` package.

## 0.0.3+9.11.2013

- Updated to SDK 0.7.5_r27776.
- Added documentation and test coverage to a number of public methods; please
consult the commit history for details.

## 0.0.2+9.11.2013

- Removed leading `0` from the version metadata string as it was being stripped
when publishing and that was causing issues.
- Added LICENSE and README for ace.js to `lib/src/js`.

## 0.0.1+09.11.2013

- Initial version.
