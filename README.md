# Ace.dart

A [Dart][dart] wrapper for [Ace][ace].

## Status

This project is in its wee infancy.

## Agenda

The plan for this project is to implement a tight wrapper around [ace-builds][] 
up until the 1.0 release of Dart.  Until the Dart vm lands in a stable version 
of Chrome there is no compelling reason to re-write large portions in Dart 
code.  By keeping only a thin wrapper to the javascript, we benefit from all of
the wonderful contributions to Ace.js.  Even after Dart 1.0 it will make sense
to keep large portions of the code in javascript, until that day of glory when
a majority of developers code in Dart :)

## Ominous Warning

This project is not a toy, as I am using this in an application which I plan to
publish.  I am very open to contributors, but be forewarned that I will provide
a lot of constructive criticism and that I expect lots of unit tests.  I have 
no interest in building a framework or integrating unnecessary dependencies.

_Ace.dart uses the MIT license as described in the [LICENSE][license] file, and 
follows [semantic versioning][]._

[ace]: http://ace.ajax.org/
[ace-builds]: https://github.com/ajaxorg/ace-builds/
[dart]: http://www.dartlang.org/
[license]: https://github.com/rmsmith/fields/blob/master/LICENSE
[semantic versioning]: http://semver.org/
