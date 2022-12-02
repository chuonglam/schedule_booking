import 'package:data/data.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/loading_controller.dart';
import 'package:schedule_booking/common/validators/validator.dart';

class SignUpController extends GetxController with LoadingController {
  final AuthRepository _authRepository;

  SignUpController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  bool isFormValid(Validator validator) {
    final errorMess = validator.validate();
    error = errorMess;
    return error == null;
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
}
