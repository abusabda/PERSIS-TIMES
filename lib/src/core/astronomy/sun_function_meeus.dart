import 'dart:math';
import '../math/math_utils.dart';
import 'nutation_meeus.dart';
import 'dynamical_time.dart';
import 'julian_day.dart';

class SunCalculator {
  final mf = MathFunction();
  final nt = NutationCalculator();
  final dt = DynamicalTime();
  final julianDay = JulianDay();

  // ═══════════════════════════════════════════════════════════════
  // ── CACHE ─────────────────────────────────────────────────────
  // earthHeliocentricLongitude, earthHeliocentricLatitude, dan
  // earthRadiusVector hanya bergantung pada `jd` (TIDAK ada deltaT
  // di versi Meeus ini — tau = (jd - 2451545)/365250 langsung dari
  // jd). Method2 lain (sunGeocentricLongitude, Latitude,
  // RightAscension, Declination, GreenwichHourAngle, equationOfTime,
  // Distance, Semidiameter, Parallax, dst) semuanya memanggil 1 atau
  // lebih dari 3 method ini dengan `jd` yang sama dalam satu iterasi
  // -> cache berbasis `jd` sudah cukup.
  // ═══════════════════════════════════════════════════════════════
  double? _cacheJdL;
  double? _cacheL;

  double? _cacheJdB;
  double? _cacheB;

  double? _cacheJdR;
  double? _cacheR;

