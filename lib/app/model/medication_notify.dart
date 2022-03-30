import 'dart:convert';

class MedicationNotify {
  String? body;
  String? title;
  String? objectId;
  List<String>? horarios;

  MedicationNotify({
    this.body,
    this.title,
    this.objectId,
    this.horarios,
  });

  String? getCronHorario(int horarioPos, int tempoLembrete) {
    if (horarios?.isNotEmpty != true) {
      final list = horarios![horarioPos].split(':');
      int? hour = int.tryParse(list[0].toString());
      int? min = int.tryParse(list[1].toString());

      if (hour == null || min == null) return null;
      if (min < tempoLembrete) {
        hour = hour < 1 ? 23 : hour - 1;
        min += 60;
      }
      min = min - tempoLembrete;

      hour += 3; // Convertendo para UTC time
      hour = hour > 23 ? hour - 24 : hour;

      return "$min $hour";
    } else {
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'title': title,
      'objectId': objectId,
      'horarios': horarios,
    };
  }

  factory MedicationNotify.fromMap(Map<String, dynamic> map) {
    return MedicationNotify(
      body: map['body'],
      title: map['title'],
      objectId: map['objectId'],
      horarios: List<String>.from(map['horarios']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicationNotify.fromJson(String source) =>
      MedicationNotify.fromMap(json.decode(source));
}
