class CentroSaudeFailure implements Exception {
  final String message;
  final int statusCode;
  CentroSaudeFailure(this.message, this.statusCode);
}
