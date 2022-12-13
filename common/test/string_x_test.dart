import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'isValidEmail',
    () {
      test(
        'should return true when email is valid',
        () {
          const String input = 'chuong@gmail.com';
          final bool result = input.isValidEmail();
          expect(result, true);
        },
      );
      test(
        'should return false when email contains space',
        () {
          const String input = 'chu ong@gmail.com';
          final bool result = input.isValidEmail();
          expect(result, false);
        },
      );
      test(
        'should return false when email not contains @',
        () {
          const String input = 'chuonggmail.com';
          final bool result = input.isValidEmail();
          expect(result, false);
        },
      );
      test(
        'should return false when email not contains domain',
        () {
          const String input = 'chuong@gmail';
          final bool result = input.isValidEmail();
          expect(result, false);
        },
      );
      test(
        'should return false when email not contains domain',
        () {
          const String input = 'chuong.com@gmail';
          final bool result = input.isValidEmail();
          expect(result, false);
        },
      );
    },
  );

  group(
    'isValidUsername()',
    () {
      test(
        'should return true when username is valid',
        () {
          const String input = 'chuonglam';
          final bool result = input.isValidUsername();
          expect(result, true);
        },
      );
      test(
        'should return true when username is valid and contains number',
        () {
          const String input = 'chuong123lam';
          final bool result = input.isValidUsername();
          expect(result, true);
        },
      );
      test(
        'should return false when username contains space',
        () {
          const String input = 'chuong lam';
          final bool result = input.isValidUsername();
          expect(result, false);
        },
      );
      test(
        'should return false when username contains space at start/end',
        () {
          const String input = ' chuonglam ';
          final bool result = input.isValidUsername();
          expect(result, false);
        },
      );
      test(
        'should return false when username contains special character',
        () {
          const String input = 'chuong@lam';
          final bool result = input.isValidUsername();
          expect(result, false);
        },
      );
    },
  );
}
