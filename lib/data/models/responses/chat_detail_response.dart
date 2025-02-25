import 'package:json_annotation/json_annotation.dart';
import 'package:manisa_case/data/models/message_model.dart';
import 'package:manisa_case/data/models/user_model.dart';
import 'package:manisa_case/domain/entities/chat_detail.dart';

part 'chat_detail_response.g.dart';

@JsonSerializable()
class ChatDetailModel {
  final int id;
  @JsonKey(name: "otherUser")
  final UserModel otherUser;
  @JsonKey(name: "messages")
  final List<MessageModel> messages;

  ChatDetailModel({
    required this.id,
    required this.otherUser,
    required this.messages,
  });

  factory ChatDetailModel.fromJson(Map<String, dynamic> json) => _$ChatDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatDetailModelToJson(this);

  ChatDetail toEntity() => ChatDetail(
    id: id,
    otherUsername: otherUser.username,
    otherUserProfileImage: otherUser.profileImage.imageUrl,
    messages: messages.map((msg) => msg.toEntity()).toList(),
  );
}
