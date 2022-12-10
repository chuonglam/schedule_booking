import 'package:data/data.dart';
import 'package:data/src/models/user_model.dart';
import 'package:data/src/network/user_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  UserRepositoryImpl({
    required UserService userService,
  }) : _userService = userService;

  @override
  Future<AppResult<User?>> getCurrentUser() async {
    try {
      final UserModel? user = await _userService.currentUser();
      return AppResult.success(user?.toUser());
    } catch (e) {
      //todo: handle exceptions
      return AppResult.error(DefaultError());
    }
  }

  @override
  Future<AppResult<List<User>>> getUsersList({
    required int durationInMins,
    String? nameSearch,
    DateTime? fromDate,
  }) async {
    try {
      final data = await _userService.getUsersList(
        durationInMins,
        nameSearch: nameSearch,
        fromDate: fromDate,
      );
      return AppResult.success(data.map((e) => e.toUser()).toList());
    } catch (e) {
      //todo: handle exceptions
      return AppResult.error(DefaultError());
    }
  }
}
