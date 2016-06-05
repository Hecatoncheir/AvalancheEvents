# stream_service
Simple work with stream

```dart
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
