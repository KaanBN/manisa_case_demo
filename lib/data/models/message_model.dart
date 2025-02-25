import 'package:json_annotation/json_annotation.dart';
import 'package:manisa_case/domain/entities/message.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "senderId")
  final int senderId;
  @JsonKey(name: "conversationId")
  final int? conversationId;
  @JsonKey(name: "localId")
  final int? localId;

  MessageModel({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.senderId,
    this.conversationId,
    this.localId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  Message toEntity() => Message(
    id: id,
    message: message,
    createdAt: createdAt,
    senderId: senderId,
    conversationId: conversationId,
    localId: localId
  );
}
