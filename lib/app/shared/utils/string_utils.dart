String firstCharUpperCase(String string) {
  return string?.isNotEmpty == true
      ? string.split("")[0].toUpperCase() + string.substring(1)
      : string;
}
