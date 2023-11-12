
import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color(0xff92A3FD);
  static Color get primaryColor2 => const Color(0xff9DCEFF);

  static Color get secondaryColor1 => const Color(0xffC58BF2);
  static Color get secondaryColor2 => const Color(0xffEEA4CE);


  static List<Color> get primaryG => [ primaryColor2, primaryColor1 ];
  static List<Color> get secondaryG => [secondaryColor2, secondaryColor1];

  static Color get black => const Color(0xff1D1617);
  static Color get gray => const Color(0xff786F72);
  static Color get white => Colors.white;
  static Color get lightGray => const Color(0xffF7F8F8);



}


Map<int, Color> colorSwatch = {
  50: TColor.secondaryColor1.withOpacity(0.1),
  100: TColor.secondaryColor1.withOpacity(0.2),
  200: TColor.secondaryColor1.withOpacity(0.3),
  300: TColor.secondaryColor1.withOpacity(0.4),
  400: TColor.secondaryColor1.withOpacity(0.5),
  500: TColor.secondaryColor1.withOpacity(0.6),
  600: TColor.secondaryColor1.withOpacity(0.7),
  700: TColor.secondaryColor1.withOpacity(0.8),
  800: TColor.secondaryColor1.withOpacity(0.9),
  900: TColor.secondaryColor1.withOpacity(1),
};

MaterialColor secondaryColor1Swatch = MaterialColor(TColor.secondaryColor1.value, colorSwatch);