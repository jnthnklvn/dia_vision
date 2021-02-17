enum RouteEnum {
  splash,
  auth,
  register,
  recovery,
  my_data,
  home,
  profile,
  alimentation,
  exercises,
  selfCare,
  medicalCenters,
  glicemy,
  medications,
  feet,
  doctors,
  kidney,
  vision,
}

extension RouteEnumExtension on RouteEnum {
  String get name => "/" + this.toString().replaceAll('RouteEnum.', '');
}
