class PacienteFailure implements Exception {
  final String message;
  final int statusCode;
  PacienteFailure(this.message, this.statusCode);
}
