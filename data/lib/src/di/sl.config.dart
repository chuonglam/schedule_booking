// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/data.dart' as _i5;
import 'package:data/src/network/auth_service.dart' as _i3;
import 'package:data/src/network/user_service.dart' as _i4;
import 'package:data/src/repositories/auth_repository_impl.dart' as _i6;
import 'package:data/src/repositories/user_repository_impl.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt $initDataGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AuthService>(_i3.AuthService());
    gh.singleton<_i4.UserService>(_i4.UserService());
    gh.factory<_i5.AuthRepository>(
        () => _i6.AuthRepositoryImpl(authService: gh<_i3.AuthService>()));
    gh.factory<_i5.UserRepository>(
        () => _i7.UserRepositoryImpl(userService: gh<_i4.UserService>()));
    return this;
  }
}
