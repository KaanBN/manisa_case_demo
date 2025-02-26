import 'dart:async';

import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/remote/remote_chat_data.dart';
import 'package:manisa_case/data/data_sources/websocket/websocket_service.dart';
import 'package:manisa_case/data/models/message_model.dart';
import 'package:manisa_case/data/repositories/chat_repositiry_impl.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/domain/use_cases/get_chats_usecase.dart';
import 'package:manisa_case/presentation/providers/websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final chatDataSourceProvider = Provider<RemoteChatDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final webSocketService = ref.read(websocketProvider);
  return RemoteChatDataSource(apiClient: apiClient, webSocketService: webSocketService);
});

final chatRepositoryProvider = Provider<ChatRepositoryImpl>((ref) {
  final datasource = ref.read(chatDataSourceProvider);
  return ChatRepositoryImpl(datasource);
});

final getChatsUseCaseProvider = Provider<GetChatsUseCase> ((ref) {
  final repo = ref.read(chatRepositoryProvider);
  return GetChatsUseCase(repo);
});

@Riverpod(keepAlive: true)
class ChatNotifier extends _$ChatNotifier {
  late StreamSubscription _subscription;

  @override
  Future<List<Chat>> build() async {
    final webSocketService = ref.read(websocketProvider);

    _subscription = webSocketService.messageStream.listen((data) {
      if (data['type'] == 'message') {
        _handleNewMessage(data['message']);
      }
    });

    ref.onDispose(() {
      _subscription.cancel();
    });

    final getChatsUseCase = ref.read(getChatsUseCaseProvider);
    final result = await getChatsUseCase();
    return result.fold(
          (error) => throw error,
          (chats) {
        return chats.map((chatModel) {
          return chatModel.toEntity();
        }).toList();
      },
    );
  }

  void sendMessage(int recipientId, String content, int localId) {
    final webSocketService = ref.read(websocketProvider);
    webSocketService.sendMessage(recipientId, content, localId);
  }

  Future<void> refreshChats() async {
    state = const AsyncValue.loading();
    try {
      final getChatsUseCase = ref.read(getChatsUseCaseProvider);
      final result = await getChatsUseCase();
      state = result.fold(
            (error) => AsyncValue.error(error, StackTrace.current),
            (chats) => AsyncValue.data(chats.map((c) => c.toEntity()).toList()),
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void _handleNewMessage(Map<String, dynamic> messageData) {
    final message = MessageModel.fromJson(messageData);

    state.whenData((chats){
      final chatIndex = chats.indexWhere((chat) =>
      chat.id == message.conversationId);

      if(chatIndex >= 0){
        final updatedChat = chats[chatIndex].updateLastMessage(
          message.toEntity()
        );

        final updatedChats = List<Chat>.from(chats);
        updatedChats[chatIndex] = updatedChat;

        if (chatIndex > 0) {
          updatedChats.removeAt(chatIndex);
          updatedChats.insert(0, updatedChat);
        }

        state = AsyncValue.data(updatedChats);
      }
      else {
        refreshChats();
      }
    });
  }
}