// ignore_for_file: invalid_use_of_protected_member

import 'package:data/data.dart';
import 'package:data/src/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

@Singleton()
class AuthService {
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final ParseUser user = ParseUser.createUser(username, password);
    final response = await user.login();
    if (response.success) {
      return UserModel.fromJson((response.result as ParseUser).toJson());
    }
    if (response.error?.code == 101) {
      throw InvalidLoginCredentials();
    }
    throw DefaultError();
  }

  Future<bool> logout() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user == null) {
      return true;
    }
    final response = await user.logout();
    if (response.success) {
      return true;
    }
    throw DefaultError();
  }

  Future<UserModel> signUp({
    required String username,
    required String password,
    required String displayName,
    required String email,
  }) async {
    var user = ParseUser.createUser(username, password, email);
    user.set('displayName', displayName);
    final response = await user.signUp();
    if (response.success) {
      return UserModel.fromJson((response.result as ParseUser).toJson());
    }
    if (response.error?.code == 202) {
      throw UsernameAlreadyExists();
    }
    if (response.error?.code == 203) {
      throw EmailAlreadyUsed();
    }
    throw DefaultError();
  }
}
