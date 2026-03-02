import 'dart:math' as math;

class SafeMath {
  static double sqrt(double value) {
    if (value < 0) return 0.0;
    return math.sqrt(value);
  }

  static double asin(double value) {
    if (value > 1.0) value = 1.0;
    if (value < -1.0) value = -1.0;
    return math.asin(value);
  }

  static double acos(double value) {
    if (value > 1.0) value = 1.0;
    if (value < -1.0) value = -1.0;
    return math.acos(value);
  }

  static double safeDiv(double a, double b) {
    if (b == 0) return 0.0;
    return a / b;
  }
}
