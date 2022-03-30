import 'package:dartz/dartz.dart';

class MedicationUtils {
  String? getPosologia(num? poso) {
    return horariosList
        .firstWhere((e) => e.value2 == poso, orElse: () => horariosList.last)
        .value1;
  }

  final List<Tuple2<String, int>> horariosList = [
    const Tuple2("1 em 1 hora", 1),
    const Tuple2("2 em 2 horas", 2),
    const Tuple2("4 em 4 horas", 4),
    const Tuple2("6 em 6 horas", 6),
    const Tuple2("8 em 8 horas", 8),
    const Tuple2("12 em 12 horas", 12),
    const Tuple2("24 em 24 horas", 24),
    const Tuple2("Personalizado", 0),
  ];
}
