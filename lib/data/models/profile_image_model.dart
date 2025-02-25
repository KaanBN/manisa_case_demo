import 'package:json_annotation/json_annotation.dart';
import 'package:manisa_case/domain/entities/profile_image.dart';

part 'profile_image_model.g.dart';

@JsonSerializable()
class ProfileImageModel {
  final int? id;
  @JsonKey(name: "imageUrl")
  final String imageUrl;
  @JsonKey(name: "userId")
  final int? userId;

  ProfileImageModel({
    this.id,
    required this.imageUrl,
    this.userId,
  });

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) => _$ProfileImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileImageModelToJson(this);

  ProfileImage toEntity(){
    return ProfileImage(
        id: id ?? 0,
        imageUrl: imageUrl,
        userId: userId ?? 0
    );
  }
}