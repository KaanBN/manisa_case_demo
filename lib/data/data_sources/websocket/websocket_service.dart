import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manisa_case/core/constants/constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> connect() async {
    final token = await _secureStorage.read(key: "auth_token");
    if (token == null) return;

    _channel = IOWebSocketChannel.connect(
      "ws://$BASE_IP:8001",
      headers: {
        "sec-websocket-protocol": token
      }
    );

    _channel?.stream.listen(
      (message) {
        print("Yeni mesaj: $message");
      },
      onError: (error) {
        print("WebSocket Hatası: $error");
      },
      onDone: () {
        print("WebSocket Bağlantısı Kapandı");
      },
    );
  }

  void disconnect() {
    _channel?.sink.close();
  }
}