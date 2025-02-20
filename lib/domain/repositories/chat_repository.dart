import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/chat.dart';

abstract class ChatRepository {
  Future<Either<Exception, List<Chat>>> getChats();
}