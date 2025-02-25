import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manisa_case/core/constants/constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final _messageStreamController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get messageStream => _messageStreamController.stream;

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

        try {
          final data = jsonDecode(message);
          _messageStreamController.add(data);
        } catch (e) {
          print("Mesaj ayrıştırma hatası: $e");
        }
      },
      onError: (error) {
        print("WebSocket Hatası: $error");
      },
      onDone: () {
        print("WebSocket Bağlantısı Kapandı");
      },
    );
  }

  void sendMessage(int recipientId, String content, int localId) {
    if (_channel == null) {
      print("WebSocket bağlı değil!");
      return;
    }

    _channel!.sink.add(jsonEncode({
      'type': 'message',
      'recipientId': recipientId,
      'content': content,
      'localId': localId
    }));
  }

  void disconnect() {
    _channel?.sink.close();
  }

  void dispose() {
    disconnect();
    _messageStreamController.close();
  }
}