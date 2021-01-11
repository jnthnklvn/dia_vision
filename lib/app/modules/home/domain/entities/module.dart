class Module {
  final String name;
  final String imageSrc;
  final bool svg;

  Module(this.name, this.imageSrc, this.svg);
}

List<Module> modules = [
  Module("Alimentação", "assets/images/veggie-salad.svg", true),
  Module("Atividade Física", "assets/images/exercise.png", false),
  Module("Autocuidado", "assets/images/self-care.png", false),
  Module("Centros de Saúde", "assets/images/medical-center.png", false),
  Module("Glicemia", "assets/images/glucose-meter.svg", true),
  Module("Medicações", "assets/images/pill-bottle.png", false),
  Module("Pés", "assets/images/feet.png", false),
  Module("Profissionais da Saúde", "assets/images/doctor.png", false),
  Module("Rins", "assets/images/kidney.png", false),
  Module("Visão", "assets/images/vision.svg", true),
];
