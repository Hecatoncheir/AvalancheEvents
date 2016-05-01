# stream_service
Observe/Observable stream

```dart
class ExampleService extends StreamService {
schema = new service.SchemaGenerator();
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
