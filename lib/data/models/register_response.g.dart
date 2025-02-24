// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      message: json['message'] as String,
      user: UserModel.fromJson(json['userData'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userData': instance.user,
      'token': instance.token,
    };
