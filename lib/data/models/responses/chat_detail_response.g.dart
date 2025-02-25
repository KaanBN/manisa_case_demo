// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDetailModel _$ChatDetailModelFromJson(Map<String, dynamic> json) =>
    ChatDetailModel(
      id: (json['id'] as num).toInt(),
      otherUser: UserModel.fromJson(json['otherUser'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatDetailModelToJson(ChatDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'otherUser': instance.otherUser,
      'messages': instance.messages,
    };
