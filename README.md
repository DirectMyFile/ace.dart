# Ace.dart

A [Dart][dart] wrapper for [Ace][ace].

[![Build Status](https://drone.io/github.com/rmsmith/ace.dart/status.png)][badge]

## Status

This project is in its wee infancy.

## Agenda

The plan for this project is to implement a thin wrapper around [ace-builds][].  

Until the Dart vm lands in a stable version of Chrome there is no compelling 
reason to re-write large portions in Dart code.  By maintaining a thin wrapper 
to the javascript, we benefit from all of the wonderful contributions to Ace.js.

## Note to Contributors

This project is not a toy, as I am using this in an application which I plan to
publish.  I am very open to contributions, but be forewarned that I will provide
a lot of constructive criticism and that I expect lots of unit tests.  I have 
no interest in building a framework or integrating unnecessary dependencies.

_Ace.dart uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

[ace]: http://ace.ajax.org/
[ace-builds]: https://github.com/ajaxorg/ace-builds/
[badge]: https://drone.io/github.com/rmsmith/ace.dart/latest
[dart]: http://www.dartlang.org/
[license]: https://github.com/rmsmith/fields/blob/master/LICENSE
[semantic versioning]: http://semver.org/
