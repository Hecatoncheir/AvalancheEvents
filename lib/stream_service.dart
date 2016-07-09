library stream_service;

import 'dart:async';

//Mixins
part 'notify_mixin.dart';
part 'observable_mixin.dart';
part 'subscription_mixin.dart';

class StreamService extends Object with NotifyMixin, ObservableMixin {
  StreamController controller;
  Stream stream;
  StreamService streamService; // Нужен для observable миксина

  StreamService() {
    controller = new StreamController();
    stream = controller.stream.asBroadcastStream();
    streamService = this;
  }
}
