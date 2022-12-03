import 'package:data/data.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/loading_controller.dart';
import 'package:schedule_booking/common/validators/validator.dart';

class AuthController extends GetxController with LoadingController {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthController({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  final Rxn<User> _currentUser = Rxn();

  User? get currentUser => _currentUser.value;

  bool get isLoggedIn => _currentUser.value != null;

  bool isFormValid(Validator validator) {
    final errorMess = validator.validate();
    error = errorMess;
    return error == null;
  }

  void login({
    required String username,
    required String password,
  }) async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    error = null;
    final res = await _authRepository.login(username, password);
    isLoading = false;
    if (res.success) {
      _currentUser(res.data);
      return;
    }
    error = res.error?.message;
  }

  void logout() {
    _currentUser(null);
  }
}
