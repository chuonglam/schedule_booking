import 'package:data/data.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/loading_controller.dart';
import 'package:schedule_booking/screens/auth/credentials_validation_controller.dart';

class AuthController extends GetxController
    with LoadingController, CredentialsValidationController {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthController(
      {required AuthRepository authRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository;
  final Rxn<User> _currentUser = Rxn();

  User? get currentUser => _currentUser.value;

  bool get isLoggedIn => _currentUser.value != null;

  void login() {
    _currentUser(User(id: 'id', username: 'username', email: 'email'));
  }

  bool isFormValid({
    String? username,
    String? password,
    String? confirm,
    String? displayName,
    String? email,
  }) {
    final validationError = validateSignUpForm(
      username,
      password,
      confirm,
      displayName,
      email,
    );
    if (validationError.isNotEmpty) {
      error = validationError;
      return false;
    }
    return true;
  }

  Future<bool> signUp({
    required String username,
    required String password,
    required String displayName,
    required String email,
  }) async {
    if (isLoading) {
      return false;
    }
    isLoading = true;
    error = null;
    final result = await _authRepository.signUp(
      username: username,
      password: password,
      displayName: displayName,
      email: email,
    );
    isLoading = false;
    if (result.success) {
      return true;
    }
    error = result.error?.message;
    return false;
  }

  void logout() {
    _currentUser(null);
  }
}
