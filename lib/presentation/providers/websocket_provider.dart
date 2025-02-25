import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manisa_case/data/data_sources/websocket/websocket_service.dart';

final websocketProvider = Provider<WebSocketService>((ref) {
  final websocketService = WebSocketService();
  websocketService.connect();

  AppLifecycleListener(
    onResume: () => websocketService.connect(),
    onPause: () => websocketService.disconnect(),
  );

  ref.onDispose(() {
    websocketService.disconnect();
  });

  return websocketService;
});
