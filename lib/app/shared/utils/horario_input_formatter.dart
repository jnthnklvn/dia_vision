import 'package:flutter/services.dart';

/// Formata o valor do campo com a mascara de horário ( 12:00 ).
class HorarioInputFormatter extends TextInputFormatter {
  /// Define o tamanho máximo do campo.
  final int maxLength = 4;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final novoTextLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;

    if (novoTextLength > maxLength) {
      return oldValue;
    }

    var usedSubstringIndex = 0;
    final newText = StringBuffer();

    if (novoTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ':');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (novoTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
