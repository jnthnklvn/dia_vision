import 'package:dartz/dartz.dart';

class MedicationUtils {
  String getPosologia(num poso) {
    return horariosList
            .firstWhere((e) => e.value2 == poso, orElse: () => null)
            ?.value1 ??
        poso?.toString();
  }

  final List<Tuple2<String, int>> horariosList = [
    Tuple2("1 em 1 hora", 1),
    Tuple2("2 em 2 horas", 2),
    Tuple2("4 em 4 horas", 4),
    Tuple2("6 em 6 horas", 6),
    Tuple2("8 em 8 horas", 8),
    Tuple2("12 em 12 horas", 12),
    Tuple2("24 em 24 horas", 24),
    Tuple2("Personalizado", 0),
  ];
}
