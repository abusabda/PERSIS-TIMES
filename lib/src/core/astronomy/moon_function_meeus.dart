import 'dart:math';
import '../math/math_utils.dart';
import 'sun_function_meeus.dart';
import 'nutation_meeus.dart';
import 'julian_day.dart';
import 'dynamical_time.dart';

class MoonCalculator {
  final mf = MathFunction();
  final sn = SunCalculator();
  final nt = NutationCalculator();
  final jd = JulianDay();
  final dt = DynamicalTime();

  // ═══════════════════════════════════════════════════════════════
  // ── CACHE ─────────────────────────────────────────────────────
  // moonGeocentricLongitude, moonGeocentricLatitude, dan
  // moonGeocentricDistance masing-masing hanya bergantung pada `jd`
  // (deltaT tidak dipakai dalam rumus, dan optResult/opt mengubah
  // hasil akhir -> key cache menyertakan opt).
  //
  // Method2 lain (RightAscension, Declination, GreenwichHourAngle,
  // Elongation, PhaseAngle, IlluminatedFraction, BrightLimbAngle,
  // Topocentric*, dst) semuanya memanggil 1 atau lebih dari 3 method
  // ini dengan `jd` yang sama dalam satu iterasi -> cache berbasis
  // (jd, opt) sudah cukup efektif.
  // ═══════════════════════════════════════════════════════════════
  double? _cacheJdLon;
  String? _cacheOptLon;
  double? _cacheLon;

  double? _cacheJdLat;
  String? _cacheOptLat;
  double? _cacheLat;

  double? _cacheJdDist;
  String? _cacheOptDist;
  double? _cacheDist;

  // ==========================================================================
  // MoonGeocentricLongitude (λ) — DENGAN CACHE
  // ==========================================================================
  double moonGeocentricLongitude(double jd, double deltaT, String opt) {
    // ✅ Cek cache dulu
    if (_cacheJdLon == jd && _cacheOptLon == opt && _cacheLon != null) {
      return _cacheLon!;
    }

    double t = (jd - 2451545.0) / 36525.0;

    // Fundamental arguments (dalam derajat)
    double lPrime =
        218.3164477 +
        481267.88123421 * t -
        0.0015786 * pow(t, 2) +
        pow(t, 3) / 538841 -
        pow(t, 4) / 65194000;
    double d =
        297.8501921 +
        445267.1114034 * t -
        0.0018819 * pow(t, 2) +
        pow(t, 3) / 545868 -
        pow(t, 4) / 113065000;
    double m =
        357.5291092 +
        35999.0502909 * t -
        0.0001536 * pow(t, 2) +
        pow(t, 3) / 24490000;
    double mPrime =
        134.9633964 +
        477198.8675055 * t +
        0.0087414 * pow(t, 2) +
        pow(t, 3) / 69699 -
        pow(t, 4) / 14712000;
    double f =
        93.272095 +
        483202.0175233 * t -
        0.0036539 * pow(t, 2) -
        pow(t, 3) / 3526000 +
        pow(t, 4) / 863310000;
    double a1 = 119.75 + 131.849 * t;
    double a2 = 53.09 + 479264.29 * t;
    double a3 = 313.45 + 481266.484 * t;
    double e = 1 - 0.002516 * t - 0.0000074 * pow(t, 2);

    // Konversi ke radian
    lPrime = mf.rad(mf.mod(lPrime, 360.0));
    d = mf.rad(mf.mod(d, 360.0));
    m = mf.rad(mf.mod(m, 360.0));
    mPrime = mf.rad(mf.mod(mPrime, 360.0));
    f = mf.rad(mf.mod(f, 360.0));
    a1 = mf.rad(mf.mod(a1, 360.0));
    a2 = mf.rad(mf.mod(a2, 360.0));
    a3 = mf.rad(mf.mod(a3, 360.0));

    // Perhitungan Longitude (dalam satuan 0.000001 derajat)
    double lM = 0.0;
    lM += 6288774 * pow(e, 0) * sin(0 * d + 0 * m + 1 * mPrime + 0 * f);
    lM += 1274027 * pow(e, 0) * sin(2 * d + 0 * m + -1 * mPrime + 0 * f);
    lM += 658314 * pow(e, 0) * sin(2 * d + 0 * m + 0 * mPrime + 0 * f);
    lM += 213618 * pow(e, 0) * sin(0 * d + 0 * m + 2 * mPrime + 0 * f);
    lM += -185116 * pow(e, 1) * sin(0 * d + 1 * m + 0 * mPrime + 0 * f);
    lM += -114332 * pow(e, 0) * sin(0 * d + 0 * m + 0 * mPrime + 2 * f);
    lM += 58793 * pow(e, 0) * sin(2 * d + 0 * m + -2 * mPrime + 0 * f);
    lM += 57066 * pow(e, 1) * sin(2 * d + -1 * m + -1 * mPrime + 0 * f);
    lM += 53322 * pow(e, 0) * sin(2 * d + 0 * m + 1 * mPrime + 0 * f);
    lM += 45758 * pow(e, 1) * sin(2 * d + -1 * m + 0 * mPrime + 0 * f);
    lM += -40923 * pow(e, 1) * sin(0 * d + 1 * m + -1 * mPrime + 0 * f);
    lM += -34720 * pow(e, 0) * sin(1 * d + 0 * m + 0 * mPrime + 0 * f);
    lM += -30383 * pow(e, 1) * sin(0 * d + 1 * m + 1 * mPrime + 0 * f);
    lM += 15327 * pow(e, 0) * sin(2 * d + 0 * m + 0 * mPrime + -2 * f);
    lM += -12528 * pow(e, 0) * sin(0 * d + 0 * m + 1 * mPrime + 2 * f);
    lM += 10980 * pow(e, 0) * sin(0 * d + 0 * m + 1 * mPrime + -2 * f);
    lM += 10675 * pow(e, 0) * sin(4 * d + 0 * m + -1 * mPrime + 0 * f);
    lM += 10034 * pow(e, 0) * sin(0 * d + 0 * m + 3 * mPrime + 0 * f);
    lM += 8548 * pow(e, 0) * sin(4 * d + 0 * m + -2 * mPrime + 0 * f);
    lM += -7888 * pow(e, 1) * sin(2 * d + 1 * m + -1 * mPrime + 0 * f);
    lM += -6766 * pow(e, 1) * sin(2 * d + 1 * m + 0 * mPrime + 0 * f);
    lM += -5163 * pow(e, 0) * sin(1 * d + 0 * m + -1 * mPrime + 0 * f);
    lM += 4987 * pow(e, 1) * sin(1 * d + 1 * m + 0 * mPrime + 0 * f);
    lM += 4036 * pow(e, 1) * sin(2 * d + -1 * m + 1 * mPrime + 0 * f);
    lM += 3994 * pow(e, 0) * sin(2 * d + 0 * m + 2 * mPrime + 0 * f);
    lM += 3861 * pow(e, 0) * sin(4 * d + 0 * m + 0 * mPrime + 0 * f);
    lM += 3665 * pow(e, 0) * sin(2 * d + 0 * m + -3 * mPrime + 0 * f);
    lM += -2689 * pow(e, 1) * sin(0 * d + 1 * m + -2 * mPrime + 0 * f);
    lM += -2602 * pow(e, 0) * sin(2 * d + 0 * m + -1 * mPrime + 2 * f);
    lM += 2390 * pow(e, 1) * sin(2 * d + -1 * m + -2 * mPrime + 0 * f);
    lM += -2348 * pow(e, 0) * sin(1 * d + 0 * m + 1 * mPrime + 0 * f);
    lM += 2236 * pow(e, 2) * sin(2 * d + -2 * m + 0 * mPrime + 0 * f);
    lM += -2120 * pow(e, 1) * sin(0 * d + 1 * m + 2 * mPrime + 0 * f);
    lM += -2069 * pow(e, 2) * sin(0 * d + 2 * m + 0 * mPrime + 0 * f);
    lM += 2048 * pow(e, 2) * sin(2 * d + -2 * m + -1 * mPrime + 0 * f);
    lM += -1773 * pow(e, 0) * sin(2 * d + 0 * m + 1 * mPrime + -2 * f);
    lM += -1595 * pow(e, 0) * sin(2 * d + 0 * m + 0 * mPrime + 2 * f);
    lM += 1215 * pow(e, 1) * sin(4 * d + -1 * m + -1 * mPrime + 0 * f);
    lM += -1110 * pow(e, 0) * sin(0 * d + 0 * m + 2 * mPrime + 2 * f);
    lM += -892 * pow(e, 0) * sin(3 * d + 0 * m + -1 * mPrime + 0 * f);
    lM += -810 * pow(e, 1) * sin(2 * d + 1 * m + 1 * mPrime + 0 * f);
    lM += 759 * pow(e, 1) * sin(4 * d + -1 * m + -2 * mPrime + 0 * f);
    lM += -713 * pow(e, 2) * sin(0 * d + 2 * m + -1 * mPrime + 0 * f);
    lM += -700 * pow(e, 2) * sin(2 * d + 2 * m + -1 * mPrime + 0 * f);
    lM += 691 * pow(e, 1) * sin(2 * d + 1 * m + -2 * mPrime + 0 * f);
    lM += 596 * pow(e, 1) * sin(2 * d + -1 * m + 0 * mPrime + -2 * f);
    lM += 549 * pow(e, 0) * sin(4 * d + 0 * m + 1 * mPrime + 0 * f);
    lM += 537 * pow(e, 0) * sin(0 * d + 0 * m + 4 * mPrime + 0 * f);
    lM += 520 * pow(e, 1) * sin(4 * d + -1 * m + 0 * mPrime + 0 * f);
    lM += -487 * pow(e, 0) * sin(1 * d + 0 * m + -2 * mPrime + 0 * f);
    lM += -399 * pow(e, 1) * sin(2 * d + 1 * m + 0 * mPrime + -2 * f);
    lM += -381 * pow(e, 0) * sin(0 * d + 0 * m + 2 * mPrime + -2 * f);
    lM += 351 * pow(e, 1) * sin(1 * d + 1 * m + 1 * mPrime + 0 * f);
    lM += -340 * pow(e, 0) * sin(3 * d + 0 * m + -2 * mPrime + 0 * f);
    lM += 330 * pow(e, 0) * sin(4 * d + 0 * m + -3 * mPrime + 0 * f);
    lM += 327 * pow(e, 1) * sin(2 * d + -1 * m + 2 * mPrime + 0 * f);
    lM += -323 * pow(e, 2) * sin(0 * d + 2 * m + 1 * mPrime + 0 * f);
    lM += 299 * pow(e, 1) * sin(1 * d + 1 * m + -1 * mPrime + 0 * f);
    lM += 294 * pow(e, 0) * sin(2 * d + 0 * m + 3 * mPrime + 0 * f);
    // Baris berikut bernilai 0, tetap disertakan untuk konsistensi
    lM += 0 * sin(2 * d + 0 * m + -1 * mPrime + -2 * f);

    // Tambahan periodik
    lM += (3958 * sin(a1) + 1962 * sin(lPrime - f) + 318 * sin(a2));

    // Longitude geometrik (derajat)
    double lMTrue = mf.deg(lPrime) + lM / 1000000.0;
    lMTrue = mf.mod(lMTrue, 360.0);

    // Longitude apparent (dengan nutasi)
    double lMAppa = lMTrue + nt.nutationInLongitude(jd);
    lMAppa = mf.mod(lMAppa, 360.0);

    double result;
    switch (opt) {
      case "":
      case "True":
        result = lMTrue;
        break;
      case "Appa":
        result = lMAppa;
        break;
      default:
        result = lMAppa;
    }

    // ✅ Simpan ke cache sebelum return
    _cacheJdLon = jd;
    _cacheOptLon = opt;
    _cacheLon = result;
    return result;
  }

