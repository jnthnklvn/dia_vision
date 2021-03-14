class UserFailure implements Exception {
  final String message;
  final int statusCode;
  UserFailure(this.message, this.statusCode);
}
