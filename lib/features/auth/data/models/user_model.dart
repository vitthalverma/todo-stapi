import 'package:frontend/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.jwt,
    required super.username,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      jwt: json['jwt'] ?? '',
      username: json['user']['username'] ?? '',
      email: json['user']['email'] ?? '',
    );
  }
}
