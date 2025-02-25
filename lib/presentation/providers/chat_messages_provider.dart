import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/remote/remote_chat_data.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';
import 'package:manisa_case/data/repositories/chat_repositiry_impl.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/use_cases/get_chat_detail_usecase.dart';
import 'package:manisa_case/domain/use_cases/send_message_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_messages_provider.g.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final chatDataSourceProvider = Provider<RemoteChatDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return RemoteChatDataSource(apiClient: apiClient);
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
  int chatId = 0;

  void setChatId(int id) {
    chatId = id;
    ref.invalidateSelf();
  }

  @override
  Future<ChatDetailModel> build() async {
    final getMessagesUseCase = ref.read(getMessagesUseCaseProvider);
    final result = await getMessagesUseCase(chatId);
    return result.fold(
          (error) => throw error,
          (chatDetail) => chatDetail,
    );
  }

  Future<void> sendMessage(String text) async {
    final sendMessageUseCase = ref.read(sendMessageUseCaseProvider);
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch,
      senderId: 1,
      status: MessageStatus.sending,
      message: 'deneme',
      createdAt: DateTime.now(),
    );

    state = AsyncValue.data([...state.value ?? [], newMessage]);
    final result = await sendMessageUseCase(newMessage);

    result.fold(
          (error) {
        state = AsyncValue.data([
          for (final message in state.value ?? [])
            if (message.id == newMessage.id)
              message.updateStatus(status: MessageStatus.failed)
            else
              message
        ]);
      },
          (sentMessage) {
        state = AsyncValue.data([
          for (final message in state.value ?? [])
            if (message.id == newMessage.id)
              message.updateStatus(status: MessageStatus.sent)
            else
              message
        ]);
      },
    );
  }
}
