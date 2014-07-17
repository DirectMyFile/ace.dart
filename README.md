# Ace.dart

[Dart language][dart] bindings for the [Ace][ace] code editor.

[![Build Status][status]][badge] | [API][api] | [Demo][demo]

_Ace.dart uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

## Ace.js

This package maintains a copy of the latest [ace-builds][] `src-min-noconflict` 
governed by its own [LICENSE][ace-license].

The `ace-builds` occur approximately once per month, and the version currently 
in use by this package is maintained in the version string metadata.  For 
example, in `ace.dart` version `0.0.4+9.11.2013` we provide a copy of 
`ace-builds` version `9.11.2013`.

You may choose to use a different version of `ace.js` in your html without 
requiring any change to this package:

```html
<script type="text/javascript" charset="utf-8" src="path/to/your/ace.js">
</script>
```

As long as the version of `ace.js` you use is compatible, the Dart wrapper code
should continue to function.

[ace]: http://ace.ajax.org/
[ace-builds]: https://github.com/ajaxorg/ace-builds/
[ace-license]: https://github.com/rmsmith/ace.dart/blob/master/lib/src/js/LICENSE
[ace-readme]: https://github.com/rmsmith/ace.dart/blob/master/lib/src/js/README.md
[api]: http://dartdocs.org
[badge]: https://drone.io/github.com/rmsmith/ace.dart/latest
[dart]: http://www.dartlang.org/
[demo]: http://rmsmith.github.io/ace.dart/examples/kitchen_sink.html
[license]: https://github.com/rmsmith/ace.dart/blob/master/LICENSE
[semantic versioning]: http://semver.org/
[status]: https://drone.io/github.com/rmsmith/ace.dart/status.png
