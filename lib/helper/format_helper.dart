class FormatHelper {
  static String to3Digits(int number) {
    if (-9 <= number && number < 0) {
      return "-0${number.abs()}";
    }

    if (number < -9 && number >= -99) {
      return "-${number.abs()}";
    }

    if (number < -99) {
      return number.toString();
    }
    if (number <= 9) {
      return "00$number";
    }
    if (number <= 99) {
      return "0$number";
    }

    return number.toString();
  }

  static int getDigitFromString(String text) {
    if (text == null) return 0;

    if (text.isEmpty) return 0;

    return int.tryParse(text) == null ? 0 : int.parse(text);
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
