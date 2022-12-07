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

class UsernameAlreadyExists extends AppError {
  UsernameAlreadyExists([super.message = 'Username exists']);
}

class EmailAlreadyUsed extends AppError {
  EmailAlreadyUsed([super.message = 'Email used']);
}

class UserNotLoggedIn extends AppError {
  UserNotLoggedIn([super.message = 'You are not logged in']);
}

class UserNotPicked extends AppError {
  UserNotPicked([super.message = 'Please pick a participant']);
}

class TimeOverlapped extends AppError {
  TimeOverlapped(
      [super.message = 'Time is overlapped. Please try to pick another one.']);
}

class ParticipantIsHost extends AppError {
  ParticipantIsHost([super.message = 'Participant cannot be yourself']);
}

class MissingArguments extends AppError {
  MissingArguments([super.message = 'Missing Arguments']);
}
