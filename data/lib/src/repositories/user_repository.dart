import 'package:data/data.dart';

abstract class UserRepository {
  Future<AppResult<User?>> getCurrentUser();
  Future<AppResult<List<User>>> getUsersList({String? nameSearch});
}
