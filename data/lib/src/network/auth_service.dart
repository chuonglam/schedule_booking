// ignore_for_file: invalid_use_of_protected_member

import 'package:data/data.dart';
import 'package:data/src/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

@Singleton()
class AuthService {
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
