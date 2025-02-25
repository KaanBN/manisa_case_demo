import 'package:json_annotation/json_annotation.dart';
import '../user_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String message;
  @JsonKey(name: "userData")
  final UserModel user;
  final String token;

  LoginResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
