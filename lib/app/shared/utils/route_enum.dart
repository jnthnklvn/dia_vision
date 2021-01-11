enum RouteEnum { splash, auth, register, recovery, my_data, home, profile }

extension RouteEnumExtension on RouteEnum {
  String get name => "/" + this.toString().replaceAll('RouteEnum.', '');
}
