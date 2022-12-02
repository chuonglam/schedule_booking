import 'package:schedule_booking/common/validators/validation_field.dart';
import 'package:schedule_booking/common/validators/validations.dart';
import 'package:schedule_booking/common/validators/validator.dart';

class LoginParams with Validator {
  final String? username;
  final String? password;
  LoginParams({
    required this.username,
    required this.password,
  });

  @override
  List<ValidationField> get validations => [
        ValidationField(
          fieldName: 'Username',
          fieldValue: username,
          validations: [
            RequiredField(),
          ],
        ),
        ValidationField(
          fieldName: 'Password',
          fieldValue: password,
          validations: [
            RequiredField(),
          ],
        ),
      ];
}
