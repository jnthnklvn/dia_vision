class AvaliacaoPesFailure implements Exception {
  final String message;
  final int statusCode;
  AvaliacaoPesFailure(this.message, this.statusCode);
}
