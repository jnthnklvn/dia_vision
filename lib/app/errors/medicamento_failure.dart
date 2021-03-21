class MedicamentoFailure implements Exception {
  final String message;
  final int statusCode;
  MedicamentoFailure(this.message, this.statusCode);
}