  // ==========================================================================
  // EarthHeliocentricLongitude — DENGAN CACHE
  // ==========================================================================
  double earthHeliocentricLongitude(double jd) {
    // ✅ Cek cache dulu
    if (_cacheJdL == jd && _cacheL != null) {
      return _cacheL!;
    }

    double tau = (jd - 2451545.0) / 365250.0;

    // L0
    double l0 = 0.0;
    l0 += 175347046 * cos(0 + 0 * tau);
    l0 += 3341656 * cos(4.6692568 + 6283.07585 * tau);
    l0 += 34894 * cos(4.6261 + 12566.1517 * tau);
    l0 += 3497 * cos(2.7441 + 5753.3849 * tau);
    l0 += 3418 * cos(2.8289 + 3.5231 * tau);
    l0 += 3136 * cos(3.6277 + 77713.7715 * tau);
    l0 += 2676 * cos(4.4181 + 7860.4194 * tau);
    l0 += 2343 * cos(6.1352 + 3930.2097 * tau);
    l0 += 1324 * cos(0.7425 + 11506.7698 * tau);
    l0 += 1273 * cos(2.0371 + 529.691 * tau);
    l0 += 1199 * cos(1.1096 + 1577.3435 * tau);
    l0 += 990 * cos(5.233 + 5884.927 * tau);
    l0 += 902 * cos(2.045 + 26.298 * tau);
    l0 += 857 * cos(3.508 + 398.149 * tau);
    l0 += 780 * cos(1.179 + 5223.694 * tau);
    l0 += 753 * cos(2.533 + 5507.553 * tau);
    l0 += 505 * cos(4.583 + 18849.228 * tau);
    l0 += 492 * cos(4.205 + 775.523 * tau);
    l0 += 357 * cos(2.92 + 0.067 * tau);
    l0 += 317 * cos(5.849 + 11790.629 * tau);
    l0 += 284 * cos(1.899 + 796.298 * tau);
    l0 += 271 * cos(0.315 + 10977.079 * tau);
    l0 += 243 * cos(0.345 + 5486.778 * tau);
    l0 += 206 * cos(4.806 + 2544.314 * tau);
    l0 += 205 * cos(1.869 + 5573.143 * tau);
    l0 += 202 * cos(2.458 + 6069.777 * tau);
    l0 += 156 * cos(0.833 + 213.299 * tau);
    l0 += 132 * cos(3.411 + 2942.463 * tau);
    l0 += 126 * cos(1.083 + 20.775 * tau);
    l0 += 115 * cos(0.645 + 0.98 * tau);
    l0 += 103 * cos(0.636 + 4694.003 * tau);
    l0 += 102 * cos(0.976 + 15720.839 * tau);
    l0 += 102 * cos(4.267 + 7.114 * tau);
    l0 += 99 * cos(6.21 + 2146.17 * tau);
    l0 += 98 * cos(0.68 + 155.42 * tau);
    l0 += 86 * cos(5.98 + 161000.69 * tau);
    l0 += 85 * cos(1.3 + 6275.96 * tau);
    l0 += 85 * cos(3.67 + 71430.7 * tau);
    l0 += 80 * cos(1.81 + 17260.15 * tau);
    l0 += 79 * cos(3.04 + 12036.46 * tau);
    l0 += 75 * cos(1.76 + 5088.63 * tau);
    l0 += 74 * cos(3.5 + 3154.69 * tau);
    l0 += 74 * cos(4.68 + 801.82 * tau);
    l0 += 70 * cos(0.83 + 9437.76 * tau);
    l0 += 62 * cos(3.98 + 8827.39 * tau);
    l0 += 61 * cos(1.82 + 7084.9 * tau);
    l0 += 57 * cos(2.78 + 6286.6 * tau);
    l0 += 56 * cos(4.39 + 14143.5 * tau);
    l0 += 56 * cos(3.47 + 6279.55 * tau);
    l0 += 52 * cos(0.19 + 12139.55 * tau);
    l0 += 52 * cos(1.33 + 1748.02 * tau);
    l0 += 51 * cos(0.28 + 5856.48 * tau);
    l0 += 49 * cos(0.49 + 1194.45 * tau);
    l0 += 41 * cos(5.37 + 8429.24 * tau);
    l0 += 41 * cos(2.4 + 19651.05 * tau);
    l0 += 39 * cos(6.17 + 10447.39 * tau);
    l0 += 37 * cos(6.04 + 10213.29 * tau);
    l0 += 37 * cos(2.57 + 1059.38 * tau);
    l0 += 36 * cos(1.71 + 2352.87 * tau);
    l0 += 36 * cos(1.78 + 6812.77 * tau);
    l0 += 33 * cos(0.59 + 17789.85 * tau);
    l0 += 30 * cos(0.44 + 83996.85 * tau);
    l0 += 30 * cos(2.74 + 1349.87 * tau);
    l0 += 25 * cos(3.16 + 4690.48 * tau);

    // L1
    double l1 = 0.0;
    l1 += 628331966747.0 * cos(0 + 0 * tau);
    l1 += 206059 * cos(2.678235 + 6283.07585 * tau);
    l1 += 4303 * cos(2.6351 + 12566.1517 * tau);
    l1 += 425 * cos(1.59 + 3.523 * tau);
    l1 += 119 * cos(5.796 + 26.298 * tau);
    l1 += 109 * cos(2.966 + 1577.344 * tau);
    l1 += 93 * cos(2.59 + 18849.23 * tau);
    l1 += 72 * cos(1.14 + 529.69 * tau);
    l1 += 68 * cos(1.87 + 398.15 * tau);
    l1 += 67 * cos(4.41 + 5507.55 * tau);
    l1 += 59 * cos(2.89 + 5223.69 * tau);
    l1 += 56 * cos(2.17 + 155.42 * tau);
    l1 += 45 * cos(0.4 + 796.3 * tau);
    l1 += 36 * cos(0.47 + 775.52 * tau);
    l1 += 29 * cos(2.65 + 7.11 * tau);
    l1 += 21 * cos(5.34 + 0.98 * tau);
    l1 += 19 * cos(1.85 + 5486.78 * tau);
    l1 += 19 * cos(4.97 + 213.3 * tau);
    l1 += 17 * cos(2.99 + 6275.96 * tau);
    l1 += 16 * cos(0.03 + 2544.31 * tau);
    l1 += 16 * cos(1.43 + 2146.17 * tau);
    l1 += 15 * cos(1.21 + 10977.08 * tau);
    l1 += 12 * cos(2.83 + 1748.02 * tau);
    l1 += 12 * cos(3.26 + 5088.63 * tau);
    l1 += 12 * cos(5.27 + 1194.45 * tau);
    l1 += 12 * cos(2.08 + 4694.0 * tau);
    l1 += 11 * cos(0.77 + 553.57 * tau);
    l1 += 10 * cos(1.3 + 6286.6 * tau);
    l1 += 10 * cos(4.24 + 1349.87 * tau);
    l1 += 9 * cos(2.7 + 242.73 * tau);
    l1 += 9 * cos(5.64 + 951.72 * tau);
    l1 += 8 * cos(5.3 + 2352.87 * tau);
    l1 += 6 * cos(2.65 + 9437.76 * tau);
    l1 += 6 * cos(4.67 + 4690.48 * tau);

    // L2
    double l2 = 0.0;
    l2 += 52919 * cos(0 + 0 * tau);
    l2 += 8720 * cos(1.0721 + 6283.0758 * tau);
    l2 += 309 * cos(0.867 + 12566.152 * tau);
    l2 += 27 * cos(0.05 + 3.52 * tau);
    l2 += 16 * cos(5.19 + 26.3 * tau);
    l2 += 16 * cos(3.68 + 155.42 * tau);
    l2 += 10 * cos(0.76 + 18849.23 * tau);
    l2 += 9 * cos(2.06 + 77713.77 * tau);
    l2 += 7 * cos(0.83 + 775.52 * tau);
    l2 += 5 * cos(4.66 + 1577.34 * tau);
    l2 += 4 * cos(1.03 + 7.11 * tau);
    l2 += 4 * cos(3.44 + 5573.14 * tau);
    l2 += 3 * cos(5.14 + 796.3 * tau);
    l2 += 3 * cos(6.05 + 5507.55 * tau);
    l2 += 3 * cos(1.19 + 242.73 * tau);
    l2 += 3 * cos(6.12 + 529.69 * tau);
    l2 += 3 * cos(0.31 + 398.15 * tau);
    l2 += 3 * cos(2.28 + 553.57 * tau);
    l2 += 2 * cos(4.38 + 5223.69 * tau);
    l2 += 2 * cos(3.75 + 0.98 * tau);

    // L3
    double l3 = 0.0;
    l3 += 289 * cos(5.844 + 6283.076 * tau);
    l3 += 35 * cos(0 + 0 * tau);
    l3 += 17 * cos(5.49 + 12566.15 * tau);
    l3 += 3 * cos(5.2 + 155.42 * tau);
    l3 += 1 * cos(4.72 + 3.52 * tau);
    l3 += 1 * cos(5.3 + 18849.23 * tau);
    l3 += 1 * cos(5.97 + 242.73 * tau);

    // L4
    double l4 = 0.0;
    l4 += 114 * cos(3.142 + 0 * tau);
    l4 += 8 * cos(4.13 + 6283.08 * tau);
    l4 += 1 * cos(3.84 + 12566.15 * tau);

    // L5
    double l5 = 0.0;
    l5 += 1 * cos(3.14 + 0 * tau);

    double l =
        (l0 +
            l1 * tau +
            l2 * pow(tau, 2) +
            l3 * pow(tau, 3) +
            l4 * pow(tau, 4) +
            l5 * pow(tau, 5)) /
        100000000.0;
    l = mf.deg(l);
    l = mf.mod(l, 360.0);

    // ✅ Simpan ke cache sebelum return
    _cacheJdL = jd;
    _cacheL = l;
    return l;
  }

