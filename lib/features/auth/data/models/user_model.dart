import 'package:auth_sample/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.token,
    required super.id,
    required super.created,
    required super.username,
    required super.name,
  });

  factory UserModel.fromJson({required Map<String, dynamic> map}) {
    return UserModel(
      id: map['record']['id'],
      created: map['record']['created'],
      username: map['record']['username'],
      name: map['record']['name'],
      token: map['token'],
    );
  }

  User toEntity() {
    return User(
      token: token,
      id: id,
      created: created,
      username: username,
      name: name,
    );
  }
}
