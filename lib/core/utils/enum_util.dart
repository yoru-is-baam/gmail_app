class EnumUtil {
  static String convertToCapitalization(Enum enumData) {
    String enumString = enumData.toString().split('.').last;
    return enumString[0].toUpperCase() + enumString.substring(1);
  }
}
