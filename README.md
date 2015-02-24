# Ace.dart

[Dart language][dart] bindings for the [Ace][ace] code editor.

[![Build Status][status]][status badge] [![Pub][pub badge]][pub] | 
[API][api] | [Demo][demo]

_Ace.dart uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

## Ace.js

This package maintains a copy of the latest [ace-builds][] `src-min-noconflict` 
governed by its own [LICENSE][ace-license].

The `ace-builds` occur approximately once per month, and the version currently 
in use by this package is maintained in the version string metadata.  For 
example, in `ace.dart` version `0.0.4+9.11.2013` we test against a copy of 
`ace-builds` version `9.11.2013`.

The version of `ace.js` in this package is for testing and examples _only_.  It
is no longer included in the `lib/` directory to provide the most flexibility to
applications.  You are responsible for including a version of `ace.js` in your 
application's html:

```html
<script type="text/javascript" charset="utf-8" src="path/to/your/ace.js">
</script>
```

As long as the version of `ace.js` you use is compatible (e.g. `src-noconflict` 
or `src-min-noconflict`), the Dart wrapper code should continue to function.

[ace]: http://ace.ajax.org/
[ace-builds]: https://github.com/ajaxorg/ace-builds/
[ace-license]: https://github.com/rmsmith/ace.dart/blob/master/js/LICENSE
[api]: http://www.dartdocs.org/documentation/ace/latest/
[dart]: http://www.dartlang.org/
[demo]: http://rmsmith.github.io/ace.dart/examples/kitchen_sink.html
[license]: https://github.com/rmsmith/ace.dart/blob/master/LICENSE
[pub]: https://pub.dartlang.org/packages/ace
[pub badge]: http://img.shields.io/pub/v/ace.svg
[semantic versioning]: http://semver.org/
[status]: https://drone.io/github.com/rmsmith/ace.dart/status.png
[status badge]: https://drone.io/github.com/rmsmith/ace.dart/latest
