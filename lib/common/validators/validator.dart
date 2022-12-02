import 'package:schedule_booking/common/validators/validation_field.dart';

mixin Validator {
  final List<ValidationField> validations = [];

  String? validate() {
    final messagesList = validations
        .map((field) => field.firstValidationFailed())
        .where((errorMessage) => errorMessage != null);
    if (messagesList.isEmpty) {
      return null;
    }
    return messagesList.join('\n');
  }
}
