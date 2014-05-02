library ace;

import 'dart:async';

part 'src/anchor.dart';
part 'src/annotation.dart';
part 'src/command.dart';
part 'src/command_manager.dart';
part 'src/delta.dart';
part 'src/disposable.dart';
part 'src/document.dart';
part 'src/editor.dart';
part 'src/edit_session.dart';
part 'src/fold.dart';
part 'src/fold_line.dart';
part 'src/folding.dart';
part 'src/implementation.dart';
part 'src/keyboard_handler.dart';
part 'src/key_binding.dart';
part 'src/language_tools.dart';
part 'src/marker.dart';
part 'src/mode.dart';
part 'src/options_provider.dart';
part 'src/placeholder.dart';
part 'src/point.dart';
part 'src/range.dart';
part 'src/range_list.dart';
part 'src/search.dart';
part 'src/selection.dart';
part 'src/text_input.dart';
part 'src/theme.dart';
part 'src/undo_manager.dart';
part 'src/virtual_renderer.dart';

/// The current [Implementation].
/// 
/// This must be set by the user prior to making any other calls to this 
/// library.  This will typically be set in a `main` function or other 
/// bootstrapping logic.  For example:
/// 
///     import 'package:ace/ace.dart' as ace;
///     import 'package:ace/proxy.dart';
///
///     main() {
///       ace.implementation = ACE_PROXY_IMPLEMENTATION;
///       ...
///     }
///     
/// This library delegates to the implementation, to allow for multiple 
/// implementations including mocks for console-based testing.
Implementation implementation;

/// Creates a new [EditSession] with the given [text] and language [mode].
EditSession createEditSession(String text, Mode mode) {
  assert(text != null);
  assert(mode != null);
  return implementation.createEditSession(text, mode);
}

/// Embed an Ace [Editor] instance into the DOM, at the given [element].
Editor edit(element) {
  assert(element != null);
  return implementation.edit(element);
}

/// Loads the module for the given [modulePath].
/// 
/// The [modulePath] is a path such as `ace/ext/language_tools`.
require(String modulePath) => implementation.require(modulePath);
