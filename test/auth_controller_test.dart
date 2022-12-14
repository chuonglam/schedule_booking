import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:schedule_booking/models/login_params.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';

import 'mocks/mocks.dart';

void main() {
  late AuthRepository authRepository;
  late UserRepository userRepository;
  late AuthController authController;

  setUp(() {
    authRepository = MockAuthRepository();
    userRepository = MockUserRepository();
    authController = AuthController(
      authRepository: authRepository,
      userRepository: userRepository,
    );
  });

  tearDown(() {
    authController.dispose();
    Get.delete<AuthController>();
  });

  void setUpCurrentUser(bool loggedIn) {
    final MockUser user = MockUser();
    final MockUserAppResult currentUserResult = MockUserAppResult();
    if (loggedIn) {
      when(() => currentUserResult.data).thenReturn(user);
      when(() => currentUserResult.success).thenReturn(true);
    } else {
      when(() => currentUserResult.data).thenReturn(null);
      when(() => currentUserResult.success).thenReturn(true);
    }

    when(() => userRepository.getCurrentUser())
        .thenAnswer((_) async => currentUserResult);
  }

  group(
    '.currentUser',
    () {
      test(
        'should have no user data if user is not logged in',
        () {
          setUpCurrentUser(false);
          Get.put(authController);
          verify(
            () => userRepository.getCurrentUser(),
          ).called(1);
          expect(
            authController.currentUser,
            isNull,
          );
        },
      );

      test(
        "should have user data if user've already logged in",
        () async {
          setUpCurrentUser(true);
          Get.put(authController);
          verify(
            () => userRepository.getCurrentUser(),
          ).called(1);
          await Future.delayed(const Duration(seconds: 1));
          expect(authController.currentUser, isNotNull);
          Get.deleteAll();
        },
      );
    },
  );

  group(
    'isFormValid()',
    () {
      test(
        'should have no errors if Login form is not empty',
        () async {
          setUpCurrentUser(false);
          Get.put(authController);
          verify(() => userRepository.getCurrentUser()).called(1);
          await Future.delayed(const Duration(seconds: 1));

          final valid = authController.isFormValid(
            LoginParams(username: 'username', password: 'password'),
          );
          expect(valid, true);
        },
      );

      test(
        'should have if Login form username is empty',
        () async {
          setUpCurrentUser(false);
          Get.put(authController);
          verify(() => userRepository.getCurrentUser()).called(1);
          await Future.delayed(const Duration(seconds: 1));

          final valid = authController.isFormValid(
            LoginParams(username: '', password: 'password'),
          );
          expect(valid, false);
        },
      );

      test(
        'should have if Login form password is null',
        () async {
          setUpCurrentUser(false);
          Get.put(authController);
          verify(() => userRepository.getCurrentUser()).called(1);

          await Future.delayed(const Duration(seconds: 1));
          final valid = authController.isFormValid(
            LoginParams(username: 'username', password: null),
          );
          expect(valid, false);
        },
      );
    },
  );

  group(
    'login()',
    () {
      test(
        'should have .currentUser not null if login success',
        () async {
          setUpCurrentUser(false);

          MockUserAppResult loginResult = MockUserAppResult();
          MockUser user = MockUser();
          when(() => loginResult.success).thenReturn(true);
          when(() => loginResult.data).thenReturn(user);
          when(() => authRepository.login(any<String>(), any<String>()))
              .thenAnswer((_) async => loginResult);

          Get.put(authController);
          verify(() => userRepository.getCurrentUser()).called(1);
          await Future.delayed(const Duration(seconds: 1));

          expect(authController.error, isNull);
          expect(authController.currentUser, isNull);
          await authController.login(password: '', username: '');
          expect(authController.error, isNull);
          expect(authController.currentUser, isNotNull);
        },
      );

      test(
        'should have .error not null if login with wrong credentials',
        () async {
          setUpCurrentUser(false);

          final AppError error = InvalidLoginCredentials();
          MockUserAppResult loginResult = MockUserAppResult();
          when(() => loginResult.success).thenReturn(false);
          when(() => loginResult.data).thenReturn(null);
          when(() => loginResult.error).thenReturn(error);
          when(() => authRepository.login(any<String>(), any<String>()))
              .thenAnswer((_) async => loginResult);

          Get.put(authController);
          verify(() => userRepository.getCurrentUser()).called(1);
          await Future.delayed(const Duration(seconds: 1));

          expect(authController.error, isNull);
          expect(authController.currentUser, isNull);
          await authController.login(password: 'pass', username: 'usr');
          expect(authController.currentUser, isNull);
          expect(authController.error, error.message);
        },
      );
    },
  );
}
