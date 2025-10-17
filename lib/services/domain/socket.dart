// ignore_for_file: library_prefixes

import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {
  late IO.Socket socket;

  void init() {
    socket = IO.io(
      'https://dukarmo.fly.dev',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
  }

  void dispose() {
    socket.dispose();
  }
}
