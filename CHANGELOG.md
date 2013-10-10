# Ace.dart Changes

## 0.0.7-dev+10.7.2013

- Added several public methods to the `Range` class with documentation and test 
coverage.
- Changed the `noClip` parameter of `Anchor.setPosition` to a named optional
parameter `clip` which defaults to `true`.
- Changed the `dontSelect` parameter of `UndoManager.undo` and `redo` to a named 
optional parameter `select` which defaults to `true`.
- Changed the `cursorPos` parameter of `Editor.setValue` to a named optional
parameter `cursorPosition` which defaults to `0` (select all) and documented the
method.

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
