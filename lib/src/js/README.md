# Ace.js

This directory contains a copy of [ace-builds][] `src-min-noconflict` as well as
a copy of the [LICENSE][ace-license] for the code.

The javascript releases occur approximately once per month, and the version 
currently in use by this package is maintained in the version string 
metadata.  For example, in `ace.dart` version `0.0.4+9.11.2013` we provide a 
copy of `ace-builds` version `9.11.2013`.

Please note that you may choose to use a different version of `ace.js` in your 
html without requiring any change to this package:

```html
<script type="text/javascript" charset="utf-8" src="path/to/your/ace.js">
</script>
```

As long as the version of `ace.js` you use is compatible with the version in 
this directory, the Dart wrapper code should continue to function.

[ace-builds]: https://github.com/ajaxorg/ace-builds/
[ace-license]: https://github.com/rmsmith/ace.dart/blob/master/lib/src/js/LICENSE
