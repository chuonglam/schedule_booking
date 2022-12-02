import '../common/app_result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<AppResult<User>> login(String email, String password);
}
