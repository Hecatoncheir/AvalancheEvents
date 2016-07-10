# Stream Service
- Stream for decouple many objects
- Simple subscription on object events

**All you need is stream**

[![Build Status](https://codeship.com/projects/d800fba0-28ea-0134-04f3-5a347c0ad183/status?branch=master
)](https://codeship.com/projects/d800fba0-28ea-0134-04f3-5a347c0ad183/status?branch=master
)

[Cloud9 - editor](https://ide.c9.io/rasart/stream_service)


```dart

library example_library;

import 'dart:async';

import 'package:stream_service/stream_service.dart';

/// Simple extend class
class BestClass extends StreamService {}
class OtherBestClass extends StreamService {}

void main() {
    BestClass bestClass = new BestClass();
    OtherBestClass otherBestClass = new OtherBestClass();
    
    bestClass.observable(otherBestClass);
    
    /// Just listen self stream
    otherBestClass.on('Event from bestClass', (bool eventData){
        print(eventData); // is true
    });
    
    bestClass.dispatchEvent('Event from bestClass', true);
}

```

Or if your class already have extends:
```dart
class OtherBestClass extends Object with ObservableMixin, NotifyMixin {

    /// Some stream and controller
    StreamController controller;
    Stream stream;
    
    /// For observable method
    var streamService;
    
    OtherBestClass(){
        streamService = this;
        
        controller = new StreamController();
        stream = controller.stream.asBroadcastStream();
    }
    
}

```

Details
------
*GRASP* - [wiki](https://en.wikipedia.org/wiki/GRASP)
 - *Low coupling* - [wiki](https://en.wikipedia.org/wiki/GRASP#Low_coupling)

*Observer Design Pattern* - [sourcemaking](https://sourcemaking.com/design_patterns/observer)

*Mediator Design Pattern* - [sourcemaking](https://sourcemaking.com/design_patterns/mediator)