import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manisa_case/data/data_sources/websocket/websocket_service.dart';

final websocketProvider = Provider<WebSocketService>((ref) {
  return WebSocketService();
});