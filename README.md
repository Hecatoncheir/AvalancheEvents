# Stream Service
- Library for decouple many objects
- Simple subscription on object events

```dart

library example_lib;

import 'package:stream_service/stream_service.dart';

class ExampleService extends StreamService {

    cache = new Cache();
    storage = new Storage();

    cache.observe(storage);
    cache.observable(storage);
    this.observe(cache);
    this.observable(storage);
    storage.observe(this);

    cache.on('from storage',(event){
     print('storage from');
    });

    storage.on('from cache',(event){
      print('cache from');
      storage.dispatchEvent('from storage');
    });

    on('from cache', (event){
      print(event);
    });

    cache.dispatchEvent('from cache');
}
```

Details
------
*GRASP* - [wiki](https://en.wikipedia.org/wiki/GRASP)
 - *Low coupling* - [wiki](https://en.wikipedia.org/wiki/GRASP#Low_coupling)

*Observer Design Pattern* - [sourcemaking](https://sourcemaking.com/design_patterns/observer)

*Mediator Design Pattern* - [sourcemaking](https://sourcemaking.com/design_patterns/mediator)