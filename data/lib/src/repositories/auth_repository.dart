import 'package:data/src/common/app_result.dart';
import 'package:data/src/entities/user.dart';

abstract class AuthRepository {
  Future<AppResult<User>> login(String username, String password);

  Future<AppResult<bool>> logout();

  Future<AppResult<User>> signUp({
    required String username,
    required String password,
    required String displayName,
    required String email,
  });
}
