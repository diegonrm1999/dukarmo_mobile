import 'package:dukarmo_app/services/domain/socket.dart';

class SocketService {
  final Socket _socket = Socket();

  void init() {
    _socket.init();
  }

  void connect() {
    _socket.socket.connect();
  }

  void disconnect() {
    _socket.socket.disconnect();
  }

  void on(String event, Function(dynamic) callback) {
    _socket.socket.on(event, callback);
  }

  void off(String event) {
    _socket.socket.off(event);
  }

  void dispose() {
    _socket.dispose();
  }
}
