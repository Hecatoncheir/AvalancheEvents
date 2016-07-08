library stream_service_mixin;

class StreamServiceMixin {
    Stream stream;
  StreamController controller;
  List<StreamService> observers;
  List<StreamService> observables;
  
  /// check
  observable(StreamService stream) {
    if (!observers.contains(stream)) {
      observers.add(stream);
    }

    if (!stream.observables.contains(this)) {
      stream.observables.add(this);
    }
  }

  observe(StreamService stream) {
    if (!observables.contains(stream)) {
      observables.add(stream);
    }

    if (!stream.observers.contains(this)) {
      stream.observers.add(this);
    }
  }

  dispatchEvent(String message, [dynamic details]) {
    Map detail = new Map();
    detail['message'] = message;
    detail['details'] = details;
    controller.add(detail);

    observers.forEach((StreamService stream) {
      if (!observables.contains(stream)) {
        stream.controller.add(detail);
      }
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