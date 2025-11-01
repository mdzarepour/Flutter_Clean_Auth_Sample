import 'package:auth_sample/fetures/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.name,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['record']['id'],
      username: map['record']['username'],
      name: map['record']['name'],
      token: map['token'],
    );
  }
}
