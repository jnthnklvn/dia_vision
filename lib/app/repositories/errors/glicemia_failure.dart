class GlicemiaFailure implements Exception {
  final String message;
  final int statusCode;
  GlicemiaFailure(this.message, this.statusCode);
}
