enum RouteEnum {
  splash,
  auth,
  register,
  recovery,
  myData,
  preferences,
  home,
  profile,
  notification,
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
  String get name => "/" + toString().replaceAll('RouteEnum.', '');
}
