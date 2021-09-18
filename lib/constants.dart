import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kBackgroundColor = Color(0XFF2E2F41);
const kClockMainColor = Color(0XFF454975);
const kOutlineClockColor = Color(0XFFEAECFF);
const kSecHandColor = Color(0xFFFFB74D);
const kSelectedColor = Color(0XFF242734);
const kHmsStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
);
const kSelectedTextSyle = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w600,
);
const kUnselectedTextStyle = TextStyle(
  color: kClockMainColor,
  fontSize: 30.0,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w200,
);

// class GradientColors {
//   static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
//   static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
//   static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
//   static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
//   static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
// }
class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
