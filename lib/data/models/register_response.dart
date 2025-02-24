import 'package:json_annotation/json_annotation.dart';
import 'package:manisa_case/data/models/user_model.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "userData")
  final UserModel user;
  @JsonKey(name: "token")
  final String token;

  RegisterResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}