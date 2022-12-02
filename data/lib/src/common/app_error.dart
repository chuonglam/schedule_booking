abstract class AppError implements Exception {
  String message;
  AppError(this.message);
}

class NoInternetConnectionError extends AppError {
  NoInternetConnectionError([super.message = 'No Internet connection']);
}

class DataNotFound extends AppError {
  DataNotFound([super.message = 'Data not found']);
}

class DefaultError extends AppError {
  DefaultError([super.message = 'Something went wrong']);
}

class InvalidLoginCredentials extends AppError {
  InvalidLoginCredentials([super.message = 'Invalid login credentials']);
}