  // ==========================================================================
  // MoonGeocentricLatitude (β) — DENGAN CACHE
  // ==========================================================================
  double moonGeocentricLatitude(double jd, double deltaT, String opt) {
    // ✅ Cek cache dulu
    if (_cacheJdLat == jd && _cacheOptLat == opt && _cacheLat != null) {
      return _cacheLat!;
    }

    double t = (jd - 2451545.0) / 36525.0;

    // Fundamental arguments
    double lPrime =
        218.3164477 +
        481267.88123421 * t -
        0.0015786 * pow(t, 2) +
        pow(t, 3) / 538841 -
        pow(t, 4) / 65194000;
    double d =
        297.8501921 +
        445267.1114034 * t -
        0.0018819 * pow(t, 2) +
        pow(t, 3) / 545868 -
        pow(t, 4) / 113065000;
    double m =
        357.5291092 +
        35999.0502909 * t -
        0.0001536 * pow(t, 2) +
        pow(t, 3) / 24490000;
    double mPrime =
        134.9633964 +
        477198.8675055 * t +
        0.0087414 * pow(t, 2) +
        pow(t, 3) / 69699 -
        pow(t, 4) / 14712000;
    double f =
        93.272095 +
        483202.0175233 * t -
        0.0036539 * pow(t, 2) -
        pow(t, 3) / 3526000 +
        pow(t, 4) / 863310000;
    double a1 = 119.75 + 131.849 * t;
    double a2 = 53.09 + 479264.29 * t;
    double a3 = 313.45 + 481266.484 * t;
    double e = 1 - 0.002516 * t - 0.0000074 * pow(t, 2);

    // Konversi ke radian
    lPrime = mf.rad(mf.mod(lPrime, 360.0));
    d = mf.rad(mf.mod(d, 360.0));
    m = mf.rad(mf.mod(m, 360.0));
    mPrime = mf.rad(mf.mod(mPrime, 360.0));
    f = mf.rad(mf.mod(f, 360.0));
    a1 = mf.rad(mf.mod(a1, 360.0));
    a2 = mf.rad(mf.mod(a2, 360.0));
    a3 = mf.rad(mf.mod(a3, 360.0));

    // Perhitungan Latitude (dalam satuan 0.000001 derajat)
    double bM = 0.0;
    bM += 5128122 * pow(e, 0) * sin(0 * d + 0 * m + 0 * mPrime + 1 * f);
    bM += 280602 * pow(e, 0) * sin(0 * d + 0 * m + 1 * mPrime + 1 * f);
    bM += 277693 * pow(e, 0) * sin(0 * d + 0 * m + 1 * mPrime + -1 * f);
    bM += 173237 * pow(e, 0) * sin(2 * d + 0 * m + 0 * mPrime + -1 * f);
    bM += 55413 * pow(e, 0) * sin(2 * d + 0 * m + -1 * mPrime + 1 * f);
    bM += 46271 * pow(e, 0) * sin(2 * d + 0 * m + -1 * mPrime + -1 * f);
    bM += 32573 * pow(e, 0) * sin(2 * d + 0 * m + 0 * mPrime + 1 * f);
    bM += 17198 * pow(e, 0) * sin(0 * d + 0 * m + 2 * mPrime + 1 * f);
    bM += 9266 * pow(e, 0) * sin(2 * d + 0 * m + 1 * mPrime + -1 * f);
    bM += 8822 * pow(e, 0) * sin(0 * d + 0 * m + 2 * mPrime + -1 * f);
    bM += 8216 * pow(e, 1) * sin(2 * d + -1 * m + 0 * mPrime + -1 * f);
    bM += 4324 * pow(e, 0) * sin(2 * d + 0 * m + -2 * mPrime + -1 * f);
    bM += 4200 * pow(e, 0) * sin(2 * d + 0 * m + 1 * mPrime + 1 * f);
    bM += -3359 * pow(e, 1) * sin(2 * d + 1 * m + 0 * mPrime + -1 * f);
    bM += 2463 * pow(e, 1) * sin(2 * d + -1 * m + -1 * mPrime + 1 * f);
    bM += 2211 * pow(e, 1) * sin(2 * d + -1 * m + 0 * mPrime + 1 * f);
    bM += 2065 * pow(e, 1) * sin(2 * d + -1 * m + -1 * mPrime + -1 * f);
    bM += -1870 * pow(e, 1) * sin(0 * d + 1 * m + -1 * mPrime + -1 * f);
    bM += 1828 * pow(e, 0) * sin(4 * d + 0 * m + -1 * mPrime + -1 * f);
    bM += -1794 * pow(e, 1) * sin(0 * d + 1 * m + 0 * mPrime + 1 * f);
    bM += -1749 * pow(e, 0) * sin(0 * d + 0 * m + 0 * mPrime + 3 * f);
    bM += -1565 * pow(e, 1) * sin(0 * d + 1 * m + -1 * mPrime + 1 * f);
    bM += -1491 * pow(e, 0) * sin(1 * d + 0 * m + 0 * mPrime + 1 * f);
    bM += -1475 * pow(e, 1) * sin(0 * d + 1 * m + 1 * mPrime + 1 * f);
    bM += -1410 * pow(e, 1) * sin(0 * d + 1 * m + 1 * mPrime + -1 * f);
    bM += -1344 * pow(e, 1) * sin(0 * d + 1 * m + 0 * mPrime + -1 * f);
    bM += -1335 * pow(e, 0) * sin(1 * d + 0 * m + 0 * mPrime + -1 * f);
    bM += 1107 * pow(e, 0) * sin(0 * d + 0 * m + 3 * mPrime + 1 * f);
    bM += 1021 * pow(e, 0) * sin(4 * d + 0 * m + 0 * mPrime + -1 * f);
    bM += 833 * pow(e, 0) * sin(4 * d + 0 * m + -1 * mPrime + 1 * f);
    bM += 777 * pow(e, 0) * sin(0 * d + 0 * m + 1 * mPrime + -3 * f);
    bM += 671 * pow(e, 0) * sin(4 * d + 0 * m + -2 * mPrime + 1 * f);
    bM += 607 * pow(e, 0) * sin(2 * d + 0 * m + 0 * mPrime + -3 * f);
    bM += 596 * pow(e, 0) * sin(2 * d + 0 * m + 2 * mPrime + -1 * f);
    bM += 491 * pow(e, 1) * sin(2 * d + -1 * m + 1 * mPrime + -1 * f);
    bM += -451 * pow(e, 0) * sin(2 * d + 0 * m + -2 * mPrime + 1 * f);
    bM += 439 * pow(e, 0) * sin(0 * d + 0 * m + 3 * mPrime + -1 * f);
    bM += 422 * pow(e, 0) * sin(2 * d + 0 * m + 2 * mPrime + 1 * f);
    bM += 421 * pow(e, 0) * sin(2 * d + 0 * m + -3 * mPrime + -1 * f);
    bM += -366 * pow(e, 1) * sin(2 * d + 1 * m + -1 * mPrime + 1 * f);
    bM += -351 * pow(e, 1) * sin(2 * d + 1 * m + 0 * mPrime + 1 * f);
    bM += 331 * pow(e, 0) * sin(4 * d + 0 * m + 0 * mPrime + 1 * f);
    bM += 315 * pow(e, 1) * sin(2 * d + -1 * m + 1 * mPrime + 1 * f);
    bM += 302 * pow(e, 2) * sin(2 * d + -2 * m + 0 * mPrime + -1 * f);
    bM += -283 * pow(e, 0) * sin(0 * d + 0 * m + 1 * mPrime + 3 * f);
    bM += -229 * pow(e, 1) * sin(2 * d + 1 * m + 1 * mPrime + -1 * f);
    bM += 223 * pow(e, 1) * sin(1 * d + 1 * m + 0 * mPrime + -1 * f);
    bM += 223 * pow(e, 1) * sin(1 * d + 1 * m + 0 * mPrime + 1 * f);
    bM += -220 * pow(e, 1) * sin(0 * d + 1 * m + -2 * mPrime + -1 * f);
    bM += -220 * pow(e, 1) * sin(2 * d + 1 * m + -1 * mPrime + -1 * f);
    bM += -185 * pow(e, 0) * sin(1 * d + 0 * m + 1 * mPrime + 1 * f);
    bM += 181 * pow(e, 1) * sin(2 * d + -1 * m + -2 * mPrime + -1 * f);
    bM += -177 * pow(e, 1) * sin(0 * d + 1 * m + 2 * mPrime + 1 * f);
    bM += 176 * pow(e, 0) * sin(4 * d + 0 * m + -2 * mPrime + -1 * f);
    bM += 166 * pow(e, 1) * sin(4 * d + -1 * m + -1 * mPrime + -1 * f);
    bM += -164 * pow(e, 0) * sin(1 * d + 0 * m + 1 * mPrime + -1 * f);
    bM += 132 * pow(e, 0) * sin(4 * d + 0 * m + 1 * mPrime + -1 * f);
    bM += -119 * pow(e, 0) * sin(1 * d + 0 * m + -1 * mPrime + -1 * f);
    bM += 115 * pow(e, 1) * sin(4 * d + -1 * m + 0 * mPrime + -1 * f);
    bM += 107 * pow(e, 2) * sin(2 * d + -2 * m + 0 * mPrime + 1 * f);

    // Tambahan periodik
    bM +=
        (-2235 * sin(lPrime) +
        382 * sin(a3) +
        175 * sin(a1 - f) +
        175 * sin(a1 + f) +
        127 * sin(lPrime - mPrime) -
        115 * sin(lPrime + mPrime));

    bM = bM / 1000000.0;

    double result;
    switch (opt) {
      case "":
      case "True":
        result = bM;
        break;
      case "Appa":
        result = bM;
        break;
      default:
        result = bM;
    }

    // ✅ Simpan ke cache sebelum return
    _cacheJdLat = jd;
    _cacheOptLat = opt;
    _cacheLat = result;
    return result;
  }

