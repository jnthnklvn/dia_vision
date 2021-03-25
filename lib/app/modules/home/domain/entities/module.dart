import 'package:dia_vision/app/shared/utils/route_enum.dart';

class Module {
  final String name;
  final String imageSrc;
  final bool svg;
  final String routeName;

  Module(this.name, this.imageSrc, this.svg, this.routeName);
}

final alimentation = Module(
  "Alimentação",
  "assets/images/veggie-salad.svg",
  true,
  RouteEnum.alimentation.name,
);
final exercises = Module(
  "Atividade Física",
  "assets/images/exercise.png",
  false,
  RouteEnum.exercises.name,
);
final selfCare = Module(
  "Autocuidado",
  "assets/images/self-care.png",
  false,
  RouteEnum.selfCare.name,
);
final medicalCenters = Module(
  "Centros de Saúde",
  "assets/images/medical-center.png",
  false,
  RouteEnum.medicalCenters.name,
);
final glicemy = Module(
  "Glicemia",
  "assets/images/glucose-meter.svg",
  true,
  RouteEnum.glicemy.name,
);
final medications = Module(
  "Medicações",
  "assets/images/pill-bottle.png",
  false,
  RouteEnum.medications.name,
);
final feet = Module(
  "Pés",
  "assets/images/feet.png",
  false,
  RouteEnum.feet.name,
);
final doctors = Module(
  "Profissionais da Saúde",
  "assets/images/doctor.png",
  false,
  RouteEnum.doctors.name,
);
final kidney = Module(
  "Rins",
  "assets/images/kidney.png",
  false,
  RouteEnum.kidney.name,
);
final vision = Module(
  "Visão",
  "assets/images/vision.svg",
  true,
  RouteEnum.vision.name,
);

List<Module> modules = [
  alimentation,
  exercises,
  selfCare,
  medicalCenters,
  glicemy,
  medications,
  feet,
  // doctors,
  kidney,
  vision,
];
