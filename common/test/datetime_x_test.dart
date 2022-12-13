import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'format()',
    () {
      test(
        'should use default formatter when input a null one',
        () {
          final DateTime date = DateTime(2022, 1, 2, 0, 0, 0, 0);
          final String result = date.format();
          expect(result, '01-02-2022');
        },
      );

      test(
        'should success when input a formatter',
        () {
          final DateTime date = DateTime(2022, 1, 2, 0, 0, 0, 0);
          final String result = date.format(formatter: 'dd-MM-yyyy');
          expect(result, '02-01-2022');
        },
      );
    },
  );

  group(
    'begginingOfDay()',
    () {
      test(
        'should return correct date and time',
        () {
          final DateTime now = DateTime.now();
          final DateTime beginningOfTheDay =
              DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
          final DateTime input = now;
          final DateTime result = input.beginningOfDay();
          expect(result, beginningOfTheDay);
        },
      );
    },
  );

  group(
    'endOfDay()',
    () {
      test(
        'should return correct date and time',
        () {
          final DateTime now = DateTime.now();
          final DateTime endOfDate =
              DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
          final DateTime input = now;
          final DateTime result = input.endOfDay();
          expect(result, endOfDate);
        },
      );
    },
  );
}
