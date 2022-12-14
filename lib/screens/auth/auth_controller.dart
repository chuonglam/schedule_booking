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

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    isLoading = true;
    error = null;
    final result = await _userRepository.getCurrentUser();
    isLoading = false;
    if (result.success) {
      _currentUser.value = result.data;
    }
  }

  bool isFormValid(Validator validator) {
    final errorMess = validator.validate();
    error = errorMess;
    return error == null;
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    if (isLoading) {
      return false;
    }
    isLoading = true;
    error = null;
    final res = await _authRepository.login(username, password);
    isLoading = false;
    if (res.success) {
      error = null;
      _currentUser(res.data);
      return true;
    }
    error = res.error?.message;
    return false;
  }

  void logout() async {
    final AppResult<bool> result = await _authRepository.logout();
    if (result.success) {
      _currentUser.value = null;
    }
  }
}
