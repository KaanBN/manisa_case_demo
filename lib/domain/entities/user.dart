import 'package:manisa_case/domain/entities/profile_image.dart';

class User {
  final int id;
  final String username;
  final String email;
  final ProfileImage profileImage;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImage,
  });
}
