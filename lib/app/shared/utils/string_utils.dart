import 'package:dia_vision/app/model/endereco.dart';

String firstCharUpperCase(String string) {
  return string?.isNotEmpty == true
      ? string.split("")[0].toUpperCase() + string.substring(1)
      : string;
}

String getEnderecoFormatado(Endereco endereco) {
  String strFormatada = endereco.rua ?? "";
  strFormatada +=
      endereco.numero != null ? ", " + endereco.numero.toString() : "";
  strFormatada += endereco.bairro != null ? ", " + endereco.bairro : "";
  strFormatada += endereco.cidade != null ? ", " + endereco.cidade : "";
  strFormatada += endereco.estado != null ? " - " + endereco.estado : "";
  return strFormatada;
}
