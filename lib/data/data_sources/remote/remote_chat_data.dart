import 'package:dartz/dartz.dart';
import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/websocket/websocket_service.dart';
import 'package:manisa_case/data/models/chat_model.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';

class RemoteChatDataSource {
  final ApiClient apiClient;
  final WebSocketService webSocketService;

  RemoteChatDataSource({required this.apiClient, required this.webSocketService});

  Future<Either<Exception, List<ChatModel>>> fetchChats() async {
    try {
      final response = await apiClient.dio.get(
        "/chat/list",
      );

      final List<dynamic> data = response.data;
      final chats = data.map((json) {
        return ChatModel.fromJson(json);
      }).toList();
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

  void sendMessage(int recipientId, String content, int localId) async {
    webSocketService.sendMessage(recipientId, content, localId);
  }
}