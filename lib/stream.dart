library stream;

import 'dart:async';

class StreamService {
  Stream stream;
  StreamController controller;
  List<StreamService> observers;
  List<StreamService> observables;

  StreamService() {
    controller = new StreamController();
    stream = controller.stream.asBroadcastStream();
    observers = new List();
    observables = new List();
  }

  observable(StreamService stream) {
    if (!observers.contains(stream)) {
      observers.add(stream);
    }
  }

  observe(StreamService stream) {
    if (!observables.contains(stream)) {
      observables.add(stream);
    }
  }

  dispatchEvent(String message, [dynamic details]) {
    Map detail = new Map();
    detail['message'] = message;
    detail['details'] = details;
    controller.add(detail);

    observers.forEach((StreamService stream) {
      stream.controller.add(detail);
    });

    observables.forEach((StreamService stream) {
      stream.controller.add(detail);
    });
  }

  on(String message, Function handler) {
    observables.forEach((StreamService streamService) {
      streamService.stream.listen((Map data) {
        if (data['message'] == message) {
          Map details = data['details'];
          handler(details);
        }
      });
    });

    observers.forEach((StreamService streamService) {
      streamService.stream.listen((Map data) {
        if (data['message'] == message) {
          Map details = data['details'];
          handler(details);
        }
      });
    });

    stream.listen((Map data) {
      if (data['message'] == message) {
        Map details = data['details'];
        handler(details);
      }
    });
  }
}
