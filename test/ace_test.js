var script = document.createElement('script');
script.type = 'application/dart';
script.src = 'ace_test.dart';  
script.addEventListener('error', function() {
  script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'ace_test.dart.js'; 
  document.body.appendChild(script);
});
document.body.appendChild(script);