  // ==========================================================================
  // EarthHeliocentricLatitude — DENGAN CACHE
  // ==========================================================================
  double earthHeliocentricLatitude(double jd) {
    // ✅ Cek cache dulu
    if (_cacheJdB == jd && _cacheB != null) {
      return _cacheB!;
    }

    double tau = (jd - 2451545.0) / 365250.0;

    // B0
    double b0 = 0.0;
    b0 += 280 * cos(3.199 + 84334.662 * tau);
    b0 += 102 * cos(5.422 + 5507.553 * tau);
    b0 += 80 * cos(3.88 + 5223.69 * tau);
    b0 += 44 * cos(3.7 + 2352.87 * tau);
    b0 += 32 * cos(4.0 + 1577.34 * tau);

    // B1
    double b1 = 0.0;
    b1 += 9 * cos(3.9 + 5507.55 * tau);
    b1 += 6 * cos(1.73 + 5223.69 * tau);

    double b = (b0 + b1 * tau) / 100000000.0;
    b = mf.deg(b);

    // ✅ Simpan ke cache sebelum return
    _cacheJdB = jd;
    _cacheB = b;
    return b;
  }

  // ==========================================================================
  // EarthRadiusVector — DENGAN CACHE
  // ==========================================================================
  double earthRadiusVector(double jd) {
    // ✅ Cek cache dulu
    if (_cacheJdR == jd && _cacheR != null) {
      return _cacheR!;
    }

    double tau = (jd - 2451545.0) / 365250.0;

    // R0
    double r0 = 0.0;
    r0 += 100013989 * cos(0 + 0 * tau);
    r0 += 1670700 * cos(3.0984635 + 6283.07585 * tau);
    r0 += 13956 * cos(3.05525 + 12566.1517 * tau);
    r0 += 3084 * cos(5.1985 + 77713.7715 * tau);
    r0 += 1628 * cos(1.1739 + 5753.3849 * tau);
    r0 += 1576 * cos(2.8469 + 7860.4194 * tau);
    r0 += 925 * cos(5.453 + 11506.77 * tau);
    r0 += 542 * cos(4.564 + 3930.21 * tau);
    r0 += 472 * cos(3.661 + 5884.927 * tau);
    r0 += 346 * cos(0.964 + 5507.553 * tau);
    r0 += 329 * cos(5.9 + 5223.694 * tau);
    r0 += 307 * cos(0.299 + 5573.143 * tau);
    r0 += 243 * cos(4.273 + 11790.629 * tau);
    r0 += 212 * cos(5.847 + 1577.344 * tau);
    r0 += 186 * cos(5.022 + 10977.079 * tau);
    r0 += 175 * cos(3.012 + 18849.228 * tau);
    r0 += 110 * cos(5.055 + 5486.778 * tau);
    r0 += 98 * cos(0.89 + 6069.78 * tau);
    r0 += 86 * cos(5.69 + 15720.84 * tau);
    r0 += 86 * cos(1.27 + 161000.69 * tau);
    r0 += 65 * cos(0.27 + 17260.15 * tau);
    r0 += 63 * cos(0.92 + 529.69 * tau);
    r0 += 57 * cos(2.01 + 83996.85 * tau);
    r0 += 56 * cos(5.24 + 71430.7 * tau);
    r0 += 49 * cos(3.25 + 2544.31 * tau);
    r0 += 47 * cos(2.58 + 775.52 * tau);
    r0 += 45 * cos(5.54 + 9437.76 * tau);
    r0 += 43 * cos(6.01 + 6275.96 * tau);
    r0 += 39 * cos(5.36 + 4694.0 * tau);
    r0 += 38 * cos(2.39 + 8827.39 * tau);
    r0 += 37 * cos(0.83 + 19651.05 * tau);
    r0 += 37 * cos(4.9 + 12139.55 * tau);
    r0 += 36 * cos(1.67 + 12036.46 * tau);
    r0 += 35 * cos(1.84 + 2942.46 * tau);
    r0 += 33 * cos(0.24 + 7084.9 * tau);
    r0 += 32 * cos(0.18 + 5088.63 * tau);
    r0 += 32 * cos(1.78 + 398.15 * tau);
    r0 += 28 * cos(1.21 + 6286.6 * tau);
    r0 += 28 * cos(1.9 + 6279.55 * tau);
    r0 += 26 * cos(4.59 + 10447.39 * tau);

    // R1
    double r1 = 0.0;
    r1 += 103019 * cos(1.10749 + 6283.07585 * tau);
    r1 += 1721 * cos(1.0644 + 12566.1517 * tau);
    r1 += 702 * cos(3.142 + 0 * tau);
    r1 += 32 * cos(1.02 + 18849.23 * tau);
    r1 += 31 * cos(2.84 + 5507.55 * tau);
    r1 += 25 * cos(1.32 + 5223.69 * tau);
    r1 += 18 * cos(1.42 + 1577.34 * tau);
    r1 += 10 * cos(5.91 + 10977.08 * tau);
    r1 += 9 * cos(1.42 + 6275.96 * tau);
    r1 += 9 * cos(0.27 + 5486.78 * tau);

    // R2
    double r2 = 0.0;
    r2 += 4359 * cos(5.7846 + 6283.0758 * tau);
    r2 += 124 * cos(5.579 + 12566.152 * tau);
    r2 += 12 * cos(3.14 + 0 * tau);
    r2 += 9 * cos(3.63 + 77713.77 * tau);
    r2 += 6 * cos(1.87 + 5573.14 * tau);
    r2 += 3 * cos(5.47 + 18849.23 * tau);

    // R3
    double r3 = 0.0;
    r3 += 145 * cos(4.273 + 6283.076 * tau);
    r3 += 7 * cos(3.92 + 12566.15 * tau);

    // R4
    double r4 = 0.0;
    r4 += 4 * cos(2.56 + 6283.08 * tau);

    double r =
        (r0 +
            r1 * tau +
            r2 * pow(tau, 2) +
            r3 * pow(tau, 3) +
            r4 * pow(tau, 4)) /
        100000000.0;

    // ✅ Simpan ke cache sebelum return
    _cacheJdR = jd;
    _cacheR = r;
    return r;
  }

