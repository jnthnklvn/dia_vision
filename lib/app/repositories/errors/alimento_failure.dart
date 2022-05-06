class AlimentoFailure implements Exception {
  final String message;
  final int statusCode;
  AlimentoFailure(this.message, this.statusCode);
}
