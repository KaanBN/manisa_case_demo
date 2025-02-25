import 'package:json_annotation/json_annotation.dart';
import 'package:manisa_case/data/models/message_model.dart';
import 'package:manisa_case/data/models/user_model.dart';
import 'package:manisa_case/domain/entities/chat.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final int id;
  @JsonKey(name: "otherUser")
  final UserModel otherUser;
  @JsonKey(name: "lastMessage")
  final MessageModel lastMessage;

  ChatModel({required this.id, required this.otherUser, required this.lastMessage});

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  Chat toEntity() => Chat(
      id: id,
      otherUser: otherUser.toEntity(),
      lastMessage: lastMessage.toEntity()
  );
}