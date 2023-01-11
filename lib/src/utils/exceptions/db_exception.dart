abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class DbException extends AppException {
  DbException(super.message);
}