  // ==========================================================================
  // SunGeocentricLongitude
  // ==========================================================================
  double sunGeocentricLongitude(double jd, double deltaT, String optional) {
    double l = earthHeliocentricLongitude(jd);
    double b = earthHeliocentricLatitude(jd);
    double theta = l + 180.0;
    theta = mf.mod(theta, 360.0);
    double beta = -b;

    // To True (Geometric) Geocentric Longitude with FK5 System
    double t = (jd - 2451545.0) / 36525.0;
    double lambdaPrime = theta - 1.397 * t - 0.00031 * pow(t, 2);
    double deltaTheta =
        (-0.09033 +
            0.03916 *
                (cos(mf.rad(lambdaPrime)) + sin(mf.rad(lambdaPrime))) *
                tan(mf.rad(beta))) /
        3600.0;
    double thetaFK5 = theta + deltaTheta;

    // To Apparent Geocentric Longitude
    double deltaPsi = nt.nutationInLongitude(jd);
    double aberration = (-20.489 / earthRadiusVector(jd)) / 3600.0;
    double lambda = thetaFK5 + deltaPsi + aberration;
    lambda = mf.mod(lambda, 360.0);

    switch (optional) {
      case "True":
        return thetaFK5;
      case "Appa":
        return lambda;
      default:
        return lambda;
    }
  }

