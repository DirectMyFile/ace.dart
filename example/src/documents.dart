part of ace.kitchen_sink;

Element buildDocuments() {  
  final select = new SelectElement();
  for (String name in DOCUMENTS.keys) {
    final option = new OptionElement()
    ..text = name
    ..value = name;
    select.append(option);
  }
  select.value = ace.Mode.DART;
  select.onChange.listen((_) {
    editor.setValue(DOCUMENTS[select.value], -1);
    modesSelect.value = select.value;
  });
  final control = new DivElement()
  ..append(new SpanElement()..text = 'Document ')
  ..append(select)
  ..classes = ['control'];
  return control;
}

const Map<ace.Mode, String> DOCUMENTS = const {
  ace.Mode.CSS        : DOCUMENT_CSS,
  ace.Mode.DART       : DOCUMENT_DART,
  ace.Mode.HTML       : DOCUMENT_HTML,
  ace.Mode.JAVASCRIPT : DOCUMENT_JAVASCRIPT,
  ace.Mode.TYPESCRIPT : DOCUMENT_TYPESCRIPT
};

const String DOCUMENT_CSS =
r'''
.text-layer {
    font-family: Monaco, "Courier New", monospace;
    font-size: 12pX;
    cursor: text;
}

.blinker {
    animation-duration: 1s;
    animation-name: blink;
    animation-iteration-count: infinite;
    animation-direction: alternate;
    animation-timing-function: linear;
}

@keyframes blink {
    0% {
        opacity: 0;
    }
    40% {
        opacity: 0;
    }
    40.5% {
        opacity: 1
    }
    100% {
        opacity: 1
    }
}
''';

const String DOCUMENT_DART =
r'''
// Go ahead and modify this example.

import "dart:html";

// Computes the nth Fibonacci number.
int fibonacci(int n) {
  if (n < 2) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

// Displays a Fibonacci number.
void main() {
  int i = 20;
  String message = "fibonacci($i) = ${fibonacci(i)}";

  // This example uses HTML to display the result and it will appear
  // in a nested HTML frame (an iframe).
  document.body.append(new HeadingElement.h1()..appendText(message));
}
''';

const String DOCUMENT_HTML = 
r'''
<!DOCTYPE html>
<html>
    <head>

    <style type="text/css">
        .text-layer {
            font-family: Monaco, "Courier New", monospace;
            font-size: 12px;
            cursor: text;
        }
    </style>

    </head>
    <body>
        <h1 style="color:red">Juhu Kinners</h1>
    </body>
</html>
''';

const String DOCUMENT_JAVASCRIPT =
r'''
function foo(items, nada) {
    for (var i=0; i<items.length; i++) {
        alert(items[i] + "juhu\n");
    } // Real Tab.
}
''';

const String DOCUMENT_TYPESCRIPT =
r'''
class Greeter {
  greeting: string;
  constructor (message: string) {
    this.greeting = message;
  }
  greet() {
    return "Hello, " + this.greeting;
  }
}   

var greeter = new Greeter("world");

var button = document.createElement('button')
button.innerText = "Say Hello"
button.onclick = function() {
  alert(greeter.greet())
}

document.body.appendChild(button)

class Snake extends Animal {
   move() {
       alert("Slithering...");
       super(5);
   }
}

class Horse extends Animal {
   move() {
       alert("Galloping...");
       super.move(45);
   }
}

module Sayings {
    export class Greeter {
        greeting: string;
        constructor (message: string) {
            this.greeting = message;
        }
        greet() {
            return "Hello, " + this.greeting;
        }
    }
}
module Mankala {
   export class Features {
       public turnContinues = false;
       public seedStoredCount = 0;
       public capturedCount = 0;
       public spaceCaptured = NoSpace;

       public clear() {
           this.turnContinues = false;
           this.seedStoredCount = 0;
           this.capturedCount = 0;
           this.spaceCaptured = NoSpace;
       }

       public toString() {
           var stringBuilder = "";
           if (this.turnContinues) {
               stringBuilder += " turn continues,";
           }
           stringBuilder += " stores " + this.seedStoredCount;
           if (this.capturedCount > 0) {
               stringBuilder += " captures " + this.capturedCount + " from space " + this.spaceCaptured;
           }
           return stringBuilder;
       }
   }
}
''';
