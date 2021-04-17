class AppVisaoFailure implements Exception {
  final String message;
  final int statusCode;
  AppVisaoFailure(this.message, this.statusCode);
}
