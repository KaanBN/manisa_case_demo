import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/message.dart';

abstract class ChatDetailRepository {
  Future<Either<Exception, List<Message>>> getChatMessages(int chatId);
}