library stream;

import 'dart:async';

class StreamService {
  Stream _stream;
  StreamController _controller;
  List<StreamService> _observers;
  List<StreamService> _observables;

  StreamService() {
    _controller = new StreamController();
    _stream = _controller.stream.asBroadcastStream();
    _observers = new List();
    _observables = new List();
  }

  observable(StreamService stream){
    if (!_observers.contains(stream)){
      _observers.add(stream);
    }
  }

  observe(StreamService stream){
    if (!_observables.contains(stream)){
      _observables.add(stream);
    }
  }

  dispatchEvent(String message, [dynamic details]) {
    Map detail = new Map();
    detail['message'] = message;
    detail['details'] = details;
    _controller.add(detail);

    _observers.forEach((StreamService stream){
      stream._controller.add(detail);
    });
  }

  on(String message, Function handler) {
    _observables.forEach((StreamService streamService){
      streamService._stream.listen((Map data) {
        if (data['message'] == message) {
          Map details = data['details'];
          handler(details);
        }
      });
    });

    _stream.listen((Map data) {
      if (data['message'] == message) {
        Map details = data['details'];
        handler(details);
      }
    });
  }
}