  // ==========================================================================
  // SunGeocentricLatitude
  // ==========================================================================
  double sunGeocentricLatitude(double jd, double deltaT, String optional) {
    double l = earthHeliocentricLongitude(jd);
    double b = earthHeliocentricLatitude(jd);
    double theta = l + 180.0;
    theta = mf.mod(theta, 360.0);
    double beta = -b;

    // To True (Geometric) Geocentric Latitude with FK5 System
    double t = (jd - 2451545.0) / 36525.0;
    double lambdaPrime = theta - 1.397 * t - 0.00031 * pow(t, 2);
    double deltaBeta =
        (0.03916 * (cos(mf.rad(lambdaPrime)) - sin(mf.rad(lambdaPrime)))) /
        3600.0;
    double betaFK5 = beta + deltaBeta;

    switch (optional) {
      case "True":
        return betaFK5;
      case "Appa":
        return betaFK5;
      default:
        return betaFK5;
    }
  }

  // ==========================================================================
  // SunGeocentricDistance
  // ==========================================================================
  double sunGeocentricDistance(double jd, {String optResult = ""}) {
    double r = earthRadiusVector(jd);
    double result;

    String cleanOpt = optResult.replaceAll(' ', '').toUpperCase();
    switch (cleanOpt) {
      case "AU":
        result = r;
        break;
      case "KM":
        result = r * 149597870.7;
        break;
      case "ER":
        result = r * 149597870.7 / 6371.0;
        break;
      default:
        result = r;
    }

    return result;
  }

  double sunGeocentricRightAscension(double jd, double deltaT) {
    final lambda = sunGeocentricLongitude(jd, deltaT, "Appa");
    final beta = sunGeocentricLatitude(jd, deltaT, "Appa");
    final epsilon = nt.obliquityOfEcliptic(jd);

    final alphaFK5 = mf.mod(
      mf.deg(
        atan2(
          sin(mf.rad(lambda)) * cos(mf.rad(epsilon)) -
              tan(mf.rad(beta)) * sin(mf.rad(epsilon)),
          cos(mf.rad(lambda)),
        ),
      ),
      360,
    );

    return alphaFK5;
  }

  double sunGeocentricDeclination(double jd, double deltaT) {
    final lambda = sunGeocentricLongitude(jd, deltaT, "Appa");
    final beta = sunGeocentricLatitude(jd, deltaT, "Appa");
    final epsilon = nt.obliquityOfEcliptic(jd);

    final deltaFK5 = mf.deg(
      asin(
        sin(mf.rad(beta)) * cos(mf.rad(epsilon)) +
            cos(mf.rad(beta)) * sin(mf.rad(epsilon)) * sin(mf.rad(lambda)),
      ),
    );

    return deltaFK5;
  }

  double greenwichMeanSiderialTime(double jd) {
    final t = julianDay.jc(jd);
    final gmst = mf.mod(
      280.46061837 +
          360.98564736629 * (jd - 2451545.0) +
          0.000387933 * pow(t, 2.0) -
          (pow(t, 3) / 38710000),
      360,
    );
    return gmst;
  }

  double greenwichApparentSiderialTime(double jd, double deltaT) {
    double gmst = greenwichMeanSiderialTime(jd);
    double dPsi = nt.nutationInLongitude(jd);
    double eps = nt.obliquityOfEcliptic(jd);
    double gast = mf.mod(gmst + dPsi * cos(mf.rad(eps)), 360.0);
    return gast;
  }

  double localApparentSiderialTime(double jd, double deltaT, double gLon) {
    double gast = greenwichApparentSiderialTime(jd, deltaT);
    double last = mf.mod(gast + gLon, 360.0);
    return last;
  }

  double sunGeocentricGreenwichHourAngle(double jd, double deltaT) {
    final gast = greenwichApparentSiderialTime(jd, deltaT);
    final alpha = sunGeocentricRightAscension(jd, deltaT);
    final gha = mf.mod(gast - alpha, 360.0);
    return gha;
  }

  double sunGeocentricLocalHourAngle(double jd, double deltaT, double gLon) {
    final gast = greenwichApparentSiderialTime(jd, deltaT);
    final alpha = sunGeocentricRightAscension(jd, deltaT);
    final lhaFK5 = mf.mod(gast + gLon - alpha, 360.0);
    return lhaFK5;
  }

  double sunGeocentricAzimuth(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
  ) {
    final lha = sunGeocentricLocalHourAngle(jd, deltaT, gLon);
    final dec = sunGeocentricDeclination(jd, deltaT);
    final azm = mf.mod(
      mf.deg(
            atan2(
              sin(mf.rad(lha)),
              cos(mf.rad(lha)) * sin(mf.rad(gLat)) -
                  tan(mf.rad(dec)) * cos(mf.rad(gLat)),
            ),
          ) +
          180,
      360,
    );
    return azm;
  }