  // ==========================================================================
  // MoonGeocentricDistance (r) — DENGAN CACHE
  // ==========================================================================
  double moonGeocentricDistance(double jd, {String optResult = ""}) {
    final cleanOpt = optResult.replaceAll(' ', '').toUpperCase();

    // ✅ Cek cache dulu
    if (_cacheJdDist == jd && _cacheOptDist == cleanOpt && _cacheDist != null) {
      return _cacheDist!;
    }

    double t = (jd - 2451545.0) / 36525.0;

    // Fundamental arguments
    double lPrime =
        218.3164477 +
        481267.88123421 * t -
        0.0015786 * pow(t, 2) +
        pow(t, 3) / 538841 -
        pow(t, 4) / 65194000;
    double d =
        297.8501921 +
        445267.1114034 * t -
        0.0018819 * pow(t, 2) +
        pow(t, 3) / 545868 -
        pow(t, 4) / 113065000;
    double m =
        357.5291092 +
        35999.0502909 * t -
        0.0001536 * pow(t, 2) +
        pow(t, 3) / 24490000;
    double mPrime =
        134.9633964 +
        477198.8675055 * t +
        0.0087414 * pow(t, 2) +
        pow(t, 3) / 69699 -
        pow(t, 4) / 14712000;
    double f =
        93.272095 +
        483202.0175233 * t -
        0.0036539 * pow(t, 2) -
        pow(t, 3) / 3526000 +
        pow(t, 4) / 863310000;
    double a1 = 119.75 + 131.849 * t;
    double a2 = 53.09 + 479264.29 * t;
    double a3 = 313.45 + 481266.484 * t;
    double e = 1 - 0.002516 * t - 0.0000074 * pow(t, 2);

    // Konversi ke radian
    lPrime = mf.rad(mf.mod(lPrime, 360.0));
    d = mf.rad(mf.mod(d, 360.0));
    m = mf.rad(mf.mod(m, 360.0));
    mPrime = mf.rad(mf.mod(mPrime, 360.0));
    f = mf.rad(mf.mod(f, 360.0));
    a1 = mf.rad(mf.mod(a1, 360.0));
    a2 = mf.rad(mf.mod(a2, 360.0));
    a3 = mf.rad(mf.mod(a3, 360.0));

    // Perhitungan Distance (dalam satuan 0.001 km)
    double rM = 0.0;
    rM += -20905355 * pow(e, 0) * cos(0 * d + 0 * m + 1 * mPrime + 0 * f);
    rM += -3699111 * pow(e, 0) * cos(2 * d + 0 * m + -1 * mPrime + 0 * f);
    rM += -2955968 * pow(e, 0) * cos(2 * d + 0 * m + 0 * mPrime + 0 * f);
    rM += -569925 * pow(e, 0) * cos(0 * d + 0 * m + 2 * mPrime + 0 * f);
    rM += 48888 * pow(e, 1) * cos(0 * d + 1 * m + 0 * mPrime + 0 * f);
    rM += -3149 * pow(e, 0) * cos(0 * d + 0 * m + 0 * mPrime + 2 * f);
    rM += 246158 * pow(e, 0) * cos(2 * d + 0 * m + -2 * mPrime + 0 * f);
    rM += -152138 * pow(e, 1) * cos(2 * d + -1 * m + -1 * mPrime + 0 * f);
    rM += -170733 * pow(e, 0) * cos(2 * d + 0 * m + 1 * mPrime + 0 * f);
    rM += -204586 * pow(e, 1) * cos(2 * d + -1 * m + 0 * mPrime + 0 * f);
    rM += -129620 * pow(e, 1) * cos(0 * d + 1 * m + -1 * mPrime + 0 * f);
    rM += 108743 * pow(e, 0) * cos(1 * d + 0 * m + 0 * mPrime + 0 * f);
    rM += 104755 * pow(e, 1) * cos(0 * d + 1 * m + 1 * mPrime + 0 * f);
    rM += 10321 * pow(e, 0) * cos(2 * d + 0 * m + 0 * mPrime + -2 * f);
    rM += 0 * cos(0 * d + 0 * m + 1 * mPrime + 2 * f);
    rM += 79661 * pow(e, 0) * cos(0 * d + 0 * m + 1 * mPrime + -2 * f);
    rM += -34782 * pow(e, 0) * cos(4 * d + 0 * m + -1 * mPrime + 0 * f);
    rM += -23210 * pow(e, 0) * cos(0 * d + 0 * m + 3 * mPrime + 0 * f);
    rM += -21636 * pow(e, 0) * cos(4 * d + 0 * m + -2 * mPrime + 0 * f);
    rM += 24208 * pow(e, 1) * cos(2 * d + 1 * m + -1 * mPrime + 0 * f);
    rM += 30824 * pow(e, 1) * cos(2 * d + 1 * m + 0 * mPrime + 0 * f);
    rM += -8379 * pow(e, 0) * cos(1 * d + 0 * m + -1 * mPrime + 0 * f);
    rM += -16675 * pow(e, 1) * cos(1 * d + 1 * m + 0 * mPrime + 0 * f);
    rM += -12831 * pow(e, 1) * cos(2 * d + -1 * m + 1 * mPrime + 0 * f);
    rM += -10445 * pow(e, 0) * cos(2 * d + 0 * m + 2 * mPrime + 0 * f);
    rM += -11650 * pow(e, 0) * cos(4 * d + 0 * m + 0 * mPrime + 0 * f);
    rM += 14403 * pow(e, 0) * cos(2 * d + 0 * m + -3 * mPrime + 0 * f);
    rM += -7003 * pow(e, 1) * cos(0 * d + 1 * m + -2 * mPrime + 0 * f);
    rM += 0 * cos(2 * d + 0 * m + -1 * mPrime + 2 * f);
    rM += 10056 * pow(e, 1) * cos(2 * d + -1 * m + -2 * mPrime + 0 * f);
    rM += 6322 * pow(e, 0) * cos(1 * d + 0 * m + 1 * mPrime + 0 * f);
    rM += -9884 * pow(e, 2) * cos(2 * d + -2 * m + 0 * mPrime + 0 * f);
    rM += 5751 * pow(e, 1) * cos(0 * d + 1 * m + 2 * mPrime + 0 * f);
    rM += 0 * cos(0 * d + 2 * m + 0 * mPrime + 0 * f);
    rM += -4950 * pow(e, 2) * cos(2 * d + -2 * m + -1 * mPrime + 0 * f);
    rM += 4130 * pow(e, 0) * cos(2 * d + 0 * m + 1 * mPrime + -2 * f);
    rM += 0 * cos(2 * d + 0 * m + 0 * mPrime + 2 * f);
    rM += -3958 * pow(e, 1) * cos(4 * d + -1 * m + -1 * mPrime + 0 * f);
    rM += 0 * cos(0 * d + 0 * m + 2 * mPrime + 2 * f);
    rM += 3258 * pow(e, 0) * cos(3 * d + 0 * m + -1 * mPrime + 0 * f);
    rM += 2616 * pow(e, 1) * cos(2 * d + 1 * m + 1 * mPrime + 0 * f);
    rM += -1897 * pow(e, 1) * cos(4 * d + -1 * m + -2 * mPrime + 0 * f);
    rM += -2117 * pow(e, 2) * cos(0 * d + 2 * m + -1 * mPrime + 0 * f);
    rM += 2354 * pow(e, 2) * cos(2 * d + 2 * m + -1 * mPrime + 0 * f);
    rM += 0 * cos(2 * d + 1 * m + -2 * mPrime + 0 * f);
    rM += 0 * cos(2 * d + -1 * m + 0 * mPrime + -2 * f);
    rM += -1423 * pow(e, 0) * cos(4 * d + 0 * m + 1 * mPrime + 0 * f);
    rM += -1117 * pow(e, 0) * cos(0 * d + 0 * m + 4 * mPrime + 0 * f);
    rM += -1571 * pow(e, 1) * cos(4 * d + -1 * m + 0 * mPrime + 0 * f);
    rM += -1739 * pow(e, 0) * cos(1 * d + 0 * m + -2 * mPrime + 0 * f);
    rM += 0 * cos(2 * d + 1 * m + 0 * mPrime + -2 * f);
    rM += -4421 * pow(e, 0) * cos(0 * d + 0 * m + 2 * mPrime + -2 * f);
    rM += 0 * cos(1 * d + 1 * m + 1 * mPrime + 0 * f);
    rM += 0 * cos(3 * d + 0 * m + -2 * mPrime + 0 * f);
    rM += 0 * cos(4 * d + 0 * m + -3 * mPrime + 0 * f);
    rM += 0 * cos(2 * d + -1 * m + 2 * mPrime + 0 * f);
    rM += 1165 * pow(e, 2) * cos(0 * d + 2 * m + 1 * mPrime + 0 * f);
    rM += 0 * cos(1 * d + 1 * m + -1 * mPrime + 0 * f);
    rM += 0 * cos(2 * d + 0 * m + 3 * mPrime + 0 * f);
    rM += 8752 * pow(e, 0) * cos(2 * d + 0 * m + -1 * mPrime + -2 * f);

    // Jarak dalam km
    rM = 385000.56 + rM / 1000.0;

    // Pemilihan hasil
    double result;
    switch (cleanOpt) {
      case "AU":
        result = rM / 149597870.7;
        break;
      case "KM":
        result = rM;
        break;
      case "ER":
        result = rM / 6371.0;
        break;
      default:
        result = rM;
    }

    // ✅ Simpan ke cache sebelum return
    _cacheJdDist = jd;
    _cacheOptDist = cleanOpt;
    _cacheDist = result;
    return result;
  }

