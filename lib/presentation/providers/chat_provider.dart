import 'dart:async';

import 'package:manisa_case/data/repositories/chat_repositiry_impl.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/domain/use_cases/get_chats_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

final chatRepositoryProvider = Provider<ChatRepositoryImpl>( (ref) {
  return ChatRepositoryImpl();
});

final getChatsUseCaseProvider = Provider<GetChatsUseCase> ((ref) {
  final repo = ref.read(chatRepositoryProvider);
  return GetChatsUseCase(repo);
});

@Riverpod(keepAlive: true)
class ChatNotifier extends _$ChatNotifier {
  @override
  Future<List<Chat>> build() async {
    final getChatsUseCase = ref.read(getChatsUseCaseProvider);
    final result = await getChatsUseCase();
    return result.fold(
          (error) => throw error,
          (chats) => chats,
    );
  }
}