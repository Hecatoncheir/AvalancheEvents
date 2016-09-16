Avalanche events
================

-	Stream for decouple many objects
-	Simple subscription on object events
-	Work both, on client and server

**All you need is stream**

[![Build Status](https://travis-ci.org/Rasarts/AvalancheEvents.svg?branch=master)](https://travis-ci.org/Rasarts/AvalancheEvents)[![pub package](https://img.shields.io/pub/v/avalanche_events.svg?style=flat)](https://pub.dartlang.org/packages/avalanche_events)

[![c9](http://wiki.teamliquid.net/commons/images/thumb/f/fd/Cloud9.png/48px-Cloud9.png) - editor](https://ide.c9.io/rasart/avalanche_events)

```dart

library example_library;

import 'dart:async';

import 'package:avalanche_events/avalanche_events.dart';

/// Extend class
class BestClass extends AvalancheEvents {}
/// Or extend Object with mixins
class OtherBestClass extends Object with NotifyMixin, ObservableMixin {}

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

Details
-------

*GRASP* - [wiki](https://en.wikipedia.org/wiki/GRASP) - *Low coupling* - [wiki](https://en.wikipedia.org/wiki/GRASP#Low_coupling)

*Observer Design Pattern* - [sourcemaking](https://sourcemaking.com/design_patterns/observer)

*Mediator Design Pattern* - [sourcemaking](https://sourcemaking.com/design_patterns/mediator)
