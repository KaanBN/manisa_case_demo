import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/remote/remote_chat_data.dart';
import 'package:manisa_case/data/repositories/chat_repositiry_impl.dart';
import 'package:manisa_case/domain/entities/chat_detail.dart';
import 'package:manisa_case/domain/use_cases/get_chat_detail_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_detail_provider.g.dart';

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

final getChatDetailsUseCaseProvider = Provider<GetChatDetailsUseCase>((ref) {
  final repo = ref.read(chatRepositoryProvider);
  return GetChatDetailsUseCase(repo);
});

@Riverpod()
class ChatDetailNotifier extends _$ChatDetailNotifier {
  @override
  Future<ChatDetail> build(int chatId) async {
    final getChatDetailsUseCase = ref.read(getChatDetailsUseCaseProvider);
    final result = await getChatDetailsUseCase(this.chatId);
    return result.fold(
          (error) => throw error,
          (data) => data.toEntity(),
    );
  }
}