  /// Moon Geocentric Right Ascension
  double moonGeocentricRightAscension(double jd, double deltaT) {
    final lmbd = moonGeocentricLongitude(jd, deltaT, "Appa");
    final beta = moonGeocentricLatitude(jd, deltaT, "Appa");
    final epsln = nt.obliquityOfEcliptic(jd);

    final alpha = mf.mod(
      mf.deg(
        atan2(
          sin(mf.rad(lmbd)) * cos(mf.rad(epsln)) -
              tan(mf.rad(beta)) * sin(mf.rad(epsln)),
          cos(mf.rad(lmbd)),
        ),
      ),
      360.0,
    );
    return alpha;
  }

  /// Moon Geocentric Declination
  double moonGeocentricDeclination(double jd, double deltaT) {
    final lmbd = moonGeocentricLongitude(jd, deltaT, "Appa");
    final beta = moonGeocentricLatitude(jd, deltaT, "Appa");
    final epsln = nt.obliquityOfEcliptic(jd);

    final delta = mf.deg(
      asin(
        sin(mf.rad(beta)) * cos(mf.rad(epsln)) +
            cos(mf.rad(beta)) * sin(mf.rad(epsln)) * sin(mf.rad(lmbd)),
      ),
    );
    return delta;
  }

  double moonGeocentricGreenwichHourAngle(double jd, double deltaT) {
    final gast = sn.greenwichApparentSiderialTime(jd, deltaT);
    final alpha = moonGeocentricRightAscension(jd, deltaT);
    final gha = mf.mod(gast - alpha, 360);
    return gha;
  }

  double moonGeocentricLocalHourAngel(double jd, double deltaT, double gLon) {
    final gast = sn.greenwichApparentSiderialTime(jd, deltaT);
    final alpha = moonGeocentricRightAscension(jd, deltaT);
    final lhaFK5 = mf.mod(gast + gLon - alpha, 360);
    return lhaFK5;
  }

  double moonGeocentricAzimuth(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
  ) {
    final lha = moonGeocentricLocalHourAngel(jd, deltaT, gLon);
    final dec = moonGeocentricDeclination(jd, deltaT);
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

  double moonGeocentricAltitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
  ) {
    final lha = moonGeocentricLocalHourAngel(jd, deltaT, gLon);
    final dec = moonGeocentricDeclination(jd, deltaT);
    final alt = mf.deg(
      asin(
        sin(mf.rad(gLat)) * sin(mf.rad(dec)) +
            cos(mf.rad(gLat)) * cos(mf.rad(dec)) * cos(mf.rad(lha)),
      ),
    );
    return alt;
  }

  /// Moon Equatorial Horizontal Parallax
  double moonEquatorialHorizontalParallax(double jd, double deltaT) {
    final distance = moonGeocentricDistance(jd, optResult: "KM");
    final pi = mf.deg(asin(6378.14 / distance));
    return pi;
  }