  double sunGeocentricAltitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
  ) {
    final lha = sunGeocentricLocalHourAngle(jd, deltaT, gLon);
    final dec = sunGeocentricDeclination(jd, deltaT);
    final alt = mf.deg(
      asin(
        sin(mf.rad(gLat)) * sin(mf.rad(dec)) +
            cos(mf.rad(gLat)) * cos(mf.rad(dec)) * cos(mf.rad(lha)),
      ),
    );
    return alt;
  }

  double sunGeocentricSemidiameter(double jd, double deltaT) {
    double r = earthRadiusVector(jd);
    double s0 = 15 + 59.63 / 60; // 15'59.63" dalam menit
    double s = (s0 / r) / 60; // hasil dalam derajat
    return s;
  }

  double sunEquatorialHorizontalParallax(double jd, double deltaT) {
    double er = earthRadiusVector(jd);
    double phi = 8.794 / (er * 3600); // hasil dalam derajat
    return phi;
  }

  double termU(double gLat) {
    double u = atan(0.99664719 * tan(mf.rad(gLat)));
    return u;
  }

  double termX(double gLat, double elev) {
    double u = termU(gLat);
    double x = cos(u) + (elev / 6378140) * cos(mf.rad(gLat));
    return x;
  }

  double termY(double gLat, double elev) {
    double u = termU(gLat);
    double y = 0.99664719 * sin(u) + (elev / 6378140) * sin(mf.rad(gLat));
    return y;
  }

  double termN(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double lambda = sunGeocentricLongitude(jd, deltaT, "Appa");
    double beta = sunGeocentricLatitude(jd, deltaT, "Appa");
    double theta = localApparentSiderialTime(jd, deltaT, gLon);
    double x = termX(gLat, elev);
    double phi = sunEquatorialHorizontalParallax(jd, deltaT);
    double n =
        cos(mf.rad(lambda)) * cos(mf.rad(beta)) -
        x * sin(mf.rad(phi)) * cos(mf.rad(theta));
    return n;
  }

  double parallaxInTheSunRightAscension(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double x = termX(gLat, elev);
    double phi = sunEquatorialHorizontalParallax(jd, deltaT);
    double ha = sunGeocentricLocalHourAngle(jd, deltaT, gLon);
    double dec = sunGeocentricDeclination(jd, deltaT);
    double dAlpha = mf.deg(
      atan2(
        -x * sin(mf.rad(phi)) * sin(mf.rad(ha)),
        cos(mf.rad(dec)) - x * sin(mf.rad(phi)) * cos(mf.rad(ha)),
      ),
    );
    return dAlpha;
  }

  double parallaxInTheSunAltitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double h = sunGeocentricAltitude(jd, deltaT, gLon, gLat);
    double y = termY(gLat, elev);
    double x = termX(gLat, elev);
    double phi = sunEquatorialHorizontalParallax(jd, deltaT);
    double P = mf.deg(
      sin(sqrt(y * y + x * x) * sin(mf.rad(phi)) * cos(mf.rad(h))),
    );
    return P;
  }

  double atmosphericRefractionFromAirlessAltitude(
    double airlessAltitude,
    double pressure,
    double temperature,
  ) {
    double h = airlessAltitude;
    double P = pressure;
    double t = temperature;
    return (1.02 /
                tan(mf.rad(h + 10.3 / (h + 5.11))) *
                P /
                1010 *
                283 /
                (273 + t) +
            0.0019279204034639303) /
        60;
  }

  double sunTopocentricLongitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double lambda = sunGeocentricLongitude(jd, deltaT, "Appa");
    double beta = sunGeocentricLatitude(jd, deltaT, "Appa");
    double phi = sunEquatorialHorizontalParallax(jd, deltaT);
    double theta = localApparentSiderialTime(jd, deltaT, gLon);
    double eps = nt.obliquityOfEcliptic(jd);
    double x = termX(gLat, elev);
    double y = termY(gLat, elev);
    double n = termN(jd, deltaT, gLon, gLat, elev);

    double lmbdP = mf.mod(
      mf.deg(
        atan2(
          (sin(mf.rad(lambda)) * cos(mf.rad(beta)) -
              sin(mf.rad(phi)) *
                  (y * sin(mf.rad(eps)) +
                      x * cos(mf.rad(eps)) * sin(mf.rad(theta)))),
          n,
        ),
      ),
      360,
    );
    return lmbdP;
  }

  double sunTopocentricLatitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double lmbdP = sunTopocentricLongitude(jd, deltaT, gLon, gLat, elev);
    double beta = sunGeocentricLatitude(jd, deltaT, "Appa");
    double phi = sunEquatorialHorizontalParallax(jd, deltaT);
    double theta = localApparentSiderialTime(jd, deltaT, gLon);
    double eps = nt.obliquityOfEcliptic(jd);
    double x = termX(gLat, elev);
    double y = termY(gLat, elev);
    double n = termN(jd, deltaT, gLon, gLat, elev);

    double btaP = mf.deg(
      atan(
        cos(mf.rad(lmbdP)) *
            (sin(mf.rad(beta)) -
                sin(mf.rad(phi)) *
                    (y * cos(mf.rad(eps)) -
                        x * sin(mf.rad(eps)) * sin(mf.rad(theta)))) /
            n,
      ),
    );
    return btaP;
  }

  double sunTopocentricRightAscension(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double alpha = sunGeocentricRightAscension(jd, deltaT);
    double dAlpha = parallaxInTheSunRightAscension(
      jd,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    double alphP = alpha + dAlpha;
    return alphP;
  }

  double sunTopocentricDeclination(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double dec = sunGeocentricDeclination(jd, deltaT);
    double y = termY(gLat, elev);
    double x = termX(gLat, elev);
    double phi = sunEquatorialHorizontalParallax(jd, deltaT);
    double dAlph = parallaxInTheSunRightAscension(jd, deltaT, gLon, gLat, elev);
    double ha = sunGeocentricLocalHourAngle(jd, deltaT, gLon);

    double dltP = mf.deg(
      atan2(
        (sin(mf.rad(dec)) - y * sin(mf.rad(phi))) * cos(mf.rad(dAlph)),
        cos(mf.rad(dec)) - x * sin(mf.rad(phi)) * cos(mf.rad(ha)),
      ),
    );

    return dltP;
  }

  double sunTopocentricGreenwichHourAngle(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double gast = greenwichApparentSiderialTime(jd, deltaT);
    double alpha = sunTopocentricRightAscension(jd, deltaT, gLon, gLat, elev);
    double gha = mf.mod(gast - alpha, 360.0);
    return gha;
  }

  double sunTopocentricLocalHourAngel(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double lha = sunGeocentricLocalHourAngle(jd, deltaT, gLon);
    double dAlph = parallaxInTheSunRightAscension(jd, deltaT, gLon, gLat, elev);
    double lhaP = lha - dAlph;
    return lhaP;
  }

  double sunTopocentricAzimuth(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double lhaP = sunTopocentricLocalHourAngel(jd, deltaT, gLon, gLat, elev);
    double dltP = sunTopocentricDeclination(jd, deltaT, gLon, gLat, elev);

    double azmP = mf.mod(
      mf.deg(
            atan2(
              sin(mf.rad(lhaP)),
              cos(mf.rad(lhaP)) * sin(mf.rad(gLat)) -
                  tan(mf.rad(dltP)) * cos(mf.rad(gLat)),
            ),
          ) +
          180,
      360,
    );

    return azmP;
  }

  double sunTopocentricAltitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
    double pres,
    double temp,
    String opt, // default sama dengan Kotlin else-case
  ) {
    double dec = sunTopocentricDeclination(jd, deltaT, gLon, gLat, elev);
    double lha = sunTopocentricLocalHourAngel(jd, deltaT, gLon, gLat, elev);
    double dip = 1.75 / 60 * sqrt(elev);
    double sdm = sunTopocentricSemidiameter(jd, deltaT, gLon, gLat, elev);

    //double h = sunGeocentricAltitude(jd, deltaT, gLon, gLat);

    //Airless Altitude
    double htc = mf.deg(
      asin(
        sin(mf.rad(gLat)) * sin(mf.rad(dec)) +
            cos(mf.rad(gLat)) * cos(mf.rad(dec)) * cos(mf.rad(lha)),
      ),
    ); //center

    double htu = htc + sdm; //upper
    double htl = htc - sdm; //Lower

    //Refraksi Upper,Center dan Lower
    double rhtu = atmosphericRefractionFromAirlessAltitude(htu, pres, temp);
    double rhtc = atmosphericRefractionFromAirlessAltitude(htc, pres, temp);
    double rhtl = atmosphericRefractionFromAirlessAltitude(htc, pres, temp);

    //Apparent Altitude
    double htau = htu + rhtu;
    double htac = htc + rhtc;
    double htal = htl + rhtl;

    //observered Altitude

    double htou = htau + dip;
    double htoc = htac + dip;
    double htol = htal + dip;

    switch (opt) {
      case "htu":
        return htu;
      case "htc":
        return htc;
      case "htl":
        return htl;

      case "htau":
        return htau;
      case "htac":
        return htac;
      case "htal":
        return htal;

      case "htou":
        return htou;
      case "htoc":
        return htoc;
      case "htol":
        return htol;
      default:
        return htc;
    }
  }

  double sunTopocentricSemidiameter(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double lmbdP = sunTopocentricLongitude(jd, deltaT, gLon, gLat, elev);
    double betaP = sunTopocentricLatitude(jd, deltaT, gLon, gLat, elev);
    double s = sunGeocentricSemidiameter(jd, deltaT);
    double n = termN(jd, deltaT, gLon, gLat, elev);

    double sP = mf.deg(
      asin(cos(mf.rad(lmbdP)) * cos(mf.rad(betaP)) * sin(mf.rad(s)) / n),
    );

    return sP;
  }

  double equationOfTime(double jd, double deltaT) {
    double jde = jd + deltaT / 86400;
    double t = julianDay.jc(jde);
    double tau = julianDay.jm(t);

    double alpha = sunGeocentricRightAscension(jd, deltaT);
    double dPsi = nt.nutationInLongitude(jd);
    double epsln = nt.obliquityOfEcliptic(jd);

    double lo = mf.mod(
      280.4664567 +
          360007.6982779 * tau +
          0.03032028 * pow(tau, 2.0) +
          pow(tau, 3.0) / 49931 -
          pow(tau, 4.0) / 15300 -
          pow(tau, 5.0) / 2000000,
      360,
    );

    double e = lo - 0.0057183 - alpha + dPsi * cos(mf.rad(epsln));

    if ((e.abs() * 4) < 20) {
      e = e / 15;
    } else if ((e.abs() * 4 >= 20) && (e > 0)) {
      e = e / 15 - 24;
    } else if ((e.abs() * 4 >= 20) && (e < 0)) {
      e = e / 15 + 24;
    } else {
      e = e / 15;
    }

    return e;
  }

  double jdGhurubSyams(
    double jdNM,
    double gLat,
    double gLon,
    double gAlt,
    double tmZn,
  ) {
    double cjdn;
    double jdGS = 0.0;
    double jdEGS;
    double dltS, sdS, eot, rfS, dip, altTS, coshaS, haS, kwd;
    double jSunSet = 17.0;

    // ✅ FIX: Konversi jdNM ke local calendar day
    cjdn = (jdNM + 0.5 + tmZn / 24.0).floorToDouble();

    for (int itr = 1; itr <= 2; itr++) {
      // jdGS tetap dalam UT: LCT - tmZn
      jdGS = cjdn - 0.5 + (jSunSet - tmZn) / 24.0;
      jdEGS = jdGS + dt.deltaT(jdGS) / 86400.0;

      dltS = sunGeocentricDeclination(jdEGS, 0);
      sdS = sunGeocentricSemidiameter(jdEGS, 0);
      eot = equationOfTime(jdEGS, 0);

      rfS = 34.16 / 60.0;
      dip = 2.1 * sqrt(gAlt) / 60.0;
      altTS = -(sdS + rfS + dip - 0.0024);

      coshaS =
          (sin(mf.rad(altTS)) - sin(mf.rad(gLat)) * sin(mf.rad(dltS))) /
          (cos(mf.rad(gLat)) * cos(mf.rad(dltS)));

      if (coshaS.abs() < 1) {
        haS = mf.deg(acos(coshaS));
        kwd = gLon / 15.0 - tmZn;
        jSunSet = haS / 15.0 + 12.0 - eot - kwd;
        jdGS = cjdn - 0.5 + (jSunSet - tmZn) / 24.0;
      } else {
        jdGS = 0.0;
      }
    }

    return jdGS;
  }

  double jdGhurubSyams2(
    //ghrub UT
    double jdNM,
    double gLat,
    double gLon,
    double gAlt,
    double tmZn,
  ) {
    double cjdn;
    double jdGS = 0.0;
    double jdEGS;
    double dltS, sdS, eot, rfS, dip, altTS, coshaS, haS, kwd;
    double jSunSet = 17.0;

    // ✅ FIX: Konversi jdNM ke local calendar day
    cjdn = (jdNM + 0.5 + 0.0 / 24.0).floorToDouble();

    for (int itr = 1; itr <= 2; itr++) {
      // jdGS tetap dalam UT: LCT - tmZn
      jdGS = cjdn - 0.5 + (jSunSet - tmZn) / 24.0;
      jdEGS = jdGS + dt.deltaT(jdGS) / 86400.0;

      dltS = sunGeocentricDeclination(jdEGS, 0);
      sdS = sunGeocentricSemidiameter(jdEGS, 0);
      eot = equationOfTime(jdEGS, 0);

      rfS = 34.16 / 60.0;
      dip = 2.1 * sqrt(gAlt) / 60.0;
      altTS = -(sdS + rfS + dip - 0.0024);

      coshaS =
          (sin(mf.rad(altTS)) - sin(mf.rad(gLat)) * sin(mf.rad(dltS))) /
          (cos(mf.rad(gLat)) * cos(mf.rad(dltS)));

      if (coshaS.abs() < 1) {
        haS = mf.deg(acos(coshaS));
        kwd = gLon / 15.0 - tmZn;
        jSunSet = haS / 15.0 + 12.0 - eot - kwd;
        jdGS = cjdn - 0.5 + (jSunSet - tmZn) / 24.0;
      } else {
        jdGS = 0.0;
      }
    }

    return jdGS;
  }
}
