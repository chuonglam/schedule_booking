import 'package:data/data.dart';

abstract class UserRepository {
  Future<AppResult<User?>> getCurrentUser();
}
