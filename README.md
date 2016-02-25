**I no longer use this code, so it has fallen into disrepair.  If you use this code and are interested in maintaining it please open an issue to let me know.**

# Ace.dart

Dart language bindings for the [Ace][ace] code editor.

_Ace.dart uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

## Ace.js

This package maintains a copy of the latest [ace-builds][] `src-min-noconflict` 
governed by its own [LICENSE][ace-license].

The `ace-builds` occur approximately once per month, and the version currently 
tested by this package is maintained in the version string metadata.  For 
example, in `ace.dart` version `0.0.4+9.11.2013` we test against a copy of 
`ace-builds` version `9.11.2013`.

The version of `ace.js` in this package is for testing and examples _only_.  It
is no longer included in the `lib/` directory to provide the most flexibility to
applications.  You are responsible for including a version of `ace.js` in your 
application's html:

```html
<script type="text/javascript" charset="utf-8" src="path/to/your/ace.js"></script>
```

As long as the version of `ace.js` you use is compatible (e.g. `src-noconflict` 
or `src-min-noconflict`), the Dart wrapper code should continue to function.

[ace]: http://ace.ajax.org/
[ace-builds]: https://github.com/ajaxorg/ace-builds/
[ace-license]: https://github.com/rmsmith/ace.dart/blob/master/js/LICENSE
[license]: https://github.com/rmsmith/ace.dart/blob/master/LICENSE
[semantic versioning]: http://semver.org/
