class AutocuidadoFailure implements Exception {
  final String message;
  final int statusCode;
  AutocuidadoFailure(this.message, this.statusCode);
}
