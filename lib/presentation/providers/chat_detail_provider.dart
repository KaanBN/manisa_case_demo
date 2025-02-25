import 'dart:async';

import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/remote/remote_chat_data.dart';
import 'package:manisa_case/data/data_sources/websocket/websocket_service.dart';
import 'package:manisa_case/data/models/message_model.dart';
import 'package:manisa_case/data/repositories/chat_repositiry_impl.dart';
import 'package:manisa_case/domain/entities/chat_detail.dart';
import 'package:manisa_case/domain/use_cases/get_chat_detail_usecase.dart';
import 'package:manisa_case/presentation/providers/websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_detail_provider.g.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final chatDataSourceProvider = Provider<RemoteChatDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final webSocketService = ref.read(websocketProvider);
  return RemoteChatDataSource(
      apiClient: apiClient,
      webSocketService: webSocketService
  );
});

final chatRepositoryProvider = Provider<ChatRepositoryImpl>((ref) {
  final datasource = ref.read(chatDataSourceProvider);
  return ChatRepositoryImpl(datasource);
});

final getChatDetailsUseCaseProvider = Provider<GetChatDetailsUseCase>((ref) {
  final repo = ref.read(chatRepositoryProvider);
  return GetChatDetailsUseCase(repo);
});

@Riverpod()
class ChatDetailNotifier extends _$ChatDetailNotifier {
  late StreamSubscription _subscription;

  @override
  Future<ChatDetail> build(int chatId) async {
    final webSocketService = ref.read(websocketProvider);

    _subscription = webSocketService.messageStream.listen((data) {
      if (data['type'] == 'message') {
        _handleIncomingMessage(data['message']);
      }
    });

    ref.onDispose(() {
      _subscription.cancel();
    });

    final getChatDetailsUseCase = ref.read(getChatDetailsUseCaseProvider);
    final result = await getChatDetailsUseCase(this.chatId);
    return result.fold(
          (error) => throw error,
          (data) => data.toEntity(),
    );
  }

  void _handleIncomingMessage(Map<String, dynamic> messageData) {
    final message = MessageModel.fromJson(messageData);

    state.whenData((chats){

    });
  }
}