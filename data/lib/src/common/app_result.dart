import 'app_error.dart';

class AppResult<T> {
  AppResult._({this.data, this.error});
  final T? data;
  final AppError? error;

  factory AppResult.success(T data) {
    return AppResult._(data: data);
  }

  factory AppResult.error(AppError error) {
    return AppResult._(error: error);
  }

  bool get success => error == null;
}
