import 'package:schedule_booking/common/validators/validation_field.dart';
import 'package:schedule_booking/common/validators/validations.dart';
import 'package:schedule_booking/common/validators/validator.dart';

class SignUpParams with Validator {
  String? username;
  String? password;
  String? confirmPassword;
  String? email;
  String? displayName;

  SignUpParams({
    this.username,
    this.password,
    this.confirmPassword,
    this.email,
    this.displayName,
  });

  @override
  List<ValidationField> get validations => [
        ValidationField(
          fieldName: 'Username',
          fieldValue: username,
          validations: [
            RequiredField(),
            ValidUsername(),
            ValidLength(minLength: 5, maxLength: 15),
          ],
        ),
        ValidationField(
          fieldName: 'Password',
          fieldValue: password,
          validations: [
            RequiredField(),
            ValidLength(minLength: 5, maxLength: 15),
          ],
        ),
        ValidationField(
          fieldName: 'Email',
          fieldValue: email,
          validations: [
            RequiredField(),
            ValidEmail(),
          ],
        ),
        ValidationField(
          fieldName: 'Confirm Password',
          fieldValue: confirmPassword,
          validations: [
            ConfirmPasswordMatch(password: password),
          ],
        ),
      ];
}
