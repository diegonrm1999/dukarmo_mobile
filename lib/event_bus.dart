import 'dart:async';

import 'package:dukarmo_app/enums/event_type.dart';

class OrderEventBus {
  static final _controller = StreamController<EventType>.broadcast();

  static Stream<EventType> get stream => _controller.stream;

  static void dispose() {
    _controller.close();
  }

  static void notifyNewOrderCreated(EventType eventType) {
    _controller.add(eventType);
  }
}
