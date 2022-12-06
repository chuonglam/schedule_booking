import 'package:data/data.dart';
import 'package:data/src/network/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({
    required AuthService authService,
  }) : _authService = authService;

  @override
  Future<AppResult<User>> login(String username, String password) async {
    try {
      final response =
          await _authService.login(username: username, password: password);
      return AppResult.success(response.toUser());
    } on AppError catch (e) {
      return AppResult.error(e);
    } on Exception catch (e) {
      return AppResult.error(DefaultError());
    }
  }

  @override
  Future<AppResult<bool>> logout() async {
    try {
      final response = await _authService.logout();
      return AppResult.success(true);
    } catch (e) {
      //todo: handle exs
      return AppResult.error(DefaultError());
    }
  }

  @override
  Future<AppResult<User>> signUp({
    required String username,
    required String password,
    required String displayName,
    required String email,
  }) async {
    try {
      final user = await _authService.signUp(
        username: username,
        password: password,
        displayName: displayName,
        email: email,
      );
      return AppResult.success(user.toUser());
    } on AppError catch (e, trace) {
      debugPrintStack(stackTrace: trace);
      return AppResult.error(e);
    } on Exception catch (_) {
      return AppResult.error(DefaultError());
    }
  }
}
