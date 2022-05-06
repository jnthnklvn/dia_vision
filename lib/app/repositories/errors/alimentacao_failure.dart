class AlimentacaoFailure implements Exception {
  final String message;
  final int statusCode;
  AlimentacaoFailure(this.message, this.statusCode);
}
