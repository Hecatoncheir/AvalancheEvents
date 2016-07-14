library stream_service;

import 'dart:async';

//Mixins
part 'src/notify_mixin.dart';
part 'src/observable_mixin.dart';
part 'src/subscription_mixin.dart';

class StreamService extends Object with NotifyMixin, ObservableMixin {
  StreamController controller;
  Stream stream;

  StreamService() {
    controller = new StreamController();
    stream = controller.stream.asBroadcastStream();
  }
}
