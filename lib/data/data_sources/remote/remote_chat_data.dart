import 'package:dartz/dartz.dart';
import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/models/chat_model.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';
import 'package:manisa_case/domain/entities/message.dart';

class RemoteChatDataSource {
  final ApiClient apiClient;

  RemoteChatDataSource({required this.apiClient});

  Future<Either<Exception, List<ChatModel>>> fetchChats() async {
    try {
      final response = await apiClient.dio.get(
        "/chat/list",
      );

      final List<dynamic> data = response.data;
      final chats = data.map((json) => ChatModel.fromJson(json)).toList();
      return Right(chats);
    } catch (e) {
      return Left(Exception("Mesajlar alınamadı: ${e.toString()}"));
    }
  }

  Future<Either<Exception, ChatDetailModel>> fetchChatMessages(int chatId) async {
    try {
      final response = await apiClient.dio.get(
        "/chat/$chatId",
      );

      final data = response.data;
      final chatDetail = ChatDetailModel.fromJson(data);
      return Right(chatDetail);
    } catch (e) {
      return Left(Exception("Chat detayları alınırken hata: ${e.toString()}"));
    }
  }

  Future<Either<Exception, Message>> sendFakeMessage(Message message) async {
    try {
      message.updateStatus(status: MessageStatus.sending);
      await Future.delayed(const Duration(seconds: 1));
      return Right(message);
    }
    catch (e) {
      return Left(Exception("Unexpected error while sending message."));
    }
  }
}