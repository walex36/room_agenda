class AppException implements Exception {
  final String message;
  late StackTrace stackTrace;
  AppException(this.message, [StackTrace? stackTrace]) {
    this.stackTrace = stackTrace ?? StackTrace.current;
  }
}

class RoomException extends AppException {
  RoomException(super.message, [super.stackTrace]);
}

class LoginException extends AppException {
  LoginException(super.message, [super.stackTrace]);
}

class RemoteException extends AppException {
  RemoteException(super.message, [super.stackTrace]);
}
