class ThemeParams {
  final bool isDarkMode;
  final double fontScale;

  ThemeParams(this.isDarkMode, this.fontScale);

  ThemeParams.fromJson(Map<String, dynamic> json)
      : isDarkMode = json['isDarkMode'],
        fontScale = json['fontScale'];

  Map<String, dynamic> toJson() => {
        'isDarkMode': isDarkMode,
        'fontScale': fontScale,
      };
}
