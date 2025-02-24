import 'package:json_annotation/json_annotation.dart';
import 'package:manisa_case/data/models/profile_image_model.dart';
import 'package:manisa_case/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String username;
  final String email;
  @JsonKey(name: "profile_image")
  final ProfileImageModel profileImage;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() {
    return User(
        id: id,
        username: username,
        email: email,
        profileImage: profileImage.toEntity()
    );
  }
}