class MedicacaoPrescritaFailure implements Exception {
  final String message;
  final int statusCode;
  MedicacaoPrescritaFailure(this.message, this.statusCode);
}
