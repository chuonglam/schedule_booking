import 'package:schedule_booking/common/validators/validations.dart';

class ValidationField {
  final String fieldName;
  final String? fieldValue;
  final List<Validation> validations;

  ValidationField({
    this.fieldValue,
    required this.fieldName,
    required this.validations,
  });

  String? firstValidationFailed() {
    for (var validation in validations) {
      final error = validation.validate(fieldValue);
      if (error != null) {
        return '$fieldName $error';
      }
    }
    return null;
  }
}
