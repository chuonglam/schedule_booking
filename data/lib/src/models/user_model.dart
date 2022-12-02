import 'package:data/src/entities/user.dart';

class UserModel {
  String id;
  String username;
  UserModel({required this.id, required this.username});

  User toUser() {
    return User(id: id, username: username);
  }
}
