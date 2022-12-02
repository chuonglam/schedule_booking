import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';

mixin CredentialsValidationController on GetxController {
  String? _validateUsername(String? value) {
    if (value?.isValidUsername() == true) {
      return null;
    }
    return 'User name should contains alphabet/number & be 5-15 characters long.';
  }

  String? _validateDisplayName(String? value) {
    if (value != null && value.length >= 5 && value.length <= 30) {
      return null;
    }
    return 'Name should be 5-30 characters long.';
  }

  String? _validateEmail(String? value) {
    if (value != null && value.isValidEmail()) {
      return null;
    }
    return 'Email is invalid.';
  }

  String? _validatePassword(String? value) {
    if (value != null && value.length >= 8) {
      return null;
    }
    return 'Password should be at least 8 character long.';
  }

  String? _validateConfirmPassword(String? pass, String? confirmPass) {
    if (pass != null && confirmPass != null && pass == confirmPass) {
      return null;
    }
    return 'Confirming password does not match';
  }

  String validateSignUpForm(
    String? username,
    String? password,
    String? confirmPassword,
    String? displayName,
    String? email,
  ) {
    StringBuffer errors = StringBuffer();
    final usernameError = _validateUsername(username);
    final displayNameError = _validateDisplayName(displayName);
    final emailError = _validateEmail(email);
    final passwordError = _validatePassword(password);
    final confirmPassError =
        _validateConfirmPassword(password, confirmPassword);
    errors.writeAll(
      [
        usernameError,
        displayNameError,
        emailError,
        passwordError,
        confirmPassError
      ].where((er) => er != null),
      '\n',
    );
    return errors.toString();
  }
}
