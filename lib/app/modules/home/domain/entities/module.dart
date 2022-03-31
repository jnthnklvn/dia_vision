import 'package:dia_vision/app/shared/utils/route_enum.dart';

class ModuleItem {
  final String name;
  final String imageSrc;
  final bool svg;
  final String routeName;
  final bool needPatient;

  ModuleItem(
      this.name, this.imageSrc, this.svg, this.routeName, this.needPatient);
}

final alimentation = ModuleItem(
  "Alimentação",
  "assets/images/veggie-salad.svg",
  true,
  RouteEnum.alimentation.name,
  true,
);
final exercises = ModuleItem(
  "Atividade Física",
  "assets/images/exercise.png",
  false,
  RouteEnum.exercises.name,
  true,
);
final selfCare = ModuleItem(
  "Autocuidado",
  "assets/images/self-care.png",
  false,
  RouteEnum.selfCare.name,
  false,
);
final medicalCentersModule = ModuleItem(
  "Centros de Saúde",
  "assets/images/medical-center.png",
  false,
  RouteEnum.medicalCenters.name,
  false,
);
final glicemy = ModuleItem(
  "Glicemia",
  "assets/images/glucose-meter.svg",
  true,
  RouteEnum.glicemy.name,
  true,
);
final medications = ModuleItem(
  "Medicações",
  "assets/images/pill-bottle.png",
  false,
  RouteEnum.medications.name,
  true,
);
final feet = ModuleItem(
  "Pés",
  "assets/images/feet.png",
  false,
  RouteEnum.feet.name,
  true,
);
final doctors = ModuleItem(
  "Profissionais da Saúde",
  "assets/images/doctor.png",
  false,
  RouteEnum.doctors.name,
  true,
);
final kidney = ModuleItem(
  "Rins",
  "assets/images/kidney.png",
  false,
  RouteEnum.kidney.name,
  true,
);
final vision = ModuleItem(
  "Apps de Visão",
  "assets/images/vision.svg",
  true,
  RouteEnum.vision.name,
  false,
);

List<ModuleItem> modules = [
  alimentation,
  vision,
  exercises,
  selfCare,
  medicalCentersModule,
  glicemy,
  medications,
  feet,
  kidney,
];