  double moonGeocentricSemidiameter(double jd, double deltaT) {
    const k = 0.272481;
    final pi = moonEquatorialHorizontalParallax(jd, deltaT);
    final s = mf.deg(asin(k * sin(mf.rad(pi))));
    return s;
  }

  double moonSunGeocentricElongation(double jd, double deltaT) {
    final deltaSun = sn.sunGeocentricDeclination(jd, deltaT);
    final alphaSun = sn.sunGeocentricRightAscension(jd, deltaT);
    final deltaMoon = moonGeocentricDeclination(jd, deltaT);
    final alphaMoon = moonGeocentricRightAscension(jd, deltaT);

    final d = mf.deg(
      acos(
        sin(mf.rad(deltaSun)) * sin(mf.rad(deltaMoon)) +
            cos(mf.rad(deltaSun)) *
                cos(mf.rad(deltaMoon)) *
                cos(mf.rad(alphaSun - alphaMoon)),
      ),
    );
    return d;
  }

  double moonGeocentricPhaseAngle(double jd, double deltaT) {
    final rSun = sn.sunGeocentricDistance(jd, optResult: "KM");
    final rMoon = moonGeocentricDistance(jd, optResult: "KM");
    final d = moonSunGeocentricElongation(jd, deltaT);
    final i = mf.deg(
      atan2(rSun * sin(mf.rad(d)), rMoon - rSun * cos(mf.rad(d))),
    );
    return i;
  }

  double moonGeocentricDiskIlluminatedFraction(double jd, double deltaT) {
    final rSun = sn.sunGeocentricDistance(jd, optResult: "KM");
    final rMoon = moonGeocentricDistance(jd, optResult: "KM");
    final d = moonSunGeocentricElongation(jd, deltaT);
    final i = mf.deg(
      atan2(rSun * sin(mf.rad(d)), rMoon - rSun * cos(mf.rad(d))),
    );
    double k = ((1 + cos(mf.rad(i))) / 2) * 100;
    return k;
  }

  double moonGeocentricBrightLimbAngle(double jd, double deltaT) {
    final deltaSun = sn.sunGeocentricDeclination(jd, deltaT);
    final alphaSun = sn.sunGeocentricRightAscension(jd, deltaT);
    final deltaMoon = moonGeocentricDeclination(jd, deltaT);
    final alphaMoon = moonGeocentricRightAscension(jd, deltaT);

    final x = mf.mod(
      mf.deg(
        atan2(
          cos(mf.rad(deltaSun)) * sin(mf.rad(alphaSun - alphaMoon)),
          sin(mf.rad(deltaSun)) * cos(mf.rad(deltaMoon)) -
              cos(mf.rad(deltaSun)) *
                  sin(mf.rad(deltaMoon)) *
                  cos(mf.rad(alphaSun - alphaMoon)),
        ),
      ),
      360,
    );
    return x;
  }

  double termN(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final lambda = moonGeocentricLongitude(jd, deltaT, "Appa");
    final beta = moonGeocentricLatitude(jd, deltaT, "Appa");
    final thta = sn.localApparentSiderialTime(jd, deltaT, gLon);
    final x = sn.termX(gLat, elev);
    final phi = moonEquatorialHorizontalParallax(jd, deltaT);

    final n =
        cos(mf.rad(lambda)) * cos(mf.rad(beta)) -
        x * sin(mf.rad(phi)) * cos(mf.rad(thta));
    return n;
  }

  double parallaxInTheMoonRightAscension(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final x = sn.termX(gLat, elev);
    final phi = moonEquatorialHorizontalParallax(jd, deltaT);
    final ha = moonGeocentricLocalHourAngel(jd, deltaT, gLon);
    final dec = moonGeocentricDeclination(jd, deltaT);

    final dAlpha = mf.deg(
      atan2(
        -x * sin(mf.rad(phi)) * sin(mf.rad(ha)),
        cos(mf.rad(dec)) - x * sin(mf.rad(phi)) * cos(mf.rad(ha)),
      ),
    );
    return dAlpha;
  }

  double atmosphericRefractionFromApparentAltitude(
    double apparentAltitude,
    double pres,
    double temp,
  ) {
    final h = apparentAltitude;
    final P = pres;
    final T = temp;

    return (1 / tan(mf.rad(h + 7.31 / (h + 4.4))) * P / 1010 * 283 / (273 + T) +
            0.0013515216737560731) /
        60;
  }

  double parallaxInTheMoonAltitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final h = moonGeocentricAltitude(jd, deltaT, gLon, gLat);
    final y = sn.termY(gLat, elev);
    final x = sn.termX(gLat, elev);
    final phi = moonEquatorialHorizontalParallax(jd, deltaT);

