# Ace.dart

[Dart language][dart] bindings for [Ace][ace].

[![Build Status](https://drone.io/github.com/rmsmith/ace.dart/status.png)][badge]

## Documentation

Please consult our [API documentation][api] as well as the 
[Ace API reference][ace-api].

## Ace.js

This package maintains a copy of the latest version (`src-min-noconflict`) of 
[ace-builds][] in the `lib/src/js/` directory, governed by its own 
[LICENSE][ace-license].  The javascript releases occur approximately once per 
month, and the version currently in use by this package is maintained in the 
version string metadata.  For example, in `ace.dart` version `0.0.4+9.11.2013` 
we provide a copy of `ace-builds` version `9.11.2013`.

For the integration of `ace.js` showstopping bug fixes, please open an issue or 
send a pull request and it will receive careful consideration.  Also note that
you may choose to use a newer version of `ace.js` in your html without requiring
any change to this package:

```html
<script type="text/javascript" charset="utf-8" src="path/to/your/ace.js">
</script>
```

As long as the version of `ace.js` you use is compatible in public interfaces 
with the latest released version, the `ace.dart` wrapper code should continue 
to work.

_Ace.dart uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

_Ace.js uses a BSD license as described in its own [LICENSE][ace-license] file._

[ace]: http://ace.ajax.org/
[ace-api]: http://ace.ajax.org/#nav=api
[ace-builds]: https://github.com/ajaxorg/ace-builds/
[ace-license]: https://github.com/rmsmith/ace.dart/blob/master/lib/src/js/LICENSE
[api]: http://rmsmith.github.com/ace.dart/ace.html
[badge]: https://drone.io/github.com/rmsmith/ace.dart/latest
[dart]: http://www.dartlang.org/
[license]: https://github.com/rmsmith/ace.dart/blob/master/LICENSE
[semantic versioning]: http://semver.org/
