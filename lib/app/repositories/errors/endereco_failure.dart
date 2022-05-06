class EnderecoFailure implements Exception {
  final String message;
  final int statusCode;
  EnderecoFailure(this.message, this.statusCode);
}