    final par = mf.deg(
      asin(sqrt(y * y + x * x) * sin(mf.rad(phi)) * cos(mf.rad(h))),
    );
    return par;
  }

  double moonTopocentricLongitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final lmbd = moonGeocentricLongitude(jd, deltaT, "Appa");
    final beta = moonGeocentricLatitude(jd, deltaT, "Appa");
    final phi = moonEquatorialHorizontalParallax(jd, deltaT);
    final thta = sn.localApparentSiderialTime(jd, deltaT, gLon);
    final eps = nt.obliquityOfEcliptic(jd);
    final x = sn.termX(gLat, elev);
    final y = sn.termY(gLat, elev);
    final n = termN(jd, deltaT, gLon, gLat, elev);

    final lmbdP = mf.mod(
      mf.deg(
        atan2(
          (sin(mf.rad(lmbd)) * cos(mf.rad(beta)) -
              sin(mf.rad(phi)) *
                  (y * sin(mf.rad(eps)) +
                      x * cos(mf.rad(eps)) * sin(mf.rad(thta)))),
          n,
        ),
      ),
      360,
    );

    return lmbdP;
  }

  double moonTopocentricLatitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final lmbdP = moonTopocentricLongitude(jd, deltaT, gLon, gLat, elev);
    final beta = moonGeocentricLatitude(jd, deltaT, "Appa");
    final phi = moonEquatorialHorizontalParallax(jd, deltaT);
    final thta = sn.localApparentSiderialTime(jd, deltaT, gLon);
    final eps = nt.obliquityOfEcliptic(jd);
    final x = sn.termX(gLat, elev);
    final y = sn.termY(gLat, elev);
    final n = termN(jd, deltaT, gLon, gLat, elev);

    final betaP = mf.deg(
      atan(
        cos(mf.rad(lmbdP)) *
            (sin(mf.rad(beta)) -
                sin(mf.rad(phi)) *
                    (y * cos(mf.rad(eps)) -
                        x * sin(mf.rad(eps)) * sin(mf.rad(thta)))) /
            n,
      ),
    );

    return betaP;
  }

  double moonTopocentricRightAscension(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final alpha = moonGeocentricRightAscension(jd, deltaT);
    final dAlph = parallaxInTheMoonRightAscension(jd, deltaT, gLon, gLat, elev);
    final alphP = alpha + dAlph;
    return alphP;
  }

  double moonTopocentricDeclination(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final dec = moonGeocentricDeclination(jd, deltaT);
    final y = sn.termY(gLat, elev);
    final x = sn.termX(gLat, elev);
    final phi = moonEquatorialHorizontalParallax(jd, deltaT);
    final dAlph = parallaxInTheMoonRightAscension(jd, deltaT, gLon, gLat, elev);
    final ha = moonGeocentricLocalHourAngel(jd, deltaT, gLon);

    final dltaP = mf.deg(
      atan2(
        (sin(mf.rad(dec)) - y * sin(mf.rad(phi))) * cos(mf.rad(dAlph)),
        cos(mf.rad(dec)) - x * sin(mf.rad(phi)) * cos(mf.rad(ha)),
      ),
    );
    return dltaP;
  }

  double moonTopocentricGreenwichHourAngle(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final gast = sn.greenwichApparentSiderialTime(jd, deltaT);
    final alph = moonTopocentricRightAscension(jd, deltaT, gLon, gLat, elev);
    final gha = mf.mod(gast - alph, 360.0);
    return gha;
  }

  double moonTopocentricLocalHourAngel(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final lha = moonGeocentricLocalHourAngel(jd, deltaT, gLon);
    final dAlph = parallaxInTheMoonRightAscension(jd, deltaT, gLon, gLat, elev);
    final lhaP = lha - dAlph;
    return lhaP;
  }

  double moonTopocentricSemidiameter(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double lmbdP = moonTopocentricLongitude(jd, deltaT, gLon, gLat, elev);
    double betaP = moonTopocentricLatitude(jd, deltaT, gLon, gLat, elev);
    double s = moonGeocentricSemidiameter(jd, deltaT);
    double n = termN(jd, deltaT, gLon, gLat, elev);

    double sP = mf.deg(
      sin(cos(mf.rad(lmbdP)) * cos(mf.rad(betaP)) * sin(mf.rad(s)) / n),
    );
    return sP;
  }

  double moonTopocentricAzimuth(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final lhaP = moonTopocentricLocalHourAngel(jd, deltaT, gLon, gLat, elev);
    final dltP = moonTopocentricDeclination(jd, deltaT, gLon, gLat, elev);

    final azmP = mf.mod(
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

  double moonTopocentricAltitude(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
    double pres,
    double temp,
    String opt,
  ) {
    final dec = moonTopocentricDeclination(jd, deltaT, gLon, gLat, elev);
    final lHA = moonTopocentricLocalHourAngel(jd, deltaT, gLon, gLat, elev);

    final htc = mf.deg(
      asin(
        sin(mf.rad(gLat)) * sin(mf.rad(dec)) +
            cos(mf.rad(gLat)) * cos(mf.rad(dec)) * cos(mf.rad(lHA)),
      ),
    );

    final dip = 1.75 / 60 * sqrt(elev);
    final sdc = moonTopocentricSemidiameter(jd, deltaT, gLon, gLat, elev);

    final htu = htc + sdc;
    final htl = htc - sdc;

    final rhtu = sn.atmosphericRefractionFromAirlessAltitude(htu, pres, temp);
    final rhtc = sn.atmosphericRefractionFromAirlessAltitude(htc, pres, temp);
    final rhtl = sn.atmosphericRefractionFromAirlessAltitude(htl, pres, temp);

    final htau = htu + rhtu;
    final htac = htc + rhtc;
    final htal = htl + rhtl;

    final htoc = htac + dip;
    final htou = htau + dip;
    final htol = htal + dip;

    double ht;
    switch (opt) {
      //Airless Altitude
      case "htu":
        ht = htu;
        break;
      case "htc":
        ht = htc;
        break;
      case "htl":
        ht = htl;
        break;
      //Apparent Altitude
      case "htau":
        ht = htau;
        break;
      case "htac":
        ht = htac;
        break;
      case "htal":
        ht = htal;
        break;
      //Observered Altitude
      case "htou":
        ht = htou;
        break;
      case "htoc":
        ht = htoc;
        break;
      case "htol":
        ht = htol;
        break;
      //Refraksi
      case "Rhtc":
        ht = rhtc;
        break;
      case "Rhtu":
        ht = rhtu;
        break;
      case "Rhtl":
        ht = rhtl;
        break;
      //Dip
      case "Dip":
        ht = dip;
        break;
      default:
        ht = htc;
    }

    return ht;
  }

  //Keterangan:

  //htu  = Airles topocentric altitude of The Moon's Upper Limb
  //htc  = Airless topocentric altitude of The Moon's Center Limb
  //htl  = Airles topocentric altitude of The Moon's Lower Limb

  //htal = Apparent topocentric altitude of The Moon's Lower Limb
  //htac = Apparent topocentric altitude of The Moon's Center Limb
  //htau = Apparent topocentric altitude of The Moon's Upper Limb

  //htou = Observed altitude of The Moon's Upper Limb
  //htoc = Observed altitude of The Moon's Center Limb
  //htol = Observed altitude of The Moon's Lower Limb

  double moonSunTopocentricElongation(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    final double dltaS = sn.sunTopocentricDeclination(
      jd,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    final double alphS = sn.sunTopocentricRightAscension(
      jd,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    final double dltaM = moonTopocentricDeclination(
      jd,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    final double alphM = moonTopocentricRightAscension(
      jd,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    final double d = mf.deg(
      acos(
        sin(mf.rad(dltaS)) * sin(mf.rad(dltaM)) +
            cos(mf.rad(dltaS)) *
                cos(mf.rad(dltaM)) *
                cos(mf.rad(alphS - alphM)),
      ),
    );

    return d;
  }

  double moonTopocentricPhaseAngle(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double rSn = sn.sunGeocentricDistance(jd, optResult: "KM");
    double rMn = moonGeocentricDistance(jd, optResult: "KM");
    double d = moonSunTopocentricElongation(jd, deltaT, gLon, gLat, elev);

    double i = mf.deg(atan2(rSn * sin(mf.rad(d)), rMn - rSn * cos(mf.rad(d))));
    return i;
  }

  double moonTopocentricDiskIlluminatedFraction(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double rSn = sn.sunGeocentricDistance(jd, optResult: "KM");
    double rMn = moonGeocentricDistance(jd, optResult: "KM");
    double d = moonSunTopocentricElongation(jd, deltaT, gLon, gLat, elev);

    double i = mf.deg(atan2(rSn * sin(mf.rad(d)), rMn - rSn * cos(mf.rad(d))));
    double k = ((1 + cos(mf.rad(i))) / 2) * 100;
    return k;
  }

  double moonTopocentricBrightLimbAngle(
    double jd,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
  ) {
    double dltaSn = sn.sunTopocentricDeclination(jd, deltaT, gLon, gLat, elev);
    double alphSn = sn.sunTopocentricRightAscension(
      jd,
      deltaT,
      gLon,
      gLat,
      elev,
    );
    double dltaMn = moonTopocentricDeclination(jd, deltaT, gLon, gLat, elev);
    double alphMn = moonTopocentricRightAscension(jd, deltaT, gLon, gLat, elev);

    double x = mf.mod(
      mf.deg(
        atan2(
          cos(mf.rad(dltaSn)) * sin(mf.rad(alphSn - alphMn)),
          sin(mf.rad(dltaSn)) * cos(mf.rad(dltaMn)) -
              cos(mf.rad(dltaSn)) *
                  sin(mf.rad(dltaMn)) *
                  cos(mf.rad(alphSn - alphMn)),
        ),
      ),
      360,
    );
    return x;
  }

  double moonPhasesModified(int hijriMonth, int hijriYear, int moonPhaseKind) {
    double k = hijriMonth.toDouble() + 12 * hijriYear.toDouble() - 17050;

    double kII;
    switch (moonPhaseKind) {
      case 1:
        kII = 0.0;
        break;
      case 2:
        kII = 0.25;
        break;
      case 3:
        kII = 0.5;
        break;
      case 4:
        kII = 0.75;
        break;
      default:
        kII = 0.0;
    }

    k = mf.floor(k) + kII;

    final t = k / 1236.85;
    final t2 = t * t;
    final t3 = t2 * t;
    final t4 = t3 * t;

    final jdeMMP =
        2451550.09766 +
        29.530588861 * k +
        0.00015437 * t2 -
        0.00000015 * t3 +
        0.00000000073 * t4;

    final e = 1 - 0.002516 * t - 0.0000074 * t2;

    var m = 2.5534 + 29.1053567 * k - 0.0000014 * t2 - 0.00000011 * t3;
    m = mf.rad(mf.mod(m, 360));

    var mp =
        201.5643 +
        385.81693528 * k +
        0.0107582 * t2 +
        0.00001238 * t3 -
        0.000000058 * t4;
    mp = mf.rad(mf.mod(mp, 360));

    var f =
        160.7108 +
        390.67050284 * k -
        0.0016118 * t2 -
        0.00000227 * t3 +
        0.000000011 * t4;
    f = mf.rad(mf.mod(f, 360));

    var om = 124.7746 - 1.56375588 * k + 0.0020672 * t2 + 0.00000215 * t3;
    om = mf.rad(mf.mod(om, 360));

    final a1 = mf.rad(mf.mod(299.77 + 0.107408 * k - 0.009173 * t * t, 360));
    final a2 = mf.rad(mf.mod(251.88 + 0.016321 * k, 360));
    final a3 = mf.rad(mf.mod(251.83 + 26.651886 * k, 360));
    final a4 = mf.rad(mf.mod(349.42 + 36.412478 * k, 360));
    final a5 = mf.rad(mf.mod(84.66 + 18.206239 * k, 360));
    final a6 = mf.rad(mf.mod(141.74 + 53.303771 * k, 360));
    final a7 = mf.rad(mf.mod(207.14 + 2.453732 * k, 360));
    final a8 = mf.rad(mf.mod(154.84 + 7.30686 * k, 360));
    final a9 = mf.rad(mf.mod(34.52 + 27.261239 * k, 360));
    final a10 = mf.rad(mf.mod(207.19 + 0.121824 * k, 360));
    final a11 = mf.rad(mf.mod(291.34 + 1.844379 * k, 360));
    final a12 = mf.rad(mf.mod(161.72 + 24.198154 * k, 360));
    final a13 = mf.rad(mf.mod(239.56 + 25.513099 * k, 360));
    final a14 = mf.rad(mf.mod(331.55 + 3.592518 * k, 360));

    double jdeCorr1;
    switch (moonPhaseKind) {
      case 1:
        jdeCorr1 =
            -0.4072 * sin(mp) +
            0.17241 * e * sin(m) +
            0.01608 * sin(2 * mp) +
            0.01039 * sin(2 * f) +
            0.00739 * e * sin(mp - m) -
            0.00514 * e * sin(mp + m) +
            0.00208 * e * e * sin(2 * m) -
            0.00111 * sin(mp - 2 * f) -
            0.00057 * sin(mp + 2 * f) +
            0.00056 * e * sin(2 * mp + m) -
            0.00042 * sin(3 * mp) +
            0.00042 * e * sin(m + 2 * f) +
            0.00038 * e * sin(m - 2 * f) -
            0.00024 * e * sin(2 * mp - m) -
            0.00017 * sin(om) -
            0.00007 * sin(mp + 2 * m) +
            0.00004 * sin(2 * mp - 2 * f) +
            0.00004 * sin(3 * m) +
            0.00003 * sin(mp + m - 2 * f) +
            0.00003 * sin(2 * mp + 2 * f) -
            0.00003 * sin(mp + m + 2 * f) +
            0.00003 * sin(mp - m + 2 * f) -
            0.00002 * sin(mp - m - 2 * f) -
            0.00002 * sin(3 * mp + m) +
            0.00002 * sin(4 * mp);
        break;

      case 3:
        jdeCorr1 =
            -0.40614 * sin(mp) +
            0.17302 * e * sin(m) +
            0.01614 * sin(2 * mp) +
            0.01043 * sin(2 * f) +
            0.00734 * e * sin(mp - m) -
            0.00514 * e * sin(mp + m) +
            0.00209 * e * e * sin(2 * m) -
            0.00111 * sin(mp - 2 * f) -
            0.00057 * sin(mp + 2 * f) +
            0.00056 * e * sin(2 * mp + m) -
            0.00042 * sin(3 * mp) +
            0.00042 * e * sin(m + 2 * f) +
            0.00038 * e * sin(m - 2 * f) -
            0.00024 * e * sin(2 * mp - m) -
            0.00017 * sin(om) -
            0.00007 * sin(mp + 2 * m) +
            0.00004 * sin(2 * mp - 2 * f) +
            0.00004 * sin(3 * m) +
            0.00003 * sin(mp + m - 2 * f) +
            0.00003 * sin(2 * mp + 2 * f) -
            0.00003 * sin(mp + m + 2 * f) +
            0.00003 * sin(mp - m + 2 * f) -
            0.00002 * sin(mp - m - 2 * f) -
            0.00002 * sin(3 * mp + m) +
            0.00002 * sin(4 * mp);
        break;

      case 2:
      case 4:
        jdeCorr1 =
            -0.62801 * sin(mp) +
            0.17172 * e * sin(m) -
            0.01183 * e * sin(mp + m) +
            0.00862 * sin(2 * mp) +
            0.00804 * sin(2 * f) +
            0.00454 * e * sin(mp - m) +
            0.00204 * e * e * sin(2 * m) -
            0.0018 * sin(mp - 2 * f) -
            0.0007 * sin(mp + 2 * f) -
            0.0004 * sin(3 * mp) -
            0.00034 * e * sin(2 * mp - m) +
            0.00032 * e * sin(m + 2 * f) +
            0.00032 * e * sin(m - 2 * f) -
            0.00028 * e * e * sin(mp + 2 * m) +
            0.00027 * e * sin(2 * mp + m) -
            0.00017 * sin(om) -
            0.00005 * sin(mp - m - 2 * f) +
            0.00004 * sin(2.0 * mp + 2 * f) -
            0.00004 * sin(mp + m + 2 * f) +
            0.00004 * sin(mp - 2 * m) +
            0.00003 * sin(mp + m - 2 * f) +
            0.00003 * sin(3 * m) +
            0.00002 * sin(2 * mp - 2 * f) +
            0.00002 * sin(mp - m + 2 * f) -
            0.00002 * sin(3 * mp + m);
        break;

      default:
        jdeCorr1 = 0.0;
    }

    // Extra correction for Quarter phases
    if (moonPhaseKind == 2 || moonPhaseKind == 4) {
      final w =
          0.00306 -
          0.00038 * e * cos(m) +
          0.00026 * cos(mp) -
          0.00002 * cos(mp - m) +
          0.00002 * cos(mp + m) +
          0.00002 * cos(2 * f);
      if (moonPhaseKind == 2) {
        jdeCorr1 += w;
      } else if (moonPhaseKind == 4) {
        jdeCorr1 -= w;
      }
    }

    final jdeCorr2 =
        0.000325 * sin(a1) +
        0.000165 * sin(a2) +
        0.000164 * sin(a3) +
        0.000126 * sin(a4) +
        0.00011 * sin(a5) +
        0.000062 * sin(a6) +
        0.00006 * sin(a7) +
        0.000056 * sin(a8) +
        0.000047 * sin(a9) +
        0.000042 * sin(a10) +
        0.00004 * sin(a11) +
        0.000037 * sin(a12) +
        0.000035 * sin(a13) +
        0.000023 * sin(a14);

    final result = jdeMMP + jdeCorr1 + jdeCorr2;
    return result;
  }

  double jdeEclipseModified(int hijriMonth, int hijriYear, int eclipseKind) {
    double k;

    switch (eclipseKind) {
      case 1:
        k =
            mf.floor(
              hijriMonth.toDouble() + 12 * hijriYear.toDouble() - 17048.5,
            ) +
            0.0;
        break;
      case 2:
        k =
            (hijriMonth.toDouble() + 12 * hijriYear.toDouble() - 17049.5)
                .floorToDouble() +
            0.5;
        break;
      default:
        k =
            (hijriMonth.toDouble() + 12 * hijriYear.toDouble() - 17048.5)
                .floorToDouble() +
            0.0;
        break;
    }

    double t = k / 1236.85;
    double t2 = t * t;
    double t3 = t2 * t;
    double t4 = t3 * t;

    double jdeMMP =
        2451550.09766 +
        29.530588861 * k +
        0.00015437 * t2 -
        0.000000150 * t3 +
        0.00000000073 * t4;

    double e = 1 - 0.002516 * t - 0.0000074 * t2;

    double m = 2.5534 + 29.1053567 * k - 0.0000014 * t2 - 0.00000011 * t3;
    m = mf.rad(mf.mod(m, 360));

    double mp =
        201.5643 +
        385.81693528 * k +
        0.0107582 * t2 +
        0.00001238 * t3 -
        0.000000058 * t4;
    mp = mf.rad(mf.mod(mp, 360));

    double f =
        160.7108 +
        390.67050284 * k -
        0.0016118 * t2 -
        0.00000227 * t3 +
        0.000000011 * t4;
    f = mf.rad(mf.mod(f, 360));

    double omg = 124.7746 - 1.56375588 * k + 0.0020672 * t2 + 0.00000215 * t3;
    omg = mf.rad(mf.mod(omg, 360));

    if (mf.abs(sin(f)) > 0.36) {
      return 0.0;
    } else {
      double f1 = mf.deg(f) - 0.02665 * sin(omg);
      f1 = mf.rad(mf.mod(f1, 360));

      double a1 = 299.77 + 0.107408 * k - 0.009173 * t2;
      a1 = mf.rad(mf.mod(a1, 360));

      double jdeCorr;
      switch (eclipseKind) {
        case 1:
          jdeCorr = -0.4075 * sin(mp) + 0.1721 * e * sin(m);
          break;
        case 2:
          jdeCorr = -0.4065 * sin(mp) + 0.1727 * e * sin(m);
          break;
        default:
          jdeCorr = -0.4075 * sin(mp) + 0.1721 * e * sin(m);
          break;
      }

      jdeCorr =
          jdeCorr +
          0.0161 * sin(2 * mp) -
          0.0097 * sin(2 * f1) +
          0.0073 * e * sin(mp - m) -
          0.0050 * e * sin(mp + m) -
          0.0023 * sin(mp - 2 * f1) +
          0.0021 * e * sin(2 * m) +
          0.0012 * sin(mp + 2 * f1) +
          0.0006 * e * sin(2 * mp + m) -
          0.0004 * sin(3 * mp) -
          0.0003 * e * sin(m + 2 * f1) +
          0.0003 * sin(a1) -
          0.0002 * e * sin(m - 2 * f1) -
          0.0002 * e * sin(2 * mp - m) -
          0.0002 * sin(omg);

      return jdeMMP + jdeCorr;
    }
  }

  double geocentricConjunction(
    int hijriMonth,
    int hijriYear,
    double deltaT,
    String optR,
  ) {
    double jdNMGeo = 0.0;
    double jdNM = moonPhasesModified(hijriMonth, hijriYear, 1);

    double x1 = jdNM - 1 / 24;
    double x2 = jdNM;
    double x3 = jdNM + 1 / 24;

    double y1 =
        sn.sunGeocentricLongitude(x1, deltaT, "Appa") -
        moonGeocentricLongitude(x1, deltaT, "Appa");
    double y2 =
        sn.sunGeocentricLongitude(x2, deltaT, "Appa") -
        moonGeocentricLongitude(x2, deltaT, "Appa");
    double y3 =
        sn.sunGeocentricLongitude(x3, deltaT, "Appa") -
        moonGeocentricLongitude(x3, deltaT, "Appa");

    double a = y2 - y1;
    double b = y3 - y2;
    double c = b - a;

    double n0 = 0.0;

    for (int i = 1; i <= 2; i++) {
      n0 = -2 * y2 / (a + b + c * n0);
      jdNMGeo = jdNM + n0 / 24;
    }

    double lonG = sn.sunGeocentricLongitude(jdNMGeo, deltaT, "Appa");

    switch (optR) {
      case "Ijtima":
        return jdNMGeo;
      case "Bujur":
        return lonG;
      default:
        return jdNMGeo;
    }
  }

  double topocentricConjunction(
    int hijriMonth,
    int hijriYear,
    double deltaT,
    double gLon,
    double gLat,
    double elev,
    String optR,
  ) {
    var jdNMTopo = 0.0;
    double jdNM = moonPhasesModified(hijriMonth, hijriYear, 1);

    double x1 = jdNM - 1 / 24;
    double x2 = jdNM;
    double x3 = jdNM + 1 / 24;

    double y1 =
        sn.sunTopocentricLongitude(x1, deltaT, gLon, gLat, elev) -
        moonTopocentricLongitude(x1, deltaT, gLon, gLat, elev);
    double y2 =
        sn.sunTopocentricLongitude(x2, deltaT, gLon, gLat, elev) -
        moonTopocentricLongitude(x2, deltaT, gLon, gLat, elev);
    double y3 =
        sn.sunTopocentricLongitude(x3, deltaT, gLon, gLat, elev) -
        moonTopocentricLongitude(x3, deltaT, gLon, gLat, elev);

    double a = y2 - y1;
    double b = y3 - y2;
    double c = b - a;

    var n0 = 0.0;
    n0 = -2 * y2 / (a + b + c * n0);

    for (int i = 1; i <= 3; i++) {
      n0 = -2 * y2 / (a + b + c * n0);
      jdNMTopo = jdNM + n0 / 24;
    }

    double lonT = sn.sunTopocentricLongitude(
      jdNMTopo,
      deltaT,
      gLon,
      gLat,
      elev,
    );

    switch (optR) {
      case "Ijtima":
        return jdNMTopo;
      case "Bujur":
        return lonT;
      default:
        return jdNMTopo;
    }
  }

  double moonTransitRiseSet(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double elev,
    double tmZn,
    String trsType,
    int maxItr,
  ) {
    double jd00LT;
    double jd00UT;
    double jde00UT;
    double alphaMm1d = 0.0;
    double alphaM00d = 0.0;
    double alphaMp1d = 0.0;
    double deltaMm1d = 0.0;
    double deltaM00d = 0.0;
    double deltaMp1d = 0.0;
    double pi;
    double h0 = 0.0;
    double cosHA0;
    double ha0;
    double t;
    double theta0 = 0.0;
    double m = 0.0;
    double sTheta0 = 0.0;
    double nT = 0.0;
    double alphaM = 0.0;
    double deltaM = 0.0;
    double ha = 0.0;
    double h = 0.0;
    double dltm = 0.0;
    double jdTRS;
    double ttrs = 0.0;

    jd00UT = jd.kmjd(tglM, blnM, thnM, tmZn, tmZn) + -1;

    for (int dItr = 1; dItr <= 3; dItr++) {
      jde00UT = jd00UT + dt.deltaT(jd00UT) / 86400.0;
      alphaMm1d = moonGeocentricRightAscension(jde00UT - 1, 0);
      alphaM00d = moonGeocentricRightAscension(jde00UT - 0, 0);
      alphaMp1d = moonGeocentricRightAscension(jde00UT + 1, 0);

      if (trsType == "TRANSIT") {
        deltaM00d = 0;
        deltaMm1d = 0;
        deltaMp1d = 0;
      } else {
        deltaMm1d = moonGeocentricDeclination(jde00UT - 1, 0);
        deltaM00d = moonGeocentricDeclination(jde00UT - 0, 0);
        deltaMp1d = moonGeocentricDeclination(jde00UT + 1, 0);
      }

      pi = moonEquatorialHorizontalParallax(jde00UT, 0);

      h0 = -(34 / 60) + 0.7275 * pi; //- 0.0353 * sqrt(elev);
      cosHA0 =
          (sin(mf.rad(h0)) - sin(mf.rad(gLat)) * sin(mf.rad(deltaM00d))) /
          (cos(mf.rad(gLat)) * cos(mf.rad(deltaM00d)));

      if ((cosHA0).abs() <= 1) {
        ha0 = mf.deg(acos(cosHA0));
      } else {
        ha0 = 0;
      }

      t = (jde00UT - 2451545) / 36525;

      theta0 =
          (100.46061837) +
          (36000.770053608 * t) +
          (0.000387933 * t * t) -
          (pow(t, 3.0) / 38710000) +
          (nt.nutationInLongitude(jde00UT) *
              cos(mf.rad(nt.obliquityOfEcliptic(jde00UT))));

      theta0 = mf.mod(theta0, 360);

      m = (alphaM00d - gLon - theta0) / 360;

      switch (trsType) {
        case "TRANSIT":
          m = m;
          break;
        case "RISE":
          m = m - ha0 / 360;
          break;
        case "SET":
          m = m + ha0 / 360;
          break;
      }

      m = mf.mod(m, 1);

      for (int itr = 1; itr <= maxItr; itr++) {
        sTheta0 = theta0 + 360.985647 * m;
        sTheta0 = mf.mod(sTheta0, 360);
        nT = m;
        alphaM = mf.mod(
          alphaM00d +
              nT /
                  2.0 *
                  (mf.mod((alphaM00d - alphaMm1d), 360) +
                      mf.mod((alphaMp1d - alphaM00d), 360) +
                      nT *
                          (mf.mod((alphaMp1d - alphaM00d), 360) -
                              mf.mod((alphaM00d - alphaMm1d), 360))),
          360,
        );

        if (trsType == "TRANSIT") {
          deltaM = 0;
        } else {
          deltaM =
              deltaM00d +
              nT /
                  2.0 *
                  ((deltaM00d - deltaMm1d) +
                      (deltaMp1d - deltaM00d) +
                      nT * ((deltaMp1d - deltaM00d) - (deltaM00d - deltaMm1d)));
        }

        ha = sTheta0 + gLon - alphaM;

        if (mf.mod(ha, 360) > 180) {
          ha = mf.mod(ha, 360) - 360;
        } else {
          ha = mf.mod(ha, 360);
        }

        h = mf.deg(
          asin(
            sin(mf.rad(gLat)) * sin(mf.rad(deltaM)) +
                cos(mf.rad(gLat)) * cos(mf.rad(deltaM)) * cos(mf.rad(ha)),
          ),
        );

        switch (trsType) {
          case "TRANSIT":
            dltm = -ha / 360;
            break;
          case "RISE":
          case "SET":
            dltm =
                (h - h0) /
                (360 *
                    cos(mf.rad(deltaM)) *
                    cos(mf.rad(gLat)) *
                    sin(mf.rad(ha)));
            break;
        }

        m = mf.mod(m + dltm, 1);
      }

      jdTRS = jd00UT + m;
      jd00LT = jd.kmjd(tglM, blnM, thnM, 0, tmZn);
      ttrs = double.parse(jd.jdkm(jdTRS, tmZn, "JAMDES"));

      if ((jdTRS >= (jd00LT + 0)) && (jdTRS <= (jd00LT + 1))) {
        ttrs = double.parse(jd.jdkm(jdTRS, tmZn, "JAMDES"));
      } else {
        jd00UT = jd00UT + 1;
        ttrs = 0;
      }
    }
    return ttrs;
  }
}
