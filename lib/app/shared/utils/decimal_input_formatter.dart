import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara decimal (ex: 103,8)
class DecimalInputFormatter extends TextInputFormatter {
  /// Define o tamanho máximo do campo.
  final int maxLength = 4;

  DecimalInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue valorAntigo, TextEditingValue valorNovo) {
    final novoTextLength = valorNovo.text.length;
    var selectionIndex = valorNovo.selection.end;

    if (novoTextLength > maxLength) {
      return valorAntigo;
    }

    var usedSubstringIndex = 0;
    final newText = StringBuffer();
    switch (novoTextLength) {
      case 2:
        newText
            .write(valorNovo.text.substring(0, usedSubstringIndex = 1) + ',');
        if (valorNovo.selection.end >= 2) selectionIndex++;
        break;
      case 3:
        newText
            .write(valorNovo.text.substring(0, usedSubstringIndex = 1) + ',');
        if (valorNovo.selection.end >= 3) selectionIndex++;
        break;
      case 4:
        newText
            .write(valorNovo.text.substring(0, usedSubstringIndex = 2) + ',');
        if (valorNovo.selection.end >= 4) selectionIndex++;
        break;
    }

    if (novoTextLength >= usedSubstringIndex) {
      newText.write(valorNovo.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
