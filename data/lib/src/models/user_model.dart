import 'package:data/src/entities/user.dart';

class UserModel {
  String id;
  String username;
  String displayName;
  String email;
  UserModel({
    required this.id,
    required this.username,
    required this.displayName,
    required this.email,
  });

  User toUser() {
    return User(
      id: id,
      username: username,
      email: email,
      displayName: displayName,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['objectId'],
      username: json['username'],
      displayName: json['displayName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
