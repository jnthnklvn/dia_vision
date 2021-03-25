class DiureseFailure implements Exception {
  final String message;
  final int statusCode;
  DiureseFailure(this.message, this.statusCode);
}
