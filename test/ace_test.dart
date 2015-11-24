library ace.test;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'src/anchor_test.dart' as anchor;
import 'src/command_manager_test.dart' as command_manager;
import 'src/config_test.dart' as config;
import 'src/document_test.dart' as document;
import 'src/editor_test.dart' as editor;
import 'src/edit_session_test.dart' as edit_session;
import 'src/keyboard_handler_test.dart' as keyboard_handler;
import 'src/language_tools_test.dart' as language_tools;
import 'src/mode_test.dart' as mode;
import 'src/point_test.dart' as point;
import 'src/range_list_test.dart' as range_list;
import 'src/range_test.dart' as range;
import 'src/require_test.dart' as require;
import 'src/search_test.dart' as search;
import 'src/selection_test.dart' as selection;
import 'src/theme_test.dart' as theme;
import 'src/virtual_renderer_test.dart' as virtual_renderer;

main() {
  useHtmlEnhancedConfiguration();
    
  group('anchor', () {
    setUp(anchor.setup);
    test("testAnchorCtor", anchor.testAnchorCtor);
  });
  
  group('command_manager', () {
    setUp(command_manager.setup);
    test("testCtor", command_manager.testCtor);
    test("testRemoveCommand", command_manager.testRemoveCommand);
    test("testAddCommand", command_manager.testAddCommand);
    test("testAddCommandSameName", command_manager.testAddCommandSameName);
    test("testExec", command_manager.testExec);
  }); 
  
  group('config', () {
    setUp(config.setup);
    test("testGetConfig", config.testGetConfig);
    test("testSetModuleUrl", config.testSetModuleUrl);
  });
  
  group('document', () {
    setUp(document.setup);
    test("testGetLength", document.testGetLength);
    test("testGetAllLines", document.testGetAllLines);
    test("testGetLines", document.testGetLines);
    test("testGetLine", document.testGetLine);
    test("testIndexToPosition", document.testIndexToPosition);
    test("testInsert", document.testInsert);
    test("testInsertInLine", document.testInsertInLine);
    test("testInsertLines", document.testInsertLines);
    test("testInsertNewLine", document.testInsertNewLine);
    test("testIsNewLine", document.testIsNewLine);
    test("testNewLineMode", document.testNewLineMode);
    test("testPositionToIndex", document.testPositionToIndex);
    test("testRemove", document.testRemove);
    test("testRemoveInLine", document.testRemoveInLine);
    test("testRemoveLines", document.testRemoveLines);
    test("testRemoveNewLine", document.testRemoveNewLine);
    test("testReplace", document.testReplace);
    test("testApplyDeltas", document.testApplyDeltas);
    test("testRevertDeltas", document.testRevertDeltas);
    test("testCreateAnchor", document.testCreateAnchor);
    test("testSplitTextContainsNewlineLiterals",
        document.testSplitTextContainsNewlineLiterals);
    test("testDocumentStartsWithNewline",
        document.testDocumentStartsWithNewline);
  });
  
  group('editor', () {
    setUp(editor.setup);
    tearDown(editor.teardown);
    test("testEditElement", editor.testEditElement);
    test("testBlur", editor.testBlur);
    test("testFocus", editor.testFocus);
    test("testValue", editor.testValue);
    test("testBlockIndent", editor.testBlockIndent);
    test("testBlockOutdent", editor.testBlockOutdent);
    test("testIndent", editor.testIndent);
    test("testFirstVisibleRow", editor.testFirstVisibleRow);
    test("testLastVisibleRow", editor.testLastVisibleRow);
    test("testInsert", editor.testInsert);
    test("testNavigateDown", editor.testNavigateDown);
    test("testNavigateFileEnd", editor.testNavigateFileEnd);
    test("testNavigateFileStart", editor.testNavigateFileStart);
    test("testNavigateLeft", editor.testNavigateLeft);
    test("testNavigateLineEnd", editor.testNavigateLineEnd);
    test("testNavigateLineStart", editor.testNavigateLineStart);
    test("testNavigateRight", editor.testNavigateRight);
    test("testNavigateTo", editor.testNavigateTo);
    test("testNavigateUp", editor.testNavigateUp);
    test("testNavigateWordLeft", editor.testNavigateWordLeft);
    test("testNavigateWordRight", editor.testNavigateWordRight);
    test("testRemoveToLineEnd", editor.testRemoveToLineEnd);
    test("testRemoveToLineStart", editor.testRemoveToLineStart);
    test("testRemoveWordLeft", editor.testRemoveWordLeft);
    test("testRemoveWordRight", editor.testRemoveWordRight);
    test("testPrintMarginColumn", editor.testPrintMarginColumn);
    test("testSetShowPrintMargin", editor.testSetShowPrintMargin);
    test("testSetShowInvisibles", editor.testSetShowInvisibles);
    test("testSetTheme", editor.testSetTheme);
    test("testDragDelay", editor.testDragDelay);
    test("testFadeFoldWidgets", editor.testFadeFoldWidgets);
    test("testShowFoldWidgets", editor.testShowFoldWidgets);
    test("testScrollSpeed", editor.testScrollSpeed);
    test("testHighlightActiveLine", editor.testHighlightActiveLine);
    test("testHighlightGutterLine", editor.testHighlightGutterLine);
    test("testHighlightSelectedWord", editor.testHighlightSelectedWord);
    test("testSetOverwrite", editor.testSetOverwrite);
    test("testToggleOverwrite", editor.testToggleOverwrite);
    test("testSetSession", editor.testSetSession);
    test("testGetCopyText", editor.testGetCopyText);
    test("testFontSize", editor.testFontSize);
    test("testToLowerCase", editor.testToLowerCase);
    test("testToUpperCase", editor.testToUpperCase);
    test("testSetReadOnly", editor.testSetReadOnly);
    test("testUndoRedo", editor.testUndoRedo);
    test("testSelectAll", editor.testSelectAll);
    test("testClearSelection", editor.testClearSelection);
    test("testCopyLinesDown", editor.testCopyLinesDown);
    test("testCopyLinesUp", editor.testCopyLinesUp);
    test("testGetOption", editor.testGetOption);
    test("testGetOptions", editor.testGetOptions);
    test("testSetOption", editor.testSetOption);
    test("testSetOptions", editor.testSetOptions);
    test("testGetKeyBinding", editor.testGetKeyBinding);
    test("testSetKeyboardHandlerDefault", editor.testSetKeyboardHandlerDefault);
    test("testSetKeyboardHandlerEmacs", editor.testSetKeyboardHandlerEmacs);
    test("testSetKeyboardHandlerVim", editor.testSetKeyboardHandlerVim);
    test("testSetKeyBindingKeyboardHandlerDefault",
        editor.testSetKeyBindingKeyboardHandlerDefault);
    test("testSetKeyBindingKeyboardHandlerEmacs",
        editor.testSetKeyBindingKeyboardHandlerEmacs);
    test("testSetKeyBindingKeyboardHandlerVim",
        editor.testSetKeyBindingKeyboardHandlerVim);
    test("testTransposeLetters", editor.testTransposeLetters);
    test("testGotoLine", editor.testGotoLine);
    test("testPaste", editor.testPaste);
    test("testGetCommandManager", editor.testGetCommandManager);
    test("testExecCommand", editor.testExecCommand);
    test("testScrollToLine", editor.testScrollToLine);
    test("testScrollToRow", editor.testScrollToRow);
  });
  
  group('edit_session', () {
    setUp(edit_session.setup);
    test("testEditSessionCtor", edit_session.testEditSessionCtor);
    test("testCreateEditSession", edit_session.testCreateEditSession);
    test("testCreateEditSessionModeIsLoaded",
        edit_session.testCreateEditSessionModeIsLoaded);
    test("testDocument", edit_session.testDocument);
    test("testGetLength", edit_session.testGetLength);
    test("testGetTextRange", edit_session.testGetTextRange);
    test("testGetWordRange", edit_session.testGetWordRange);
    test("testValue", edit_session.testValue);
    test("testSetTabSize", edit_session.testSetTabSize);
    test("testUndoSelect", edit_session.testUndoSelect);
    test("testUseSoftTabs", edit_session.testUseSoftTabs);
    test("testIsTabStop", edit_session.testIsTabStop);
    test("testUseWrapMode", edit_session.testUseWrapMode);
    test("testSetWrapLimit", edit_session.testSetWrapLimit);
    test("testSetWrapLimitRange", edit_session.testSetWrapLimitRange);
    test("testSetWrapLimitRangeMin", edit_session.testSetWrapLimitRangeMin);
    test("testSetWrapLimitRangeMax", edit_session.testSetWrapLimitRangeMax);
    test("testAdjustWrapLimit", edit_session.testAdjustWrapLimit);
    test("testSetScrollLeft", edit_session.testSetScrollLeft);
    test("testSetScrollTop", edit_session.testSetScrollTop);
    test("testSetOverwrite", edit_session.testSetOverwrite);
    test("testToggleOverwrite", edit_session.testToggleOverwrite);
    test("testGetUndoManager", edit_session.testGetUndoManager);
    test("testNewLineMode", edit_session.testNewLineMode);
    test("testGetLine", edit_session.testGetLine);
    test("testGetAWordRange", edit_session.testGetAWordRange);
    test("testGetRowLength", edit_session.testGetRowLength);
    test("testScreenLength", edit_session.testScreenLength);
    test("testIndentRows", edit_session.testIndentRows);
    test("testInsert", edit_session.testInsert);
    test("testMoveLinesDown", edit_session.testMoveLinesDown);
    test("testMoveLinesUp", edit_session.testMoveLinesUp);
    test("testDocumentToScreenColumn", edit_session.testDocumentToScreenColumn);
    test("testDocumentToScreenRow", edit_session.testDocumentToScreenRow);
    test("testDuplicateLines", edit_session.testDuplicateLines);
    test("testRemove", edit_session.testRemove);
    test("testReplace", edit_session.testReplace);
    test("testGetAnnotations", edit_session.testGetAnnotations);
    test("testSetAnnotations", edit_session.testSetAnnotations);
    test("testClearAnnotations", edit_session.testClearAnnotations);
    test("testGetBreakpoints", edit_session.testGetBreakpoints);
    test("testSetBreakpoint", edit_session.testSetBreakpoint);
    test("testSetBreakpoints", edit_session.testSetBreakpoints);
    test("testSetBreakpointWithClassName",
        edit_session.testSetBreakpointWithClassName);
    test("testClearBreakpoint", edit_session.testClearBreakpoint);
    test("testClearBreakpoints", edit_session.testClearBreakpoints);
    test("testScreenToDocumentPosition",
        edit_session.testScreenToDocumentPosition);
    test("testAddFold", edit_session.testAddFold);
    test("testRemoveFold", edit_session.testRemoveFold);
    test("testAddBackMarker", edit_session.testAddBackMarker);
    test("testAddFrontMarker", edit_session.testAddFrontMarker);
    test("testRemoveBackMarker", edit_session.testRemoveBackMarker);
    test("testRemoveFrontMarker", edit_session.testRemoveFrontMarker);
    test("testGetOption", edit_session.testGetOption);
    test("testGetOptions", edit_session.testGetOptions);
    test("testSetOption", edit_session.testSetOption);
    test("testSetOptions", edit_session.testSetOptions);
    test("testGetTokenAt", edit_session.testGetTokenAt);
    test("testGetTokens", edit_session.testGetTokens);
  });
  
  group('keyboard_handler', () {
    setUp(keyboard_handler.setup);
    test("testEmacsHandler", keyboard_handler.testEmacsHandler);
    test("testVimHandler", keyboard_handler.testVimHandler);
  });
  
  group('language_tools', () {
    setUp(language_tools.setup);
    tearDown(language_tools.teardown);
    test("testAddCompleter", language_tools.testAddCompleter);
  });
  
  group('mode', () {
    setUp(mode.setup);
    test("testCreateModeNamed", mode.testCreateModeNamed);
    test("testCreateModeForFile", mode.testCreateModeForFile);
  });
  
  group('point', () {
    setUp(point.setup);
    test("testPointCtor", point.testPointCtor);
    test("testPointEquals", point.testPointEquals);
    test("testPointToString", point.testPointToString);
  });
  
  group('range_list', () {
    setUp(range_list.setup);
    test("testPointIndex", range_list.testPointIndex);
    test("testPointIndexExcludeEdges", range_list.testPointIndexExcludeEdges);
    test("testAdd", range_list.testAdd);
    test("testAddEmpty", range_list.testAddEmpty);
    test("testMerge", range_list.testMerge);
    test("testRemove", range_list.testRemove);
  });
  
  group('range', () {
    setUp(range.setup);
    test("testRangeCtor", range.testRangeCtor);
    test("testRangeFromPointsCtor", range.testRangeFromPointsCtor);
    test("testRangeEquals", range.testRangeEquals);
    test("testRangeToString", range.testRangeToString);
    test("testRangeIsEmpty", range.testRangeIsEmpty);
    test("testRangeIsMultiLine", range.testRangeIsMultiLine);
    test("testCompare", range.testCompare);
    test("testOverlappingRangesIntersects",
        range.testOverlappingRangesIntersects);
    test("testTouchingRangesIntersect", range.testTouchingRangesIntersect);
    test("testAdjacentRangesDoNotIntersect",
        range.testAdjacentRangesDoNotIntersect);
    test("testIsEnd", range.testIsEnd);
    test("testIsStart", range.testIsStart);
    test("testContains", range.testContains);
    test("testContainsRange", range.testContainsRange);
    test("testUnionConstructor", range.testUnionConstructor);
  });
  
  group('require', () {
    setUp(require.setup);
    test("testRequireLanguageTools", require.testRequireLanguageTools);
  });
  
  group('search', () {
    setUp(search.setup);
    test("testSearchCtor", search.testSearchCtor);
    test("testSetOptions", search.testSetOptions);
    test("testFind", search.testFind);
    test("testFindMissingNeedle", search.testFindMissingNeedle);
    test("testFindCaseSensitive", search.testFindCaseSensitive);
    test("testFindStartAfterNeedle", search.testFindStartAfterNeedle);
    test("testFindBackwards", search.testFindBackwards);
    test("testFindAll", search.testFindAll);
    test("testFindAllWholeWord", search.testFindAllWholeWord);
    test("testFindAllMissingNeedle", search.testFindAllMissingNeedle);
  });
  
  group('selection', () {
    setUp(selection.setup);
    test("testSelectionCtor", selection.testSelectionCtor);
    test("testGetLineRange", selection.testGetLineRange);
    test("testMoveCursorBy", selection.testMoveCursorBy);
    test("testMoveCursorByNegative", selection.testMoveCursorByNegative);
    test("testMoveCursorDown", selection.testMoveCursorDown);
    test("testMoveCursorFileEnd", selection.testMoveCursorFileEnd);
    test("testMoveCursorFileStart", selection.testMoveCursorFileStart);
    test("testMoveCursorLeft", selection.testMoveCursorLeft);
    test("testMoveCursorLineEnd", selection.testMoveCursorLineEnd);
    test("testMoveCursorLineStart", selection.testMoveCursorLineStart);
    test("testMoveCursorRight", selection.testMoveCursorRight);
    test("testMoveCursorTo", selection.testMoveCursorTo);
    test("testMoveCursorToScreen", selection.testMoveCursorToScreen);
    test("testMoveCursorUp", selection.testMoveCursorUp);
    test("testMoveCursorWordLeft", selection.testMoveCursorWordLeft);
    test("testMoveCursorWordRight", selection.testMoveCursorWordRight);
    test("testSelectAll", selection.testSelectAll);
    test("testSelectAWord", selection.testSelectAWord);
    test("testSelectDown", selection.testSelectDown);
    test("testSelectFileEnd", selection.testSelectFileEnd);
    test("testSelectFileStart", selection.testSelectFileStart);
    test("testSelectLeft", selection.testSelectLeft);
    test("testSelectLine", selection.testSelectLine);
    test("testSelectLineEnd", selection.testSelectLineEnd);
    test("testSelectLineStart", selection.testSelectLineStart);
    test("testSelectRight", selection.testSelectRight);
    test("testSelectTo", selection.testSelectTo);
    test("testSelectUp", selection.testSelectUp);
    test("testSelectWord", selection.testSelectWord);
    test("testSelectWordLeft", selection.testSelectWordLeft);
    test("testSelectWordRight", selection.testSelectWordRight);
  });
  
  group('theme', () {
    setUp(theme.setup);
    test("testCreateThemeNamed", theme.testCreateThemeNamed);
  });
  
  group('virtual_renderer', () {
    setUp(virtual_renderer.setup);
    tearDown(virtual_renderer.teardown);
    test("testConstructor", virtual_renderer.testConstructor);
    test("testGetContainerElement", virtual_renderer.testGetContainerElement);
    test("testFixedWidthGutter", virtual_renderer.testFixedWidthGutter);
    test("testGetMouseEventTarget", virtual_renderer.testGetMouseEventTarget);
    test("testPrintMarginColumn", virtual_renderer.testPrintMarginColumn);
    test("testShowGutter", virtual_renderer.testShowGutter);
    test("testGetOption", virtual_renderer.testGetOption);
    test("testGetOptions", virtual_renderer.testGetOptions);
    test("testSetOption", virtual_renderer.testSetOption);
    test("testSetOptions", virtual_renderer.testSetOptions);
    test("testTextToScreenCoordinates",
        virtual_renderer.testTextToScreenCoordinates);
    test("testLineHeight", virtual_renderer.testLineHeight);
  });
  
}
