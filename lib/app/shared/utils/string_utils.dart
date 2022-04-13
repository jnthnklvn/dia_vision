bool isNullOrEmpty(String? str) {
  return str?.isEmpty != false;
}

String? getCronHorario(
    int? horarioPos, List<String> horarios, int? tempoLembrete) {
  if (horarioPos == null ||
      !(horarios.isNotEmpty == true) && tempoLembrete == null) return null;
  final list = horarios[horarioPos].split(':');
  int? hour = int.tryParse(list[0]);
  int? min = int.tryParse(list[1]);

  if (hour == null || min == null) return null;
  if (min < tempoLembrete!) {
    hour = hour < 1 ? 23 : hour - 1;
    min += 60;
  }
  min = min - tempoLembrete;

  hour += 3; // Convertendo para UTC time
  hour = hour > 23 ? hour - 24 : hour;

  return "$min $hour";
}

String capitalize(String string) {
  if (string.isEmpty || string.length < 2) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1).toLowerCase();
}
