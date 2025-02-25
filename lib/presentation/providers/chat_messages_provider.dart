import 'dart:async';

import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/remote/remote_chat_data.dart';
import 'package:manisa_case/data/data_sources/websocket/websocket_service.dart';
import 'package:manisa_case/data/models/message_model.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';
import 'package:manisa_case/data/repositories/chat_repositiry_impl.dart';
import 'package:manisa_case/domain/entities/chat_detail.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/entities/profile_image.dart';
import 'package:manisa_case/domain/entities/user.dart';
import 'package:manisa_case/domain/use_cases/get_chat_detail_usecase.dart';
import 'package:manisa_case/domain/use_cases/send_message_usecase.dart';
import 'package:manisa_case/presentation/providers/auth_provider.dart';
import 'package:manisa_case/presentation/providers/websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_messages_provider.g.dart';

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

final getMessagesUseCaseProvider = Provider<GetChatDetailsUseCase>((ref) {
  return GetChatDetailsUseCase(ref.read(chatRepositoryProvider));
});

final sendMessageUseCaseProvider = Provider<SendMessageUseCase>((ref) {
  return SendMessageUseCase(ref.read(chatRepositoryProvider));
});

@riverpod
class ChatMessagesNotifier extends _$ChatMessagesNotifier {
  int chatId = -1;
  late StreamSubscription _subscription;

  void setChatId(int id) {
    chatId = id;
    ref.invalidateSelf();
  }

  @override
  Future<ChatDetail> build() async {
    final webSocketService = ref.read(websocketProvider);

    if (chatId == -1) {
      return ChatDetail(id: 0, otherUser: User(id: 0, username: "asd", email: "asd", profileImage: ProfileImage(id: 0, imageUrl: "asd", userId: 0)), messages: []);
    }

    _subscription = webSocketService.messageStream.listen((data) {
      if (data['type'] == 'message-sent') {
        _handleMessageSent(data['message']);
      }
    });

    final getMessagesUseCase = ref.read(getMessagesUseCaseProvider);
    final result = await getMessagesUseCase(chatId);
    return result.fold(
          (error) => throw error,
          (chatDetail) => chatDetail.toEntity(),
    );
  }

  void _handleMessageSent(Map<String, dynamic> messageData) {
    print("messageData: $messageData");
    final message = MessageModel.fromJson(messageData);
    final currentState = state;

    if (currentState is AsyncData<ChatDetail>) {
      final updatedMessages = currentState.value.messages.map((msg) {
        if (msg.id == message.localId) {
          return msg.updateStatus(status: MessageStatus.sent);
        }
        return msg;
      }).toList();


      state = AsyncValue.data(currentState.value.updateMessages(updatedMessages) );
    }
  }

  Future<void> sendMessage(int recipientId, String content) async {
    final sendMessageUseCase = ref.read(sendMessageUseCaseProvider);
    final authState = ref.watch(authProvider);
    final currentUserId = authState.value!.id;
    final localId = DateTime.now().millisecondsSinceEpoch;

    final tempMessage = Message(
      id: localId,
      senderId: currentUserId,
      status: MessageStatus.sending,
      message: content,
      createdAt: DateTime.now(),
    );

    final currentState = state;
    if (currentState is AsyncData<ChatDetail>) {
      state = AsyncValue.data(
        currentState.value.updateMessages([...currentState.value.messages, tempMessage])
      );
    }

    sendMessageUseCase.call(chatId, content, localId);
  }
}
