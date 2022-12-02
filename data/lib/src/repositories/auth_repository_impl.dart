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
  Future<AppResult<User>> login(String email, String password) {
    throw UnimplementedError();
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
