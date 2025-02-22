import 'package:manisa_case/data/data_sources/fake/fake_chat_data.dart';
import 'package:manisa_case/data/repositories/chat_repositiry_impl.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/use_cases/get_chat_detail_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_detail_provider.g.dart';

final chatDataSourceProvider = Provider<FakeChatDataSource>((ref) {
  return FakeChatDataSource();
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
  Future<List<Message>> build(int chatId) async {
    final getChatDetailsUseCase = ref.read(getChatDetailsUseCaseProvider);
    final result = await getChatDetailsUseCase(this.chatId);
    return result.fold(
          (error) => throw error,
          (messages) => messages,
    );
  }
}