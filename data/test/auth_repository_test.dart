import 'package:data/data.dart';
import 'package:data/src/models/user_model.dart';
import 'package:data/src/network/auth_service.dart';
import 'package:data/src/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUser extends Mock implements User {}

class MockUserModel extends Mock implements UserModel {}

class MockAppResult extends Mock implements AppResult<MockUserModel> {}

void main() {
  group(
    'AuthRepository',
    () {
      late AuthService authService;
      late AuthRepository authRepository;
      setUp(() {
        authService = MockAuthService();
        authRepository = AuthRepositoryImpl(authService: authService);
      });

      group(
        'login()',
        () {
          test(
            'should be success if input valid credentials',
            () async {
              final userModel = MockUserModel();
              final user = MockUser();
              when(() => userModel.toUser()).thenReturn(user);
              when(() => authService.login(
                      username: any<String>(named: 'username'),
                      password: any<String>(named: 'password')))
                  .thenAnswer((_) async => userModel);
              final AppResult<User> res =
                  await authRepository.login('username', 'password');
              expect(res.success, true);
            },
          );

          test(
            'should get InvalidLoginCredentials error if input wrong credentials',
            () async {
              when(() => authService.login(
                      username: any<String>(named: 'username'),
                      password: any<String>(named: 'password')))
                  .thenThrow(InvalidLoginCredentials());

              final AppResult<User> res =
                  await authRepository.login('username', 'password');
              expect(
                  res,
                  isA<AppResult<User>>()
                      .having(
                          (result) => result.success, 'should be false', false)
                      .having(
                          (result) => result.error,
                          'is InvalidLoginCredentials',
                          isA<InvalidLoginCredentials>()));
            },
          );

          test(
            'should get InvalidLoginCredentials error if input empty credentials',
            () async {
              when(() => authService.login(
                      username: any<String>(named: 'username'),
                      password: any<String>(named: 'password')))
                  .thenThrow(InvalidLoginCredentials());

              final AppResult<User> res = await authRepository.login('', '');
              expect(
                  res,
                  isA<AppResult<User>>()
                      .having(
                          (result) => result.success, 'should be false', false)
                      .having(
                          (result) => result.error,
                          'is InvalidLoginCredentials',
                          isA<InvalidLoginCredentials>()));
            },
          );

          test(
            'should not crash if unhandled exception occurs',
            () async {
              final Exception exception = Exception('unhandled exception');
              when(() => authService.login(
                      username: any<String>(named: 'username'),
                      password: any<String>(named: 'password')))
                  .thenThrow(exception);

              final AppResult<User> res =
                  await authRepository.login('username', 'password');
              expect(
                  res,
                  isA<AppResult<User>>()
                      .having(
                          (result) => result.success, 'should be false', false)
                      .having((result) => result.error, 'is DefaultError',
                          isA<DefaultError>())
                      .having((p0) => p0.error?.message, 'is',
                          exception.toString()));
            },
          );
        },
      );

      group(
        'logout',
        () {
          test(
            'should be success if logout success',
            () async {
              when(() => authService.logout()).thenAnswer((_) async => true);
              final AppResult<bool> res = await authRepository.logout();
              expect(res.success, true);
            },
          );

          test(
            'should get an error if logout fails',
            () async {
              final Exception exception = Exception('logout exception');
              when(() => authService.logout()).thenThrow(exception);
              final AppResult<bool> res = await authRepository.logout();
              expect(res.success, false);
              expect(
                res.error,
                isA<DefaultError>().having(
                  (e) => e.message,
                  'equals to',
                  exception.toString(),
                ),
              );
            },
          );
        },
      );

      group(
        'signUp()',
        () {
          test(
            'should return user info if sign up success',
            () async {
              final userModel = MockUserModel();
              final user = MockUser();
              when(() => userModel.toUser()).thenReturn(user);
              when(() => authService.signUp(
                    username: any<String>(named: 'username'),
                    password: any<String>(named: 'password'),
                    displayName: any<String>(named: 'displayName'),
                    email: any<String>(named: 'email'),
                  )).thenAnswer((invocation) async => userModel);
              final res = await authRepository.signUp(
                username: 'username',
                password: 'password',
                displayName: 'displayName',
                email: 'email@gmail.com',
              );
              expect(res.data, isA<MockUser>());
            },
          );

          test(
            'should get FieldRequired error if username empty',
            () async {
              final userModel = MockUserModel();
              final user = MockUser();
              when(() => userModel.toUser()).thenReturn(user);
              when(() => authService.signUp(
                    username: any<String>(named: 'username'),
                    password: any<String>(named: 'password'),
                    displayName: any<String>(named: 'displayName'),
                    email: any<String>(named: 'email'),
                  )).thenAnswer((invocation) async => userModel);
              final res = await authRepository.signUp(
                username: '',
                password: 'password',
                displayName: 'displayName',
                email: 'email',
              );
              expect(res.error, isA<FieldRequired>());
            },
          );

          test(
            'should get FieldInvalid error if email is invalid',
            () async {
              final userModel = MockUserModel();
              final user = MockUser();
              when(() => userModel.toUser()).thenReturn(user);
              when(() => authService.signUp(
                    username: any<String>(named: 'username'),
                    password: any<String>(named: 'password'),
                    displayName: any<String>(named: 'displayName'),
                    email: any<String>(named: 'email'),
                  )).thenAnswer((invocation) async => userModel);
              final res = await authRepository.signUp(
                username: 'username',
                password: 'password',
                displayName: 'displayName',
                email: 'email',
              );
              expect(res.error, isA<FieldInvalid>());
            },
          );
        },
      );
    },
  );
}
