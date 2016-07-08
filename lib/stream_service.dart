library stream;

import 'dart:async';

import 'stream_service_mixin.dart';

class StreamService extends Object with StreamServiceMixin {
  Stream stream;
  StreamController controller;

  List<StreamService> observers;
  List<StreamService> observables;

  StreamService() {
    stream = controller.stream.asBroadcastStream();
    controller = new StreamController();

    observers = new List();
    observables = new List();
  }
}
