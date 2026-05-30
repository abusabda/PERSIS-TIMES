import 'dart:math' as math;

class SafeMath {
  static double sqrt(double value) {
    if (value < 0 || value.isNaN || value.isInfinite) return 0.0;
    return math.sqrt(value);
  }

  static double asin(double value) {
    if (value.isNaN || value.isInfinite) return 0.0;
    if (value > 1.0) value = 1.0;
    if (value < -1.0) value = -1.0;
    return math.asin(value);
  }

  static double acos(double value) {
    if (value.isNaN || value.isInfinite) return 0.0;
    if (value > 1.0) value = 1.0;
    if (value < -1.0) value = -1.0;
    return math.acos(value);
  }

  static double safeDiv(double a, double b, {double fallback = 0.0}) {
    if (a.isNaN || a.isInfinite || b.isNaN || b.isInfinite || b == 0) {
      return fallback;
    }
    final result = a / b;
    return result.isNaN || result.isInfinite ? fallback : result;
  }

  // ✅ TAMBAHKAN: Helper untuk clamp nilai ke range
  static double clamp(double value, double min, double max) {
    if (value.isNaN || value.isInfinite) return min;
    return value < min ? min : (value > max ? max : value);
  }

  // ✅ TAMBAHKAN: Helper untuk validasi double aman
  static bool isValid(double? value) =>
      value != null && !value.isNaN && !value.isInfinite;
}
