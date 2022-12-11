import 'package:common/common.dart';

abstract class Validation {
  final String? errorMessage;
  final bool Function(String?) expression;

  Validation({
    required this.errorMessage,
    required this.expression,
  });

  String? validate(String? value) {
    if (expression(value)) {
      return null;
    }
    return errorMessage;
  }
}

class RequiredField extends Validation {
  RequiredField()
      : super(
          errorMessage: 'is required',
          expression: (value) => value != null && value.isNotEmpty,
        );
}

class ValidEmail extends Validation {
  ValidEmail()
      : super(
          errorMessage: 'is invalid',
          expression: (value) => value?.isValidEmail() ?? false,
        );
}

class ValidUsername extends Validation {
  ValidUsername()
      : super(
          errorMessage: 'should contain alphatbets/numbers & 5-15 chars long.',
          expression: (value) => value?.isValidUsername() ?? false,
        );
}

class ValidLength extends Validation {
  ValidLength({
    required int minLength,
    required int maxLength,
  }) : super(
          errorMessage: 'should be $minLength-$maxLength long.',
          expression: (value) =>
              (value?.length ?? 0) >= minLength &&
              (value?.length ?? 0) <= maxLength,
        );
}

class ConfirmPasswordMatch extends Validation {
  ConfirmPasswordMatch({
    String? password,
  }) : super(
          errorMessage: 'does not match',
          expression: (value) =>
              value != null && password != null && value == password,
        );
}
