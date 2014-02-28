// We do not check user agent because we run javascript in Dartium content_shell
var script = document.createElement('script');
script.type = 'text/javascript';
script.src = 'ace_test.dart.js';
script.addEventListener('error', function() {
  script = document.createElement('script');
  script.type = 'application/dart';
  script.src = 'ace_test.dart';
  document.body.appendChild(script);
});
document.body.appendChild(script);
