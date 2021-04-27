class AtividadeFisicaFailure implements Exception {
  final String message;
  final int statusCode;
  AtividadeFisicaFailure(this.message, this.statusCode);
}
