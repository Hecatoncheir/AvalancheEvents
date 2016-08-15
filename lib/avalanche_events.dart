library avalanche_events;

import 'dart:async';

//Mixins
part 'src/notify_mixin.dart';
part 'src/observable_mixin.dart';
part 'src/subscription_mixin.dart';

class AvalancheEvents extends Object with NotifyMixin, ObservableMixin {
  StreamController controller;
  Stream stream;

  AvalancheEvents() {
    controller = new StreamController();
    stream = controller.stream.asBroadcastStream();
  }
}
