# Ace.dart

[Dart language][dart] bindings for [Ace][ace].

[![Build Status](https://drone.io/github.com/rmsmith/ace.dart/status.png)][badge]

## Documentation

Please consult our [API documentation][api] as well as the 
[Ace API reference][ace-api].

## Usage

```dart
import 'dart:html';
import 'package:ace/ace.dart' as ace;

main() {
  var editor = ace.edit(query('#editor'))
      ..theme = "ace/theme/monokai"
      ..session.setMode("ace/mode/dart");
}
```

## Goals

- 100% of the public API exposed and documented in Dart.
- 100% unit test coverage.
- Minimize code size of the library and avoid external dependencies.

_Ace.dart uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

[ace]: http://ace.ajax.org/
[ace-api]: http://ace.ajax.org/#nav=api
[ace-builds]: https://github.com/ajaxorg/ace-builds/
[api]: http://rmsmith.github.com/ace.dart/ace.html
[badge]: https://drone.io/github.com/rmsmith/ace.dart/latest
[dart]: http://www.dartlang.org/
[license]: https://github.com/rmsmith/fields/blob/master/LICENSE
[semantic versioning]: http://semver.org/
