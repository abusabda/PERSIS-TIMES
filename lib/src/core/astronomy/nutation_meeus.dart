import 'dart:math';
import '../math/math_utils.dart';

class NutationCalculator {
  final mf = MathFunction();

  // ==========================================================================
  // NutationInLongitude (Δψ)
  // ==========================================================================
  double nutationInLongitude(double jd) {
    double t = (jd - 2451545.0) / 36525.0;

    // Fundamental arguments (dalam derajat)
    double d =
        297.85036 +
        445267.11148 * t -
        0.0019142 * pow(t, 2) +
        pow(t, 3) / 189474;
    double m =
        357.52772 +
        35999.05034 * t -
        0.0001603 * pow(t, 2) -
        pow(t, 3) / 300000;
    double mPrime =
        134.96298 + 477198.867398 * t + 0.0086972 * pow(t, 2) + t * 3 / 56250;
    double f =
        93.27191 +
        483202.017538 * t -
        0.0036825 * pow(t, 2) +
        pow(t, 3) / 327270;
    double omg =
        125.04452 -
        1934.136261 * t +
        0.0020708 * pow(t, 2) +
        pow(t, 3) / 450000;

    // Konversi ke radian setelah di-mod 360
    d = mf.rad(mf.mod(d, 360.0));
    m = mf.rad(mf.mod(m, 360.0));
    mPrime = mf.rad(mf.mod(mPrime, 360.0));
    f = mf.rad(mf.mod(f, 360.0));
    omg = mf.rad(mf.mod(omg, 360.0));

    // Perhitungan Delta Psi (dalam satuan 0.0001 arcsecond)
    double dltPsi = 0.0;
    dltPsi +=
        (-171996 + -174.2 * t) *
        sin(0 * d + 0 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltPsi +=
        (-13187 + -1.6 * t) *
        sin(-2 * d + 0 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (-2274 + -0.2 * t) * sin(0 * d + 0 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (2062 + 0.2 * t) * sin(0 * d + 0 * m + 0 * mPrime + 0 * f + 2 * omg);
    dltPsi +=
        (1426 + -3.4 * t) * sin(0 * d + 1 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltPsi +=
        (712 + 0.1 * t) * sin(0 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi +=
        (-517 + 1.2 * t) * sin(-2 * d + 1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (-386 + -0.4 * t) * sin(0 * d + 0 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltPsi +=
        (-301 + 0 * t) * sin(0 * d + 0 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (217 + -0.5 * t) * sin(-2 * d + -1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (-158 + 0 * t) * sin(-2 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi +=
        (129 + 0.1 * t) * sin(-2 * d + 0 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltPsi +=
        (123 + 0 * t) * sin(0 * d + 0 * m + -1 * mPrime + 2 * f + 2 * omg);
    dltPsi += (63 + 0 * t) * sin(2 * d + 0 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltPsi +=
        (63 + 0.1 * t) * sin(0 * d + 0 * m + 1 * mPrime + 0 * f + 1 * omg);
    dltPsi +=
        (-59 + 0 * t) * sin(2 * d + 0 * m + -1 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (-58 + -0.1 * t) * sin(0 * d + 0 * m + -1 * mPrime + 0 * f + 1 * omg);
    dltPsi += (-51 + 0 * t) * sin(0 * d + 0 * m + 1 * mPrime + 2 * f + 1 * omg);
    dltPsi += (48 + 0 * t) * sin(-2 * d + 0 * m + 2 * mPrime + 0 * f + 0 * omg);
    dltPsi += (46 + 0 * t) * sin(0 * d + 0 * m + -2 * mPrime + 2 * f + 1 * omg);
    dltPsi += (-38 + 0 * t) * sin(2 * d + 0 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi += (-31 + 0 * t) * sin(0 * d + 0 * m + 2 * mPrime + 2 * f + 2 * omg);
    dltPsi += (29 + 0 * t) * sin(0 * d + 0 * m + 2 * mPrime + 0 * f + 0 * omg);
    dltPsi += (29 + 0 * t) * sin(-2 * d + 0 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltPsi += (26 + 0 * t) * sin(0 * d + 0 * m + 0 * mPrime + 2 * f + 0 * omg);
    dltPsi +=
        (-22 + 0 * t) * sin(-2 * d + 0 * m + 0 * mPrime + 2 * f + 0 * omg);
    dltPsi += (21 + 0 * t) * sin(0 * d + 0 * m + -1 * mPrime + 2 * f + 1 * omg);
    dltPsi +=
        (17 + -0.1 * t) * sin(0 * d + 2 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltPsi += (16 + 0 * t) * sin(2 * d + 0 * m + -1 * mPrime + 0 * f + 1 * omg);
    dltPsi +=
        (-16 + 0.1 * t) * sin(-2 * d + 2 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi += (-15 + 0 * t) * sin(0 * d + 1 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltPsi +=
        (-13 + 0 * t) * sin(-2 * d + 0 * m + 1 * mPrime + 0 * f + 1 * omg);
    dltPsi +=
        (-12 + 0 * t) * sin(0 * d + -1 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltPsi += (11 + 0 * t) * sin(0 * d + 0 * m + 2 * mPrime + -2 * f + 0 * omg);
    dltPsi +=
        (-10 + 0 * t) * sin(2 * d + 0 * m + -1 * mPrime + 2 * f + 1 * omg);
    dltPsi += (-8 + 0 * t) * sin(2 * d + 0 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltPsi += (7 + 0 * t) * sin(0 * d + 1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi += (-7 + 0 * t) * sin(-2 * d + 1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi += (-7 + 0 * t) * sin(0 * d + -1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltPsi += (-7 + 0 * t) * sin(2 * d + 0 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltPsi += (6 + 0 * t) * sin(2 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi += (6 + 0 * t) * sin(-2 * d + 0 * m + 2 * mPrime + 2 * f + 2 * omg);
    dltPsi += (6 + 0 * t) * sin(-2 * d + 0 * m + 1 * mPrime + 2 * f + 1 * omg);
    dltPsi += (-6 + 0 * t) * sin(2 * d + 0 * m + -2 * mPrime + 0 * f + 1 * omg);
    dltPsi += (-6 + 0 * t) * sin(2 * d + 0 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltPsi += (5 + 0 * t) * sin(0 * d + -1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi +=
        (-5 + 0 * t) * sin(-2 * d + -1 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltPsi += (-5 + 0 * t) * sin(-2 * d + 0 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltPsi += (-5 + 0 * t) * sin(0 * d + 0 * m + 2 * mPrime + 2 * f + 1 * omg);
    dltPsi += (4 + 0 * t) * sin(-2 * d + 0 * m + 2 * mPrime + 0 * f + 1 * omg);
    dltPsi += (4 + 0 * t) * sin(-2 * d + 1 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltPsi += (4 + 0 * t) * sin(0 * d + 0 * m + 1 * mPrime + -2 * f + 0 * omg);
    dltPsi += (-4 + 0 * t) * sin(-1 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi += (-4 + 0 * t) * sin(-2 * d + 1 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltPsi += (-4 + 0 * t) * sin(1 * d + 0 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltPsi += (3 + 0 * t) * sin(0 * d + 0 * m + 1 * mPrime + 2 * f + 0 * omg);
    dltPsi += (-3 + 0 * t) * sin(0 * d + 0 * m + -2 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (-3 + 0 * t) * sin(-1 * d + -1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi += (-3 + 0 * t) * sin(0 * d + 1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltPsi += (-3 + 0 * t) * sin(0 * d + -1 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltPsi +=
        (-3 + 0 * t) * sin(2 * d + -1 * m + -1 * mPrime + 2 * f + 2 * omg);
    dltPsi += (-3 + 0 * t) * sin(0 * d + 0 * m + 3 * mPrime + 2 * f + 2 * omg);
    dltPsi += (-3 + 0 * t) * sin(2 * d + -1 * m + 0 * mPrime + 2 * f + 2 * omg);

    // Konversi dari 0.0001 arcsecond ke derajat
    dltPsi = dltPsi / 36000000.0;

    return dltPsi;
  }

  // ==========================================================================
  // NutationInObliquity (Δε)
  // ==========================================================================
  double nutationInObliquity(double jd) {
    double t = (jd - 2451545.0) / 36525.0;

    // Fundamental arguments (dalam derajat)
    double d =
        297.85036 +
        445267.11148 * t -
        0.0019142 * pow(t, 2) +
        pow(t, 3) / 189474;
    double m =
        357.52772 +
        35999.05034 * t -
        0.0001603 * pow(t, 2) -
        pow(t, 3) / 300000;
    double mPrime =
        134.96298 + 477198.867398 * t + 0.0086972 * pow(t, 2) + t * 3 / 56250;
    double f =
        93.27191 +
        483202.017538 * t -
        0.0036825 * pow(t, 2) +
        pow(t, 3) / 327270;
    double omg =
        125.04452 -
        1934.136261 * t +
        0.0020708 * pow(t, 2) +
        pow(t, 3) / 450000;

    // Konversi ke radian setelah di-mod 360
    d = mf.rad(mf.mod(d, 360.0));
    m = mf.rad(mf.mod(m, 360.0));
    mPrime = mf.rad(mf.mod(mPrime, 360.0));
    f = mf.rad(mf.mod(f, 360.0));
    omg = mf.rad(mf.mod(omg, 360.0));

    // Perhitungan Delta Epsilon (dalam satuan 0.0001 arcsecond)
    double dltEps = 0.0;
    dltEps +=
        (92025 + 8.9 * t) * cos(0 * d + 0 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltEps +=
        (5736 + -3.1 * t) * cos(-2 * d + 0 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps +=
        (977 + -0.5 * t) * cos(0 * d + 0 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps +=
        (-895 + 0.5 * t) * cos(0 * d + 0 * m + 0 * mPrime + 0 * f + 2 * omg);
    dltEps +=
        (54 + -0.1 * t) * cos(0 * d + 1 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltEps += (-7 + 0 * t) * cos(0 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps +=
        (224 + -0.6 * t) * cos(-2 * d + 1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps += (200 + 0 * t) * cos(0 * d + 0 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltEps +=
        (129 + -0.1 * t) * cos(0 * d + 0 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltEps +=
        (-95 + 0.3 * t) * cos(-2 * d + -1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(-2 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps +=
        (-70 + 0 * t) * cos(-2 * d + 0 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltEps +=
        (-53 + 0 * t) * cos(0 * d + 0 * m + -1 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(2 * d + 0 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltEps += (-33 + 0 * t) * cos(0 * d + 0 * m + 1 * mPrime + 0 * f + 1 * omg);
    dltEps += (26 + 0 * t) * cos(2 * d + 0 * m + -1 * mPrime + 2 * f + 2 * omg);
    dltEps += (32 + 0 * t) * cos(0 * d + 0 * m + -1 * mPrime + 0 * f + 1 * omg);
    dltEps += (27 + 0 * t) * cos(0 * d + 0 * m + 1 * mPrime + 2 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(-2 * d + 0 * m + 2 * mPrime + 0 * f + 0 * omg);
    dltEps +=
        (-24 + 0 * t) * cos(0 * d + 0 * m + -2 * mPrime + 2 * f + 1 * omg);
    dltEps += (16 + 0 * t) * cos(2 * d + 0 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps += (13 + 0 * t) * cos(0 * d + 0 * m + 2 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 0 * m + 2 * mPrime + 0 * f + 0 * omg);
    dltEps +=
        (-12 + 0 * t) * cos(-2 * d + 0 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 0 * m + 0 * mPrime + 2 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(-2 * d + 0 * m + 0 * mPrime + 2 * f + 0 * omg);
    dltEps +=
        (-10 + 0 * t) * cos(0 * d + 0 * m + -1 * mPrime + 2 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 2 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltEps += (-8 + 0 * t) * cos(2 * d + 0 * m + -1 * mPrime + 0 * f + 1 * omg);
    dltEps += (7 + 0 * t) * cos(-2 * d + 2 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps += (9 + 0 * t) * cos(0 * d + 1 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltEps += (7 + 0 * t) * cos(-2 * d + 0 * m + 1 * mPrime + 0 * f + 1 * omg);
    dltEps += (6 + 0 * t) * cos(0 * d + -1 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 0 * m + 2 * mPrime + -2 * f + 0 * omg);
    dltEps += (5 + 0 * t) * cos(2 * d + 0 * m + -1 * mPrime + 2 * f + 1 * omg);
    dltEps += (3 + 0 * t) * cos(2 * d + 0 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltEps += (-3 + 0 * t) * cos(0 * d + 1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(-2 * d + 1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps += (3 + 0 * t) * cos(0 * d + -1 * m + 0 * mPrime + 2 * f + 2 * omg);
    dltEps += (3 + 0 * t) * cos(2 * d + 0 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(2 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps += (-3 + 0 * t) * cos(-2 * d + 0 * m + 2 * mPrime + 2 * f + 2 * omg);
    dltEps += (-3 + 0 * t) * cos(-2 * d + 0 * m + 1 * mPrime + 2 * f + 1 * omg);
    dltEps += (3 + 0 * t) * cos(2 * d + 0 * m + -2 * mPrime + 0 * f + 1 * omg);
    dltEps += (3 + 0 * t) * cos(2 * d + 0 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + -1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps += (3 + 0 * t) * cos(-2 * d + -1 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltEps += (3 + 0 * t) * cos(-2 * d + 0 * m + 0 * mPrime + 0 * f + 1 * omg);
    dltEps += (3 + 0 * t) * cos(0 * d + 0 * m + 2 * mPrime + 2 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(-2 * d + 0 * m + 2 * mPrime + 0 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(-2 * d + 1 * m + 0 * mPrime + 2 * f + 1 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 0 * m + 1 * mPrime + -2 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(-1 * d + 0 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(-2 * d + 1 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(1 * d + 0 * m + 0 * mPrime + 0 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 0 * m + 1 * mPrime + 2 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 0 * m + -2 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(-1 * d + -1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 1 * m + 1 * mPrime + 0 * f + 0 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + -1 * m + 1 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(2 * d + -1 * m + -1 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(0 * d + 0 * m + 3 * mPrime + 2 * f + 2 * omg);
    dltEps += (0 + 0 * t) * cos(2 * d + -1 * m + 0 * mPrime + 2 * f + 2 * omg);

    // Konversi dari 0.0001 arcsecond ke derajat
    dltEps = dltEps / 36000000.0;

    return dltEps;
  }

  // ==========================================================================
  // MeanObliquityOfEcliptic (ε₀)
  // ==========================================================================
  double meanObliquityOfEcliptic(double jd) {
    double t = (jd - 2451545.0) / 36525.0;
    double u = t / 100.0;

    double eps0 =
        (23 + 26 / 60.0 + 21.448 / 3600.0) +
        (-4680.93 * u -
                1.55 * pow(u, 2) +
                1999.25 * pow(u, 3) -
                51.38 * pow(u, 4) -
                249.67 * pow(u, 5) -
                39.05 * pow(u, 6) +
                7.12 * pow(u, 7) +
                27.87 * pow(u, 8) +
                5.79 * pow(u, 9) +
                2.45 * pow(u, 10)) /
            3600.0;

    return eps0;
  }

  // ==========================================================================
  // ObliquityOfEcliptic (ε) - True Obliquity
  // ==========================================================================
  double obliquityOfEcliptic(double jd) {
    double eps0 = meanObliquityOfEcliptic(jd);
    double dltEps = nutationInObliquity(jd);
    double eps = eps0 + dltEps;
    return eps;
  }
}
