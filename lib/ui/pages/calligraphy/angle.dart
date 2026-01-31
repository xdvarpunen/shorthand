import 'dart:math';

class Angle {
  /// Convert degrees to radians
  static double degToRad(double degrees) => degrees * pi / 180.0;

  /// Convert radians to degrees
  static double radToDeg(double radians) => radians * 180.0 / pi;
}
