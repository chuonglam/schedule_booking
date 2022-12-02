import 'package:data/src/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

@Singleton()
class UserService {
  Future<UserModel?> currentUser() async {
    final user = ParseUser.currentUser() as ParseUser?;
    if (user == null) {
      return null;
    }
    // ignore: invalid_use_of_protected_member
    return UserModel.fromJson(user.toJson());
  }
}
