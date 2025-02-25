// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileImageModel _$ProfileImageModelFromJson(Map<String, dynamic> json) =>
    ProfileImageModel(
      id: (json['id'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileImageModelToJson(ProfileImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
    };
