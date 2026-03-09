import 'dart:math' as math;
import 'package:myhisab/src/core/astronomy/dynamical_time.dart';
import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/math/math_utils.dart';
import 'package:myhisab/src/core/astronomy/moon_distance.dart';
import 'package:myhisab/src/core/astronomy/moon_function.dart';
import 'package:myhisab/src/core/astronomy/sun_function.dart';
import 'package:myhisab/src/model/solar_eclipse/solar_besselian_result.dart';
import '../model/solar_eclipse/solar_eclipse_local_result.dart';
import '../model/solar_eclipse/solar_eclipse_global_result.dart';
import '../model/solar_eclipse/solar_eclipse_global_range_result.dart';
import '../model/solar_eclipse/solar_eclipse_local_range_result.dart';
import 'package:myhisab/src/core/math/safe_math.dart';
import 'package:myhisab/src/core/astronomy/time_scale.dart';
import 'package:myhisab/src/model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseService {
  final julianDay = JulianDay();
  final dynamicalTime = DynamicalTime();

  final sn = SunFunction();
  final mf = MathFunction();
  final mo = MoonFunction();
  final md = MoonDistance();

  SolarBesselianResult? sBesselian(int hijriMonth, int hijriYear) {
    final jdeSolarEclipse1 = mo.jdeEclipseModified(hijriMonth, hijriYear, 1);

    if (jdeSolarEclipse1 <= 0) return null;

    final jdeSolarEclipse2 =
        mf.floor(jdeSolarEclipse1) +
        (((jdeSolarEclipse1 - mf.floor(jdeSolarEclipse1)) * 24).round()) / 24.0;

    final t0 =
        (((jdeSolarEclipse2 + 0.5) - (jdeSolarEclipse2 + 0.5).floor()) * 24)
            .roundToDouble();

    final deltaT = dynamicalTime.deltaT(jdeSolarEclipse2);

    // === SUN ===
    final arSm2 = sn.sunGeocentricRightAscension(jdeSolarEclipse2 - 2 / 24, 0);
    final arSm1 = sn.sunGeocentricRightAscension(jdeSolarEclipse2 - 1 / 24, 0);
    final arS00 = sn.sunGeocentricRightAscension(jdeSolarEclipse2, 0);
    final arSp1 = sn.sunGeocentricRightAscension(jdeSolarEclipse2 + 1 / 24, 0);
    final arSp2 = sn.sunGeocentricRightAscension(jdeSolarEclipse2 + 2 / 24, 0);

    final dSm2 = sn.sunGeocentricDeclination(jdeSolarEclipse2 - 2 / 24, 0);
    final dSm1 = sn.sunGeocentricDeclination(jdeSolarEclipse2 - 1 / 24, 0);
    final dS00 = sn.sunGeocentricDeclination(jdeSolarEclipse2, 0);
    final dSp1 = sn.sunGeocentricDeclination(jdeSolarEclipse2 + 1 / 24, 0);
    final dSp2 = sn.sunGeocentricDeclination(jdeSolarEclipse2 + 2 / 24, 0);

    final rSm2 = sn.sunGeocentricDistance(jdeSolarEclipse2 - 2 / 24, 0, "AU");
    final rSm1 = sn.sunGeocentricDistance(jdeSolarEclipse2 - 1 / 24, 0, "AU");
    final rS00 = sn.sunGeocentricDistance(jdeSolarEclipse2, 0, "AU");
    final rSp1 = sn.sunGeocentricDistance(jdeSolarEclipse2 + 1 / 24, 0, "AU");
    final rSp2 = sn.sunGeocentricDistance(jdeSolarEclipse2 + 2 / 24, 0, "AU");

    // === MOON ===
    final arMm2 = mo.moonGeocentricRightAscension(jdeSolarEclipse2 - 2 / 24, 0);
    final arMm1 = mo.moonGeocentricRightAscension(jdeSolarEclipse2 - 1 / 24, 0);
    final arM00 = mo.moonGeocentricRightAscension(jdeSolarEclipse2, 0);
    final arMp1 = mo.moonGeocentricRightAscension(jdeSolarEclipse2 + 1 / 24, 0);
    final arMp2 = mo.moonGeocentricRightAscension(jdeSolarEclipse2 + 2 / 24, 0);

    final dMm2 = mo.moonGeocentricDeclination(jdeSolarEclipse2 - 2 / 24, 0);
    final dMm1 = mo.moonGeocentricDeclination(jdeSolarEclipse2 - 1 / 24, 0);
    final dM00 = mo.moonGeocentricDeclination(jdeSolarEclipse2, 0);
    final dMp1 = mo.moonGeocentricDeclination(jdeSolarEclipse2 + 1 / 24, 0);
    final dMp2 = mo.moonGeocentricDeclination(jdeSolarEclipse2 + 2 / 24, 0);

    final hpMm2 = mo.moonEquatorialHorizontalParallax(
      jdeSolarEclipse2 - 2 / 24,
      0,
    );
    final hpMm1 = mo.moonEquatorialHorizontalParallax(
      jdeSolarEclipse2 - 1 / 24,
      0,
    );
    final hpM00 = mo.moonEquatorialHorizontalParallax(jdeSolarEclipse2, 0);
    final hpMp1 = mo.moonEquatorialHorizontalParallax(
      jdeSolarEclipse2 + 1 / 24,
      0,
    );
    final hpMp2 = mo.moonEquatorialHorizontalParallax(
      jdeSolarEclipse2 + 2 / 24,
      0,
    );

    // === bm ===
    final bm2 =
        math.sin(mf.rad(8.794 / 3600.0)) / rSm2 / math.sin(mf.rad(hpMm2));
    final bm1 =
        math.sin(mf.rad(8.794 / 3600.0)) / rSm1 / math.sin(mf.rad(hpMm1));
    final b00 =
        math.sin(mf.rad(8.794 / 3600.0)) / rS00 / math.sin(mf.rad(hpM00));
    final bp1 =
        math.sin(mf.rad(8.794 / 3600.0)) / rSp1 / math.sin(mf.rad(hpMp1));
    final bp2 =
        math.sin(mf.rad(8.794 / 3600.0)) / rSp2 / math.sin(mf.rad(hpMp2));

    // === g1 ===
    final g1m2 =
        math.cos(mf.rad(dSm2)) * math.cos(mf.rad(arSm2)) -
        bm2 * math.cos(mf.rad(dMm2)) * math.cos(mf.rad(arMm2));
    final g1m1 =
        math.cos(mf.rad(dSm1)) * math.cos(mf.rad(arSm1)) -
        bm1 * math.cos(mf.rad(dMm1)) * math.cos(mf.rad(arMm1));
    final g100 =
        math.cos(mf.rad(dS00)) * math.cos(mf.rad(arS00)) -
        b00 * math.cos(mf.rad(dM00)) * math.cos(mf.rad(arM00));
    final g1p1 =
        math.cos(mf.rad(dSp1)) * math.cos(mf.rad(arSp1)) -
        bp1 * math.cos(mf.rad(dMp1)) * math.cos(mf.rad(arMp1));
    final g1p2 =
        math.cos(mf.rad(dSp2)) * math.cos(mf.rad(arSp2)) -
        bp2 * math.cos(mf.rad(dMp2)) * math.cos(mf.rad(arMp2));

    // === g2 ===
    final g2m2 =
        math.cos(mf.rad(dSm2)) * math.sin(mf.rad(arSm2)) -
        bm2 * math.cos(mf.rad(dMm2)) * math.sin(mf.rad(arMm2));
    final g2m1 =
        math.cos(mf.rad(dSm1)) * math.sin(mf.rad(arSm1)) -
        bm1 * math.cos(mf.rad(dMm1)) * math.sin(mf.rad(arMm1));
    final g200 =
        math.cos(mf.rad(dS00)) * math.sin(mf.rad(arS00)) -
        b00 * math.cos(mf.rad(dM00)) * math.sin(mf.rad(arM00));
    final g2p1 =
        math.cos(mf.rad(dSp1)) * math.sin(mf.rad(arSp1)) -
        bp1 * math.cos(mf.rad(dMp1)) * math.sin(mf.rad(arMp1));
    final g2p2 =
        math.cos(mf.rad(dSp2)) * math.sin(mf.rad(arSp2)) -
        bp2 * math.cos(mf.rad(dMp2)) * math.sin(mf.rad(arMp2));

    // === g3 ===
    final g3m2 = math.sin(mf.rad(dSm2)) - bm2 * math.sin(mf.rad(dMm2));
    final g3m1 = math.sin(mf.rad(dSm1)) - bm1 * math.sin(mf.rad(dMm1));
    final g300 = math.sin(mf.rad(dS00)) - b00 * math.sin(mf.rad(dM00));
    final g3p1 = math.sin(mf.rad(dSp1)) - bp1 * math.sin(mf.rad(dMp1));
    final g3p2 = math.sin(mf.rad(dSp2)) - bp2 * math.sin(mf.rad(dMp2));

    // === a ===
    final am2 = mf.mod(mf.deg(math.atan2(g2m2, g1m2)), 360.0);
    final am1 = mf.mod(mf.deg(math.atan2(g2m1, g1m1)), 360.0);
    final a00 = mf.mod(mf.deg(math.atan2(g200, g100)), 360.0);
    final ap1 = mf.mod(mf.deg(math.atan2(g2p1, g1p1)), 360.0);
    final ap2 = mf.mod(mf.deg(math.atan2(g2p2, g1p2)), 360.0);

    // === d ===
    double dm(double g3, double g1, double g2) =>
        mf.deg(math.atan(g3 / math.sqrt(g1 * g1 + g2 * g2)));

    final dm2 = dm(g3m2, g1m2, g2m2);
    final dm1 = dm(g3m1, g1m1, g2m1);
    final d00 = dm(g300, g100, g200);
    final dp1 = dm(g3p1, g1p1, g2p1);
    final dp2 = dm(g3p2, g1p2, g2p2);

    // === gm ===
    double gm(double g1, double g2, double g3) =>
        math.sqrt(g1 * g1 + g2 * g2 + g3 * g3);

    final gm2 = gm(g1m2, g2m2, g3m2);
    final gm1 = gm(g1m1, g2m1, g3m1);
    final g00 = gm(g100, g200, g300);
    final gp1 = gm(g1p1, g2p1, g3p1);
    final gp2 = gm(g1p2, g2p2, g3p2);

    // === xm ===
    double xm(double dM, double aM, double a, double hp) =>
        (math.cos(mf.rad(dM)) * math.sin(mf.rad(aM - a))) /
        math.sin(mf.rad(hp));

    final xm2 = xm(dMm2, arMm2, am2, hpMm2);
    final xm1 = xm(dMm1, arMm1, am1, hpMm1);
    final x00 = xm(dM00, arM00, a00, hpM00);
    final xp1 = xm(dMp1, arMp1, ap1, hpMp1);
    final xp2 = xm(dMp2, arMp2, ap2, hpMp2);

    // === ym ===
    double ym(double dM, double d, double aM, double a, double hp) =>
        (math.sin(mf.rad(dM)) * math.cos(mf.rad(d)) -
            math.cos(mf.rad(dM)) *
                math.sin(mf.rad(d)) *
                math.cos(mf.rad(aM - a))) /
        math.sin(mf.rad(hp));

    final ym2 = ym(dMm2, dm2, arMm2, am2, hpMm2);
    final ym1 = ym(dMm1, dm1, arMm1, am1, hpMm1);
    final y00 = ym(dM00, d00, arM00, a00, hpM00);
    final yp1 = ym(dMp1, dp1, arMp1, ap1, hpMp1);
    final yp2 = ym(dMp2, dp2, arMp2, ap2, hpMp2);

    // === zm ===
    double zm(double dM, double d, double aM, double a, double hp) =>
        (math.sin(mf.rad(dM)) * math.sin(mf.rad(d)) +
            math.cos(mf.rad(dM)) *
                math.cos(mf.rad(d)) *
                math.cos(mf.rad(aM - a))) /
        math.sin(mf.rad(hp));

    final zm2 = zm(dMm2, dm2, arMm2, am2, hpMm2);
    final zm1 = zm(dMm1, dm1, arMm1, am1, hpMm1);
    final z00 = zm(dM00, d00, arM00, a00, hpM00);
    final zp1 = zm(dMp1, dp1, arMp1, ap1, hpMp1);
    final zp2 = zm(dMp2, dp2, arMp2, ap2, hpMp2);

    // === sin(f1,f2) ===
    final sinf1m2 = 0.004664026 / (gm2 * rSm2);
    final sinf1m1 = 0.004664026 / (gm1 * rSm1);
    final sinf100 = 0.004664026 / (g00 * rS00);
    final sinf1p1 = 0.004664026 / (gp1 * rSp1);
    final sinf1p2 = 0.004664026 / (gp2 * rSp2);

    final sinf2m2 = 0.004640784 / (gm2 * rSm2);
    final sinf2m1 = 0.004640784 / (gm1 * rSm1);
    final sinf200 = 0.004640784 / (g00 * rS00);
    final sinf2p1 = 0.004640784 / (gp1 * rSp1);
    final sinf2p2 = 0.004640784 / (gp2 * rSp2);

    // === tan(f1,f2) ===
    final tanf1m2 = math.tan(math.asin(sinf1m2));
    final tanf1m1 = math.tan(math.asin(sinf1m1));
    final tanf100 = math.tan(math.asin(sinf100));
    final tanf1p1 = math.tan(math.asin(sinf1p1));
    final tanf1p2 = math.tan(math.asin(sinf1p2));

    final tanf2m2 = math.tan(math.asin(sinf2m2));
    final tanf2m1 = math.tan(math.asin(sinf2m1));
    final tanf200 = math.tan(math.asin(sinf200));
    final tanf2p1 = math.tan(math.asin(sinf2p1));
    final tanf2p2 = math.tan(math.asin(sinf2p2));

    // === C1 & C2 ===
    final c1m2 = zm2 + 0.2724880 / sinf1m2;
    final c1m1 = zm1 + 0.2724880 / sinf1m1;
    final c100 = z00 + 0.2724880 / sinf100;
    final c1p1 = zp1 + 0.2724880 / sinf1p1;
    final c1p2 = zp2 + 0.2724880 / sinf1p2;

    final c2m2 = zm2 - 0.2722810 / sinf2m2;
    final c2m1 = zm1 - 0.2722810 / sinf2m1;
    final c200 = z00 - 0.2722810 / sinf200;
    final c2p1 = zp1 - 0.2722810 / sinf2p1;
    final c2p2 = zp2 - 0.2722810 / sinf2p2;

    // === l1 l2 ===
    final l1m2 = c1m2 * tanf1m2;
    final l1m1 = c1m1 * tanf1m1;
    final l100 = c100 * tanf100;
    final l1p1 = c1p1 * tanf1p1;
    final l1p2 = c1p2 * tanf1p2;

    final l2m2 = c2m2 * tanf2m2;
    final l2m1 = c2m1 * tanf2m1;
    final l200 = c200 * tanf200;
    final l2p1 = c2p1 * tanf2p1;
    final l2p2 = c2p2 * tanf2p2;

    // === GAST → mu ===
    final gastm2 = sn.greenwichApparentSiderialTime(
      jdeSolarEclipse2 - 2 / 24,
      0,
    );
    final gastm1 = sn.greenwichApparentSiderialTime(
      jdeSolarEclipse2 - 1 / 24,
      0,
    );
    final gast00 = sn.greenwichApparentSiderialTime(jdeSolarEclipse2, 0);
    final gastp1 = sn.greenwichApparentSiderialTime(
      jdeSolarEclipse2 + 1 / 24,
      0,
    );
    final gastp2 = sn.greenwichApparentSiderialTime(
      jdeSolarEclipse2 + 2 / 24,
      0,
    );

    final mum2 = mf.mod(gastm2 - am2, 360.0);
    final mum1 = mf.mod(gastm1 - am1, 360.0);
    final mu00 = mf.mod(gast00 - a00, 360.0);
    final mup1 = mf.mod(gastp1 - ap1, 360.0);
    final mup2 = mf.mod(gastp2 - ap2, 360.0);

    // ---------------- Hasil Interpolasi ----------------

    return SolarBesselianResult(
      jde: jdeSolarEclipse2,
      deltaT: deltaT,
      t0: t0,

      x: [
        mf.interp5(xm2, xm1, x00, xp1, xp2, 0),
        mf.interp5(xm2, xm1, x00, xp1, xp2, 1),
        mf.interp5(xm2, xm1, x00, xp1, xp2, 2),
        mf.interp5(xm2, xm1, x00, xp1, xp2, 3),
        mf.interp5(xm2, xm1, x00, xp1, xp2, 4),
      ],

      y: [
        mf.interp5(ym2, ym1, y00, yp1, yp2, 0),
        mf.interp5(ym2, ym1, y00, yp1, yp2, 1),
        mf.interp5(ym2, ym1, y00, yp1, yp2, 2),
        mf.interp5(ym2, ym1, y00, yp1, yp2, 3),
        mf.interp5(ym2, ym1, y00, yp1, yp2, 4),
      ],

      d: [
        mf.interp5(dm2, dm1, d00, dp1, dp2, 0),
        mf.interp5(dm2, dm1, d00, dp1, dp2, 1),
        mf.interp5(dm2, dm1, d00, dp1, dp2, 2),
        mf.interp5(dm2, dm1, d00, dp1, dp2, 3),
        mf.interp5(dm2, dm1, d00, dp1, dp2, 4),
      ],

      mu: [
        mf.interp5Angle(mum2, mum1, mu00, mup1, mup2, 0),
        mf.interp5Angle(mum2, mum1, mu00, mup1, mup2, 1),
        mf.interp5Angle(mum2, mum1, mu00, mup1, mup2, 2),
        mf.interp5Angle(mum2, mum1, mu00, mup1, mup2, 3),
        mf.interp5Angle(mum2, mum1, mu00, mup1, mup2, 4),
      ],

      l1: [
        mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 0),
        mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 1),
        mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 2),
        mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 3),
        mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 4),
      ],

      l2: [
        mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 0),
        mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 1),
        mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 2),
        mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 3),
        mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 4),
      ],

      tanf1: tanf100,
      tanf2: tanf200,
    );
  }

  SolarEclipseLocalResult? solarEclipseLocal({
    required int blnH,
    required int thnH,
    required double gLon,
    required double gLat,
    required double elev,
    required double pres,
    required double temp,
    required double tmZn,
  }) {
    // 🔴 CEK DULU APAKAH ADA GERHANA
    final bessel = sBesselian(blnH, thnH);

    if (bessel == null || !bessel.isValid) {
      return null;
    }

    // ===================== Variabel =====================
    double tMx = 0.0;
    double pi = 0.0;
    double S = 0.0;
    double C = 0.0;
    double xMx = 0.0;
    double yMx = 0.0;
    double dMx = 0.0;
    double muMx = 0.0;
    double l1Mx = 0.0;
    double l2Mx = 0.0;
    double xpMx = 0.0;
    double ypMx = 0.0;
    double hMx = 0.0;
    double pMx = 0.0;
    double qMx = 0.0;
    double rMx = 0.0;
    double prMx = 0.0;
    double qpMx = 0.0;
    double uMx = 0.0;
    double vMx = 0.0;
    double aMx = 0.0;
    double bMx = 0.0;
    double nMx = 0.0;
    double ppMx = 0.0;
    double aaMx = 0.0;

    // ===================== Data Besselian =====================
    final x = bessel.x!;
    final y = bessel.y!;
    final d = bessel.d!;
    final mu = bessel.mu!;
    final l1 = bessel.l1!;
    final l2 = bessel.l2!;
    final tanf1 = bessel.tanf1!;
    final tanf2 = bessel.tanf2!;
    final deltaT = bessel.deltaT!;
    final t0 = bessel.t0!;
    final jde2 = bessel.jde!;

    tMx += ppMx;
    // ===================== Iterasi 5 kali =====================
    for (int i = 1; i <= 5; i++) {
      pi = math.atan(0.99664719 * math.tan(mf.rad(gLat)));

      S = 0.99664719 * math.sin(pi) + (elev / 6378140) * math.sin(mf.rad(gLat));
      C = math.cos(pi) + (elev / 6378140) * math.cos(mf.rad(gLat));

      xMx =
          x[0] +
          x[1] * tMx +
          x[2] * tMx * tMx +
          x[3] * tMx * tMx * tMx +
          x[4] * tMx * tMx * tMx * tMx;
      yMx =
          y[0] +
          y[1] * tMx +
          y[2] * tMx * tMx +
          y[3] * tMx * tMx * tMx +
          y[4] * tMx * tMx * tMx * tMx;
      dMx =
          d[0] +
          d[1] * tMx +
          d[2] * tMx * tMx +
          d[3] * tMx * tMx * tMx +
          d[4] * tMx * tMx * tMx * tMx;

      muMx =
          mu[0] +
          mu[1] * tMx +
          mu[2] * tMx * tMx +
          mu[3] * tMx * tMx * tMx +
          mu[4] * tMx * tMx * tMx * tMx;

      l1Mx =
          l1[0] +
          l1[1] * tMx +
          l1[2] * tMx * tMx +
          l1[3] * tMx * tMx * tMx +
          l1[4] * tMx * tMx * tMx * tMx;
      l2Mx =
          l2[0] +
          l2[1] * tMx +
          l2[2] * tMx * tMx +
          l2[3] * tMx * tMx * tMx +
          l2[4] * tMx * tMx * tMx * tMx;

      xpMx =
          x[1] +
          2 * x[2] * tMx +
          3 * x[3] * tMx * tMx +
          4 * x[4] * tMx * tMx * tMx;
      ypMx =
          y[1] +
          2 * y[2] * tMx +
          3 * y[3] * tMx * tMx +
          4 * y[4] * tMx * tMx * tMx;

      hMx = mf.rad(muMx + gLon - 0.00417807 * deltaT);

      pMx = C * math.sin(hMx);
      qMx =
          S * math.cos(mf.rad(dMx)) - C * math.cos(hMx) * math.sin(mf.rad(dMx));
      rMx =
          S * math.sin(mf.rad(dMx)) + C * math.cos(hMx) * math.cos(mf.rad(dMx));

      prMx = 0.01745329 * mu[1] * C * math.cos(hMx);
      qpMx = 0.01745329 * (mu[1] * pMx * math.sin(mf.rad(dMx)) - rMx * d[1]);

      uMx = xMx - pMx;
      vMx = yMx - qMx;

      aMx = xpMx - prMx;
      bMx = ypMx - qpMx;

      nMx = aMx * aMx + bMx * bMx;

      ppMx = -(uMx * aMx + vMx * bMx) / nMx;
      tMx += ppMx;
    }

    // ===================== Waktu maksimum gerhana =====================
    aaMx = t0 + tMx - deltaT / 3600.0;
    final jdSolarMx = mf.floor(jde2 + 0.5) - 0.5 + (aaMx / 24.0);

    // ===================== Magnitude & Obskurasi =====================
    final mm = math.sqrt(uMx * uMx + vMx * vMx);
    final l1p = l1Mx - rMx * tanf1;
    final l2p = l2Mx - rMx * tanf2;

    final mag = (l1p - mm) / (l1p + l2p);

    if (mag <= 0) {
      return SolarEclipseLocalResult(
        ada: false,
        keterangan: "Tidak terjadi gerhana",
        besselian: bessel,
        jenis: "TIDAK TERJADI GERHANA",
      );
    }

    final nn = math.sqrt(nMx);
    final zz = (aMx * vMx - uMx * bMx) / (nn * l1p);
    final tau = (l1p / nn) * math.sqrt(1 - zz * zz);

    final rpMx = 2 * mm / (l1p + l2p);
    final spMx = (l1p - l2p) / (l1p + l2p);

    final yy = (spMx * spMx + rpMx * rpMx - 1) / (2 * rpMx * spMx);
    final zp = (rpMx * rpMx - spMx * spMx + 1) / (2 * rpMx);

    final bb = (yy < -1)
        ? math.pi
        : (yy > 1)
        ? 0.0
        : math.acos(yy);

    final cc = (zp < -1)
        ? math.pi
        : (zp > 1)
        ? 0.0
        : math.acos(zp);

    final obs =
        ((spMx * spMx * (bb - math.sin(2 * bb) / 2) +
                (cc - math.sin(2 * cc) / 2)) /
            math.pi) *
        100.0;

    // ===================== Jenis Gerhana =====================
    String jSE;

    if (mag > 0.0 && mm > l2p.abs()) {
      jSE = "GERHANA MATAHARI SEBAGIAN";
    } else if (mag > 0.0 && mm < l2p.abs() && l2p < 0.0) {
      jSE = "GERHANA MATAHARI TOTAL";
    } else if (mag > 0.0 && mm < l2p.abs() && l2p > 0.0) {
      jSE = "GERHANA MATAHARI CINCIN";
    } else {
      jSE = "TIDAK TERJADI GERHANA";
    }

    final double mag3 = (jSE == "GERHANA MATAHARI SEBAGIAN") ? mag : spMx;

    // // Hisab Kontak U2 dan U3
    // final double qq = (aMx * vMx - uMx * bMx) / (nn * l2p);
    // final double t2 = ((l2p / nn) * math.sqrt(1 - qq * qq)).abs();
    // final double aU2 = aaMx - t2;
    // final double aU3 = aaMx + t2;
    // final double jdSolarU2 = (jde2 + 0.5).floorToDouble() - 0.5 + (aU2 / 24.0);
    // final double jdSolarU3 = (jde2 + 0.5).floorToDouble() - 0.5 + (aU3 / 24.0);

    // =====================
    // Hisab Kontak U2 dan U3
    // =====================

    double? jdSolarU2;
    double? jdSolarU3;

    if (mm < l2p.abs()) {
      final double qq = (aMx * vMx - uMx * bMx) / (nn * l2p);

      final double inside = 1 - qq * qq;

      if (inside >= 0) {
        final double t2 = ((l2p / nn) * math.sqrt(inside)).abs();

        final double aU2 = aaMx - t2;
        final double aU3 = aaMx + t2;

        jdSolarU2 = (jde2 + 0.5).floorToDouble() - 0.5 + (aU2 / 24.0);

        jdSolarU3 = (jde2 + 0.5).floorToDouble() - 0.5 + (aU3 / 24.0);
      }
    }

    // =======================
    // Hisab Kontak U1
    // =======================

    late double jdSolarU1;

    double t = 0.0;
    double aaU1;
    double tU1;

    double xU1 = 0.0;
    double yU1 = 0.0;
    double dU1 = 0.0;
    double muU1 = 0.0;
    double l1U1 = 0.0;
    double xpU1 = 0.0;
    double ypU1 = 0.0;
    double hU1 = 0.0;
    double pU1 = 0.0;
    double qU1 = 0.0;
    double rU1 = 0.0;
    double prU1 = 0.0;
    double qpU1 = 0.0;
    double uU1 = 0.0;
    double vU1 = 0.0;
    double aU1 = 0.0;
    double bU1 = 0.0;
    double nU1 = 0.0;
    double nnU1 = 0.0;
    double l1pU1 = 0.0;
    double mmU1 = 0.0;
    double ppU1 = 0.0;

    tU1 = t - tau;

    for (int i = 0; i < 5; i++) {
      final pi = math.atan(0.99664719 * math.tan(mf.rad(gLat)));
      final s =
          0.99664719 * math.sin(pi) + (elev / 6378140) * math.sin(mf.rad(gLat));
      final c = math.cos(pi) + (elev / 6378140) * math.cos(mf.rad(gLat));

      xU1 =
          x[0] +
          x[1] * tU1 +
          x[2] * tU1 * tU1 +
          x[3] * tU1 * tU1 * tU1 +
          x[4] * tU1 * tU1 * tU1 * tU1;

      yU1 =
          y[0] +
          y[1] * tU1 +
          y[2] * tU1 * tU1 +
          y[3] * tU1 * tU1 * tU1 +
          y[4] * tU1 * tU1 * tU1 * tU1;

      dU1 =
          d[0] +
          d[1] * tU1 +
          d[2] * tU1 * tU1 +
          d[3] * tU1 * tU1 * tU1 +
          d[4] * tU1 * tU1 * tU1 * tU1;

      muU1 =
          mu[0] +
          mu[1] * tU1 +
          mu[2] * tU1 * tU1 +
          mu[3] * tU1 * tU1 * tU1 +
          mu[4] * tU1 * tU1 * tU1 * tU1;

      l1U1 =
          l1[0] +
          l1[1] * tU1 +
          l1[2] * tU1 * tU1 +
          l1[3] * tU1 * tU1 * tU1 +
          l1[4] * tU1 * tU1 * tU1 * tU1;

      // l2U1 =
      //     l2[0] +
      //     l2[1] * tU1 +
      //     l2[2] * tU1 * tU1 +
      //     l2[3] * tU1 * tU1 * tU1 +
      //     l2[4] * tU1 * tU1 * tU1 * tU1;

      xpU1 =
          x[1] +
          2 * x[2] * tU1 +
          3 * x[3] * tU1 * tU1 +
          4 * x[4] * tU1 * tU1 * tU1;

      ypU1 =
          y[1] +
          2 * y[2] * tU1 +
          3 * y[3] * tU1 * tU1 +
          4 * y[4] * tU1 * tU1 * tU1;

      hU1 = mf.rad(muU1 + gLon - 0.00417807 * deltaT);
      pU1 = c * math.sin(hU1);
      qU1 =
          s * math.cos(mf.rad(dU1)) - c * math.cos(hU1) * math.sin(mf.rad(dU1));
      rU1 =
          s * math.sin(mf.rad(dU1)) + c * math.cos(hU1) * math.cos(mf.rad(dU1));

      prU1 = 0.01745329 * mu[1] * c * math.cos(hU1);
      qpU1 = 0.01745329 * (mu[1] * pU1 * math.sin(mf.rad(dU1)) - rU1 * d[1]);

      uU1 = xU1 - pU1;
      vU1 = yU1 - qU1;
      aU1 = xpU1 - prU1;
      bU1 = ypU1 - qpU1;

      nU1 = aU1 * aU1 + bU1 * bU1;
      nnU1 = math.sqrt(nU1);

      l1pU1 = l1U1 - rU1 * tanf1;
      mmU1 = (aU1 * vU1 - uU1 * bU1) / (nnU1 * l1pU1);
      ppU1 =
          -(uU1 * aU1 + vU1 * bU1) / nU1 -
          (l1pU1 / nnU1) * math.sqrt(1 - mmU1 * mmU1);

      tU1 += ppU1;
    }

    aaU1 = tU1 + ppU1 - deltaT / 3600.0;
    jdSolarU1 = jde2.floorToDouble() + 0.5 + ((t0 + aaU1) / 24.0);

    // =======================
    // Hisab Kontak U4
    // =======================

    double jdSolarU4;
    double aaU4;
    double tU4;

    double xU4 = 0.0;
    double yU4 = 0.0;
    double dU4 = 0.0;
    double muU4 = 0.0;
    double l1U4 = 0.0;
    double xpU4 = 0.0;
    double ypU4 = 0.0;
    double hU4 = 0.0;
    double pU4 = 0.0;
    double qU4 = 0.0;
    double rU4 = 0.0;
    double prU4 = 0.0;
    double qpU4 = 0.0;
    double uU4 = 0.0;
    double vU4 = 0.0;
    double aU4 = 0.0;
    double bU4 = 0.0;
    double nU4 = 0.0;
    double nnU4 = 0.0;
    double l1pU4 = 0.0;
    double mmU4 = 0.0;
    double ppU4 = 0.0;

    tU4 = t + tau;

    for (int i = 0; i < 5; i++) {
      final pi = math.atan(0.99664719 * math.tan(mf.rad(gLat)));
      final s =
          0.99664719 * math.sin(pi) + (elev / 6378140) * math.sin(mf.rad(gLat));
      final c = math.cos(pi) + (elev / 6378140) * math.cos(mf.rad(gLat));

      xU4 =
          x[0] +
          x[1] * tU4 +
          x[2] * tU4 * tU4 +
          x[3] * tU4 * tU4 * tU4 +
          x[4] * tU4 * tU4 * tU4 * tU4;

      yU4 =
          y[0] +
          y[1] * tU4 +
          y[2] * tU4 * tU4 +
          y[3] * tU4 * tU4 * tU4 +
          y[4] * tU4 * tU4 * tU4 * tU4;

      dU4 =
          d[0] +
          d[1] * tU4 +
          d[2] * tU4 * tU4 +
          d[3] * tU4 * tU4 * tU4 +
          d[4] * tU4 * tU4 * tU4 * tU4;

      muU4 =
          mu[0] +
          mu[1] * tU4 +
          mu[2] * tU4 * tU4 +
          mu[3] * tU4 * tU4 * tU4 +
          mu[4] * tU4 * tU4 * tU4 * tU4;

      l1U4 =
          l1[0] +
          l1[1] * tU4 +
          l1[2] * tU4 * tU4 +
          l1[3] * tU4 * tU4 * tU4 +
          l1[4] * tU4 * tU4 * tU4 * tU4;

      // l2U4 =
      //     l2[0] +
      //     l2[1] * tU4 +
      //     l2[2] * tU4 * tU4 +
      //     l2[3] * tU4 * tU4 * tU4 +
      //     l2[4] * tU4 * tU4 * tU4 * tU4;

      xpU4 =
          x[1] +
          2 * x[2] * tU4 +
          3 * x[3] * tU4 * tU4 +
          4 * x[4] * tU4 * tU4 * tU4;

      ypU4 =
          y[1] +
          2 * y[2] * tU4 +
          3 * y[3] * tU4 * tU4 +
          4 * y[4] * tU4 * tU4 * tU4;

      hU4 = mf.rad(muU4 + gLon - 0.00417807 * deltaT);
      pU4 = c * math.sin(hU4);
      qU4 =
          s * math.cos(mf.rad(dU4)) - c * math.cos(hU4) * math.sin(mf.rad(dU4));
      rU4 =
          s * math.sin(mf.rad(dU4)) + c * math.cos(hU4) * math.cos(mf.rad(dU4));

      prU4 = 0.01745329 * mu[1] * c * math.cos(hU4);
      qpU4 = 0.01745329 * (mu[1] * pU4 * math.sin(mf.rad(dU4)) - rU4 * d[1]);

      uU4 = xU4 - pU4;
      vU4 = yU4 - qU4;
      aU4 = xpU4 - prU4;
      bU4 = ypU4 - qpU4;

      nU4 = aU4 * aU4 + bU4 * bU4;
      nnU4 = math.sqrt(nU4);
      l1pU4 = l1U4 - rU4 * tanf1;
      mmU4 = (aU4 * vU4 - uU4 * bU4) / (nnU4 * l1pU4);

      ppU4 =
          -(uU4 * aU4 + vU4 * bU4) / nU4 +
          (l1pU4 / nnU4) * math.sqrt(1 - mmU4 * mmU4);

      tU4 += ppU4;
    }

    aaU4 = tU4 + ppU4 - deltaT / 3600.0;
    jdSolarU4 = (jde2 + 0.5).floorToDouble() - 0.5 + ((t0 + aaU4) / 24.0);

    double durG = (jdSolarU4 - jdSolarU1) * 24.0;

    final durT = (jdSolarU2 != null && jdSolarU3 != null)
        ? (jdSolarU3 - jdSolarU2) * 24.0
        : null;

    //double durT = (jdSolarU3 - jdSolarU2) * 24.0;

    // Hisab Azimuth tiap kontak
    final double azmU1 = sn.sunTopocentricAzimuth(
      jdSolarU1,
      0.0,
      gLon,
      gLat,
      elev,
    );

    final double? azmU2 = jdSolarU2 != null
        ? sn.sunTopocentricAzimuth(jdSolarU2, 0.0, gLon, gLat, elev)
        : null;

    final double azmMx = sn.sunTopocentricAzimuth(
      jdSolarMx,
      0.0,
      gLon,
      gLat,
      elev,
    );

    final double? azmU3 = jdSolarU3 != null
        ? sn.sunTopocentricAzimuth(jdSolarU3, 0.0, gLon, gLat, elev)
        : null;

    final double azmU4 = sn.sunTopocentricAzimuth(
      jdSolarU4,
      0.0,
      gLon,
      gLat,
      elev,
    );

    // Hisab Altitude tiap kontak
    final double altU1 = sn.sunTopocentricAltitude(
      jdSolarU1,
      0.0,
      gLon,
      gLat,
      elev,
      pres,
      temp,
      "htoc",
    );

    final double? altU2 = jdSolarU2 != null
        ? sn.sunTopocentricAltitude(
            jdSolarU2,
            0.0,
            gLon,
            gLat,
            elev,
            pres,
            temp,
            "htoc",
          )
        : null;

    final double altMx = sn.sunTopocentricAltitude(
      jdSolarMx,
      0.0,
      gLon,
      gLat,
      elev,
      pres,
      temp,
      "htoc",
    );

    final double? altU3 = jdSolarU3 != null
        ? sn.sunTopocentricAltitude(
            jdSolarU3,
            0.0,
            gLon,
            gLat,
            elev,
            pres,
            temp,
            "htoc",
          )
        : null;

    final double altU4 = sn.sunTopocentricAltitude(
      jdSolarU4,
      0.0,
      gLon,
      gLat,
      elev,
      pres,
      temp,
      "htoc",
    );

    // ================== Data matahari saat maximum=====================
    double raS = sn.sunGeocentricRightAscension(jdSolarMx, 0);
    double dcS = sn.sunGeocentricDeclination(jdSolarMx, 0);
    double sdS = sn.sunGeocentricSemidiameter(jdSolarMx, 0);
    double hpS = sn.sunEquatorialHorizontalParallax(jdSolarMx, 0);

    // ================== Data bulan saat maximum=====================
    double raM = mo.moonGeocentricRightAscension(jdSolarMx, 0);
    double dcM = mo.moonGeocentricDeclination(jdSolarMx, 0);
    double sdM = mo.moonGeocentricSemidiameter(jdSolarMx, 0);
    double hpM = mo.moonEquatorialHorizontalParallax(jdSolarMx, 0);

    return SolarEclipseLocalResult(
      ada: true,
      keterangan: "Ada gerhana",

      besselian: bessel,

      u1: EclipseContact(jd: jdSolarU1, azimuth: azmU1, altitude: altU1),
      u2: EclipseContact(jd: jdSolarU2, azimuth: azmU2, altitude: altU2),
      mx: EclipseContact(jd: jdSolarMx, azimuth: azmMx, altitude: altMx),
      u3: EclipseContact(jd: jdSolarU3, azimuth: azmU3, altitude: altU3),
      u4: EclipseContact(jd: jdSolarU4, azimuth: azmU4, altitude: altU4),

      ephemerisMaximum: EclipseEphemeris(
        sun: EclipseEphemerisBody(ra: raS / 15, dec: dcS, sd: sdS, hp: hpS),
        moon: EclipseEphemerisBody(ra: raM / 15, dec: dcM, sd: sdM, hp: hpM),
      ),

      magnitude: mag3,
      obscuration: obs,
      jenis: jSE,
      durasiGerhana: durG,
      durasiTotalitas: durT,
    );
  }

  //GERHANA MATAHARI GLOBAL

  SolarEclipseGlobalResult? solarEclipseGlobal({
    required int blnH,
    required int thnH,
  }) {
    // 🔴 CEK DULU APAKAH ADA GERHANA
    final bessel = sBesselian(blnH, thnH);

    if (bessel == null || !bessel.isValid) {
      return null;
    }

    // ===================== Data Besselian =====================
    final t0 = bessel.t0!;
    final dt = bessel.deltaT!;
    final jde2 = bessel.jde!;
    final x = bessel.x!;
    final y = bessel.y!;
    final d = bessel.d!;
    final mu = bessel.mu!;
    final l1 = bessel.l1!;
    final l2 = bessel.l2!;
    final tanf1 = bessel.tanf1!;
    final tanf2 = bessel.tanf2!;

    double xMx = 0.0;
    double yMx = 0.0;
    double dMx = 0.0;
    double muMx = 0.0;
    double xpMx = 0.0;
    double ypMx = 0.0;

    double mbMx;
    double msMx = 0.0;
    double nbMx;
    double nsMx;

    double tuMx = 0.0;
    double tMx = 0.0;
    late double mXTD;
    late double mXUT;

    tMx += tuMx;

    for (int i = 1; i <= 7; i++) {
      xMx =
          x[0] +
          x[1] * tMx +
          x[2] * tMx * tMx +
          x[3] * tMx * tMx * tMx +
          x[4] * tMx * tMx * tMx * tMx;

      yMx =
          y[0] +
          y[1] * tMx +
          y[2] * tMx * tMx +
          y[3] * tMx * tMx * tMx +
          y[4] * tMx * tMx * tMx * tMx;

      dMx =
          d[0] +
          d[1] * tMx +
          d[2] * tMx * tMx +
          d[3] * tMx * tMx * tMx +
          d[4] * tMx * tMx * tMx * tMx;

      muMx =
          mu[0] +
          mu[1] * tMx +
          mu[2] * tMx * tMx +
          mu[3] * tMx * tMx * tMx +
          mu[4] * tMx * tMx * tMx * tMx;

      xpMx =
          x[1] +
          2 * x[2] * tMx +
          3 * x[3] * tMx * tMx +
          4 * x[4] * tMx * tMx * tMx;

      ypMx =
          y[1] +
          2 * y[2] * tMx +
          3 * y[3] * tMx * tMx +
          4 * y[4] * tMx * tMx * tMx;

      mbMx = mf.mod(mf.deg(math.atan2(yMx, xMx)), 360.0);
      msMx = SafeMath.sqrt(xMx * xMx + yMx * yMx);

      nbMx = mf.mod(mf.deg(math.atan2(ypMx, xpMx)), 360.0);
      nsMx = SafeMath.sqrt(xpMx * xpMx + ypMx * ypMx);

      tuMx = -SafeMath.safeDiv(msMx * math.cos(mf.rad(mbMx - nbMx)), nsMx);
      tMx += tuMx;
    }

    mXTD = mf.mod(t0 + tMx, 24.0);
    mXUT = mf.mod(t0 + tMx - dt / 3600.0, 24.0);

    // ==========================
    // Tipe, Jenis, Durasi Gerhana
    // ==========================

    final double l1Mx =
        l1[0] +
        l1[1] * tuMx +
        l1[2] * tuMx * tuMx +
        l1[3] * tuMx * tuMx * tuMx +
        l1[4] * tuMx * tuMx * tuMx * tuMx;

    final double l2Mx =
        l2[0] +
        l2[1] * tuMx +
        l2[2] * tuMx * tuMx +
        l2[3] * tuMx * tuMx * tuMx +
        l2[4] * tuMx * tuMx * tuMx * tuMx;

    String jse;

    if (msMx < 0.9972) {
      if (l2Mx < 0) {
        jse = "Sentral Total";
      } else if (l2Mx > 0.0047) {
        jse = "Sentral Cincin";
      } else {
        jse = "Sentral Hybrid";
      }
    } else if (msMx > 0.9972) {
      if (l2Mx < 0 && msMx < (l2Mx.abs() + 0.9972)) {
        jse = "Non Sentral Total";
      } else if (l2Mx > 0 && msMx < (l2Mx.abs() + 0.9972)) {
        jse = "Non Sentral Cincin";
      } else if (msMx < (l2Mx.abs() + 1.5433)) {
        jse = "Non Sentral Sebagian";
      } else {
        jse = "";
      }
    } else {
      jse = "Tidak ada gerhana";
    }

    // ==========================
    // Koordinat puncak gerhana
    // ==========================

    final double a = 6378137.0;
    final double b = 6356752.0;
    final double f = (a - b) / a;
    final double e2 = (2 * f) - (f * f);

    final double ba = b / a;
    final double ab = a / b;

    final double rho0 = SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dMx)));
    final double d1Mx = mf.deg(
      math.atan(
        SafeMath.safeDiv(math.sin(mf.rad(dMx)), (math.cos(mf.rad(dMx)) * ba)),
      ),
    );

    final double y1Mx = SafeMath.safeDiv(yMx, rho0);
    final double m1Mx = SafeMath.sqrt(xMx * xMx + y1Mx * y1Mx);
    final double y2Mx = SafeMath.safeDiv(y1Mx, m1Mx);

    final double bBig = SafeMath.sqrt(
      math.max(0.0, 1 - xMx * xMx - y1Mx * y1Mx),
    );

    final double pi1Mx = (msMx < 0.9972)
        ? mf.deg(
            SafeMath.asin(
              y1Mx * math.cos(mf.rad(d1Mx)) + bBig * math.sin(mf.rad(d1Mx)),
            ),
          )
        : mf.deg(SafeMath.asin(y2Mx * math.cos(mf.rad(d1Mx))));

    final double piMx = mf.deg(math.atan(ab * math.tan(mf.rad(pi1Mx))));

    final double x2Mx = (msMx < 0.9972)
        ? -y1Mx * math.sin(mf.rad(d1Mx)) + bBig * math.cos(mf.rad(d1Mx))
        : -y1Mx * math.sin(mf.rad(d1Mx));

    final double haMx = mf.mod(mf.deg(math.atan2(xMx, x2Mx)), 360.0);

    final double calc = haMx - muMx + (0.004178 * dt);
    final double ldMx = (calc > 180)
        ? calc - 360
        : (calc < -180 ? calc + 360 : calc);

    // ==========================
    final double l1pMx = l1Mx - bBig * tanf1;
    final double l2pMx = l2Mx - bBig * tanf2;

    final double pp = mf.rad(mu[1]);

    final double aa = ypMx - pp * xMx * math.sin(mf.rad(dMx));

    final double bb = xpMx + pp * yMx * math.sin(mf.rad(dMx));

    final double cc = bb - pp * bBig * math.cos(mf.rad(dMx));

    final double ns1 = SafeMath.sqrt(cc * cc + aa * aa);

    final double dur = SafeMath.safeDiv(mf.abs(7200 * l2pMx), ns1) / 60.0;

    // ==========================
    // Azimuth & Altitude puncak gerhana
    // ==========================

    final double altMx = mf.deg(
      SafeMath.asin(
        math.sin(mf.rad(piMx)) * math.sin(mf.rad(dMx)) +
            math.cos(mf.rad(piMx)) *
                math.cos(mf.rad(dMx)) *
                math.cos(mf.rad(haMx)),
      ),
    );

    final double azmMx = mf.mod(
      mf.deg(
            math.atan2(
              math.sin(mf.rad(haMx)),
              math.cos(mf.rad(haMx)) * math.sin(mf.rad(piMx)) -
                  math.tan(mf.rad(dMx)) * math.cos(mf.rad(piMx)),
            ),
          ) +
          180,
      360.0,
    );

    // ==========================
    // Magnitudo gerhana
    // ==========================

    final double rho = SafeMath.safeDiv(msMx, m1Mx);

    final double ddd = msMx - rho;

    final double mag1 = SafeMath.safeDiv(l1pMx - l2pMx, l1pMx + l2pMx);

    final double mag2 = SafeMath.safeDiv(l1Mx - ddd, l1Mx + l2Mx);

    final double mag = (msMx < 0.9972) ? mag1 : mag2;

    if (mag <= 0) {
      return SolarEclipseGlobalResult(
        ada: false,
        besselian: bessel,
        jenis: jse,
      );
    }
    // ==========================
    // Lebar gerhana
    // ==========================

    final double kk = SafeMath.sqrt(
      bBig * bBig + math.pow(SafeMath.safeDiv((xMx * cc + yMx * aa), ns1), 2.0),
    );

    final double wd = mf.abs(SafeMath.safeDiv(12756 * l2pMx, kk));

    // ==========================
    // Obskurasi (belum)
    // ==========================

    final double jdSolarEclipseMxTD = mf.floor(jde2 - 0.5) + 0.5 + mXTD / 24.0;

    final double jdSolarEclipseMxUT = mf.floor(jde2 - 0.5) + 0.5 + mXUT / 24.0;

    //Data MATAHARI DAN BULAN SAAT PUNCAK GERHANA
    //(ra: raS / 15, dec: dcS, sd: sdS, hp: hpS),

    final raS = sn.sunGeocentricRightAscension(jdSolarEclipseMxTD, 0);
    final dcS = sn.sunGeocentricDeclination(jdSolarEclipseMxTD, 0);
    final sdS = sn.sunGeocentricSemidiameter(jdSolarEclipseMxTD, 0);
    final hpS = sn.sunEquatorialHorizontalParallax(jdSolarEclipseMxTD, 0);

    final raM = mo.moonGeocentricRightAscension(jdSolarEclipseMxTD, 0);
    final dcM = mo.moonGeocentricDeclination(jdSolarEclipseMxTD, 0);
    final sdM = mo.moonGeocentricSemidiameter(jdSolarEclipseMxTD, 0);
    final hpM = mo.moonEquatorialHorizontalParallax(jdSolarEclipseMxTD, 0);

    final bool central = msMx < 0.9972;

    // hitung semua P
    double? jdSolarEclipseP1TD;
    double? jdSolarEclipseP2TD;
    double? jdSolarEclipseP3TD;
    double? jdSolarEclipseP4TD;

    double? jdSolarEclipseP1UT;
    double? jdSolarEclipseP2UT;
    double? jdSolarEclipseP3UT;
    double? jdSolarEclipseP4UT;

    double? ldP1, ldP2, ldP3, ldP4;
    double? piP1, piP2, piP3, piP4;
    double? altP1, altP2, altP3, altP4;
    double? azmP1, azmP2, azmP3, azmP4;

    // hitung semua U
    double? jdSolarEclipseU1TD;
    double? jdSolarEclipseU2TD;
    double? jdSolarEclipseU3TD;
    double? jdSolarEclipseU4TD;

    double? jdSolarEclipseU1UT;
    double? jdSolarEclipseU2UT;
    double? jdSolarEclipseU3UT;
    double? jdSolarEclipseU4UT;

    double? altU1, altU2, altU3, altU4;
    double? azmU1, azmU2, azmU3, azmU4;

    double? piU1, piU2, piU3, piU4;
    double? ldU1, ldU2, ldU3, ldU4;

    // hitung semua C
    double? jdSolarEclipseC1TD;
    double? jdSolarEclipseC2TD;
    double? jdSolarEclipseC1UT;
    double? jdSolarEclipseC2UT;

    double? altC1, altC2;
    double? azmC1, azmC2;

    double? piC1, piC2;
    double? ldC1, ldC2;

    if (central) {
      //KONTAK P1 & P4
      //Penumbral First External Contact (P1)

      double xP1 = 0.0;
      double yP1 = 0.0;
      double dP1 = 0.0;
      double muP1 = 0.0;
      double xpP1 = 0.0;
      double ypP1 = 0.0;
      double l1P1 = 0.0;
      double omP1 = 0.0;
      double msP1 = 0.0;
      double y1P1 = 0.0;
      double m1P1 = 0.0;
      double roP1 = 0.0;
      double n2P1 = 0.0;
      double nsP1 = 0.0;
      double psP1 = 0.0;

      double tuP1 = 0.0;
      double tP1 = 0.0;

      tP1 += tuP1;

      for (int i = 1; i <= 5; i++) {
        xP1 =
            x[0] +
            x[1] * tP1 +
            x[2] * tP1 * tP1 +
            x[3] * tP1 * tP1 * tP1 +
            x[4] * tP1 * tP1 * tP1 * tP1;

        yP1 =
            y[0] +
            y[1] * tP1 +
            y[2] * tP1 * tP1 +
            y[3] * tP1 * tP1 * tP1 +
            y[4] * tP1 * tP1 * tP1 * tP1;

        dP1 =
            d[0] +
            d[1] * tP1 +
            d[2] * tP1 * tP1 +
            d[3] * tP1 * tP1 * tP1 +
            d[4] * tP1 * tP1 * tP1 * tP1;

        muP1 =
            mu[0] +
            mu[1] * tP1 +
            mu[2] * tP1 * tP1 +
            mu[3] * tP1 * tP1 * tP1 +
            mu[4] * tP1 * tP1 * tP1 * tP1;

        xpP1 =
            x[1] +
            2 * x[2] * tP1 +
            3 * x[3] * tP1 * tP1 +
            4 * x[4] * tP1 * tP1 * tP1;

        ypP1 =
            y[1] +
            2 * y[2] * tP1 +
            3 * y[3] * tP1 * tP1 +
            4 * y[4] * tP1 * tP1 * tP1;

        l1P1 =
            l1[0] +
            l1[1] * tP1 +
            l1[2] * tP1 * tP1 +
            l1[3] * tP1 * tP1 * tP1 +
            l1[4] * tP1 * tP1 * tP1 * tP1;

        omP1 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dP1)) * math.cos(mf.rad(dP1))),
        );

        msP1 = SafeMath.sqrt(xP1 * xP1 + yP1 * yP1);

        y1P1 = yP1 * omP1;
        m1P1 = SafeMath.sqrt(xP1 * xP1 + y1P1 * y1P1);
        roP1 = SafeMath.safeDiv(msP1, m1P1);

        n2P1 = xpP1 * xpP1 + ypP1 * ypP1;
        nsP1 = SafeMath.sqrt(n2P1);

        psP1 = SafeMath.asin(
          SafeMath.safeDiv((xP1 * ypP1 - xpP1 * yP1), (nsP1 * (l1P1 + roP1))),
        );

        tuP1 =
            SafeMath.safeDiv((l1P1 + roP1), nsP1) * -math.cos(psP1) -
            SafeMath.safeDiv((xP1 * xpP1 + yP1 * ypP1), (nsP1 * nsP1));

        tP1 = tP1 + tuP1;
      }

      double p1TD = mf.mod(t0 + tP1, 24.0);
      double p1UT = mf.mod(p1TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak P1
      double d1P1 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dP1)), (math.cos(mf.rad(dP1)) * ba)),
        ),
      );

      double rhP1 = SafeMath.sqrt(
        math.sin(mf.rad(dP1)) * math.sin(mf.rad(dP1)) +
            (math.cos(mf.rad(dP1)) * ba) * (math.cos(mf.rad(dP1)) * ba),
      );

      double yIP1 = SafeMath.safeDiv(yP1, rhP1);
      double mIP1 = SafeMath.sqrt(xP1 * xP1 + yIP1 * yIP1);

      double x1P1 = SafeMath.safeDiv(xP1, mIP1);
      double y2P1 = SafeMath.safeDiv(yIP1, mIP1);

      double pi1P1 = mf.deg(SafeMath.asin(y2P1 * math.cos(mf.rad(d1P1))));

      piP1 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P1))));

      double x2P1 = -y2P1 * math.sin(mf.rad(dP1));

      double haP1 = mf.mod(mf.deg(math.atan2(x1P1, x2P1)), 360.0);

      double caP1 = haP1 - muP1 + (0.004178 * dt);

      ldP1;

      if (caP1 > 180) {
        ldP1 = caP1 - 360;
      } else if (caP1 < -180) {
        ldP1 = caP1 + 360;
      } else {
        ldP1 = caP1;
      }

      // Azimuth dan Altitude
      altP1 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piP1)) * math.sin(mf.rad(dP1)) +
              math.cos(mf.rad(piP1)) *
                  math.cos(mf.rad(dP1)) *
                  math.cos(mf.rad(haP1)),
        ),
      );

      azmP1 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haP1)),
                math.cos(mf.rad(haP1)) * math.sin(mf.rad(piP1)) -
                    math.tan(mf.rad(dP1)) * math.cos(mf.rad(piP1)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak P1

      jdSolarEclipseP1TD = mf.floor(jde2 - 0.5) + 0.5 + p1TD / 24.0;
      jdSolarEclipseP1UT = mf.floor(jde2 - 0.5) + 0.5 + p1UT / 24.0;

      // Penumbral Last External Contact (P4)

      double xP4 = 0.0;
      double yP4 = 0.0;
      double dP4 = 0.0;
      double muP4 = 0.0;
      double xpP4 = 0.0;
      double ypP4 = 0.0;
      double l1P4 = 0.0;
      double omP4 = 0.0;
      double msP4 = 0.0;
      double y1P4 = 0.0;
      double m1P4 = 0.0;
      double roP4 = 0.0;
      double n2P4 = 0.0;
      double nsP4 = 0.0;
      double psP4 = 0.0;

      double tuP4 = 0.0;
      double tP4 = 0.0;

      tP4 += tuP4;

      for (int i = 1; i <= 5; i++) {
        xP4 =
            x[0] +
            x[1] * tP4 +
            x[2] * tP4 * tP4 +
            x[3] * tP4 * tP4 * tP4 +
            x[4] * tP4 * tP4 * tP4 * tP4;

        yP4 =
            y[0] +
            y[1] * tP4 +
            y[2] * tP4 * tP4 +
            y[3] * tP4 * tP4 * tP4 +
            y[4] * tP4 * tP4 * tP4 * tP4;

        dP4 =
            d[0] +
            d[1] * tP4 +
            d[2] * tP4 * tP4 +
            d[3] * tP4 * tP4 * tP4 +
            d[4] * tP4 * tP4 * tP4 * tP4;

        muP4 =
            mu[0] +
            mu[1] * tP4 +
            mu[2] * tP4 * tP4 +
            mu[3] * tP4 * tP4 * tP4 +
            mu[4] * tP4 * tP4 * tP4 * tP4;

        xpP4 =
            x[1] +
            2 * x[2] * tP4 +
            3 * x[3] * tP4 * tP4 +
            4 * x[4] * tP4 * tP4 * tP4;

        ypP4 =
            y[1] +
            2 * y[2] * tP4 +
            3 * y[3] * tP4 * tP4 +
            4 * y[4] * tP4 * tP4 * tP4;

        l1P4 =
            l1[0] +
            l1[1] * tP4 +
            l1[2] * tP4 * tP4 +
            l1[3] * tP4 * tP4 * tP4 +
            l1[4] * tP4 * tP4 * tP4 * tP4;

        omP4 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(
            1.0 - e2 * math.cos(mf.rad(dP4)) * math.cos(mf.rad(dP4)),
          ),
        );

        msP4 = SafeMath.sqrt(xP4 * xP4 + yP4 * yP4);

        y1P4 = yP4 * omP4;

        m1P4 = SafeMath.sqrt(xP4 * xP4 + y1P4 * y1P4);

        roP4 = SafeMath.safeDiv(msP4, m1P4);

        n2P4 = xpP4 * xpP4 + ypP4 * ypP4;

        nsP4 = SafeMath.sqrt(n2P4);

        psP4 = SafeMath.asin(
          SafeMath.safeDiv((xP4 * ypP4 - xpP4 * yP4), (nsP4 * (l1P4 + roP4))),
        );

        tuP4 =
            SafeMath.safeDiv((l1P4 + roP4), nsP4) * math.cos(psP4) -
            SafeMath.safeDiv((xP4 * xpP4 + yP4 * ypP4), (nsP4 * nsP4));

        tP4 = tP4 + tuP4;
      }

      double p4TD = mf.mod(t0 + tP4, 24.0);
      double p4UT = mf.mod(p4TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak P4

      double d1P4 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dP4)), (math.cos(mf.rad(dP4)) * ba)),
        ),
      );

      double rhP4 = SafeMath.sqrt(
        math.sin(mf.rad(dP4)) * math.sin(mf.rad(dP4)) +
            (math.cos(mf.rad(dP4)) * ba) * (math.cos(mf.rad(dP4)) * ba),
      );

      double yIP4 = SafeMath.safeDiv(yP4, rhP4);

      double mIP4 = SafeMath.sqrt(xP4 * xP4 + yIP4 * yIP4);

      double x1P4 = SafeMath.safeDiv(xP4, mIP4);
      double y2P4 = SafeMath.safeDiv(yIP4, mIP4);

      double pi1P4 = mf.deg(SafeMath.asin(y2P4 * math.cos(mf.rad(d1P4))));

      piP4 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P4))));

      double x2P4 = -y2P4 * math.sin(mf.rad(dP4));

      double haP4 = mf.mod(mf.deg(math.atan2(x1P4, x2P4)), 360.0);

      double caP4 = haP4 - muP4 + (0.004178 * dt);

      ldP4;

      if (caP4 > 180.0) {
        ldP4 = caP4 - 360.0;
      } else if (caP4 < -180.0) {
        ldP4 = caP4 + 360.0;
      } else {
        ldP4 = caP4;
      }

      // Azimuth dan Altitude saat kontak P4

      altP4 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piP4)) * math.sin(mf.rad(dP4)) +
              math.cos(mf.rad(piP4)) *
                  math.cos(mf.rad(dP4)) *
                  math.cos(mf.rad(haP4)),
        ),
      );

      azmP4 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haP4)),
                math.cos(mf.rad(haP4)) * math.sin(mf.rad(piP4)) -
                    math.tan(mf.rad(dP4)) * math.cos(mf.rad(piP4)),
              ),
            ) +
            180.0,
        360.0,
      );

      //Waktu Kontak P4

      jdSolarEclipseP4TD = mf.floor(jde2 - 0.5) + 0.5 + p4TD / 24.0;
      jdSolarEclipseP4UT = mf.floor(jde2 - 0.5) + 0.5 + p4UT / 24.0;

      //KONTAK P2 & P3
      // ===============================
      // Penumbral First Internal Contact (P2)
      // ===============================

      double xP2 = 0.0;
      double yP2 = 0.0;
      double dP2 = 0.0;
      double muP2 = 0.0;
      double xpP2 = 0.0;
      double ypP2 = 0.0;
      double l1P2 = 0.0;
      double omP2 = 0.0;
      double msP2 = 0.0;
      double y1P2 = 0.0;
      double m1P2 = 0.0;
      double roP2 = 0.0;
      double n2P2 = 0.0;
      double nsP2 = 0.0;
      double psP2 = 0.0;

      double tuP2 = 0.0;
      double tP2 = 0.0;

      tP2 += tuP2;

      for (int i = 1; i <= 5; i++) {
        xP2 =
            x[0] +
            x[1] * tP2 +
            x[2] * tP2 * tP2 +
            x[3] * tP2 * tP2 * tP2 +
            x[4] * tP2 * tP2 * tP2 * tP2;

        yP2 =
            y[0] +
            y[1] * tP2 +
            y[2] * tP2 * tP2 +
            y[3] * tP2 * tP2 * tP2 +
            y[4] * tP2 * tP2 * tP2 * tP2;

        dP2 =
            d[0] +
            d[1] * tP2 +
            d[2] * tP2 * tP2 +
            d[3] * tP2 * tP2 * tP2 +
            d[4] * tP2 * tP2 * tP2 * tP2;

        muP2 =
            mu[0] +
            mu[1] * tP2 +
            mu[2] * tP2 * tP2 +
            mu[3] * tP2 * tP2 * tP2 +
            mu[4] * tP2 * tP2 * tP2 * tP2;

        xpP2 =
            x[1] +
            2 * x[2] * tP2 +
            3 * x[3] * tP2 * tP2 +
            4 * x[4] * tP2 * tP2 * tP2;

        ypP2 =
            y[1] +
            2 * y[2] * tP2 +
            3 * y[3] * tP2 * tP2 +
            4 * y[4] * tP2 * tP2 * tP2;

        l1P2 =
            l1[0] +
            l1[1] * tP2 +
            l1[2] * tP2 * tP2 +
            l1[3] * tP2 * tP2 * tP2 +
            l1[4] * tP2 * tP2 * tP2 * tP2;

        omP2 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(
            1.0 - e2 * math.cos(mf.rad(dP2)) * math.cos(mf.rad(dP2)),
          ),
        );

        msP2 = SafeMath.sqrt(xP2 * xP2 + yP2 * yP2);

        y1P2 = yP2 * omP2;

        m1P2 = SafeMath.sqrt(xP2 * xP2 + y1P2 * y1P2);

        roP2 = SafeMath.safeDiv(msP2, m1P2);

        n2P2 = xpP2 * xpP2 + ypP2 * ypP2;

        nsP2 = SafeMath.sqrt(n2P2);

        psP2 = SafeMath.asin(
          SafeMath.safeDiv((xP2 * ypP2 - xpP2 * yP2), (nsP2 * (l1P2 - roP2))),
        );

        tuP2 =
            (SafeMath.safeDiv((roP2 - l1P2), nsP2)) * -math.cos(psP2) -
            SafeMath.safeDiv((xP2 * xpP2 + yP2 * ypP2), (nsP2 * nsP2));

        tP2 = tP2 + tuP2;
      }

      double p2TD = mf.mod(t0 + tP2, 24.0);

      double p2UT = mf.mod(p2TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak P2

      double d1P2 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dP2)), (math.cos(mf.rad(dP2)) * ba)),
        ),
      );

      double rhP2 = SafeMath.sqrt(
        math.sin(mf.rad(dP2)) * math.sin(mf.rad(dP2)) +
            (math.cos(mf.rad(dP2)) * ba) * (math.cos(mf.rad(dP2)) * ba),
      );

      double yIP2 = SafeMath.safeDiv(yP2, rhP2);

      double mIP2 = SafeMath.sqrt(xP2 * xP2 + yIP2 * yIP2);

      double x1P2 = SafeMath.safeDiv(xP2, mIP2);

      double y2P2 = SafeMath.safeDiv(yIP2, mIP2);

      double pi1P2 = mf.deg(SafeMath.asin(y2P2 * math.cos(mf.rad(d1P2))));

      piP2 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P2))));

      double x2P2 = -y2P2 * math.sin(mf.rad(dP2));

      double haP2 = mf.mod(mf.deg(math.atan2(x1P2, x2P2)), 360.0);

      double caP2 = haP2 - muP2 + (0.004178 * dt);

      if (caP2 > 180.0) {
        ldP2 = caP2 - 360.0;
      } else if (caP2 < -180.0) {
        ldP2 = caP2 + 360.0;
      } else {
        ldP2 = caP2;
      }

      // Azimuth dan Altitude saat kontak P2

      altP2 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piP2)) * math.sin(mf.rad(dP2)) +
              math.cos(mf.rad(piP2)) *
                  math.cos(mf.rad(dP2)) *
                  math.cos(mf.rad(haP2)),
        ),
      );

      azmP2 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haP2)),
                math.cos(mf.rad(haP2)) * math.sin(mf.rad(piP2)) -
                    math.tan(mf.rad(dP2)) * math.cos(mf.rad(piP2)),
              ),
            ) +
            180.0,
        360.0,
      );

      //Waktu Kontak P2

      jdSolarEclipseP2TD = mf.floor(jde2 - 0.5) + 0.5 + p2TD / 24.0;

      jdSolarEclipseP2UT = mf.floor(jde2 - 0.5) + 0.5 + p2UT / 24.0;

      // ===============================
      // Penumbral Last Internal Contact (P3)
      // ===============================

      double xP3 = 0.0;
      double yP3 = 0.0;
      double dP3 = 0.0;
      double muP3 = 0.0;
      double xpP3 = 0.0;
      double ypP3 = 0.0;
      double l1P3 = 0.0;
      double omP3 = 0.0;
      double msP3 = 0.0;
      double y1P3 = 0.0;
      double m1P3 = 0.0;
      double roP3 = 0.0;
      double n2P3 = 0.0;
      double nsP3 = 0.0;
      double psP3 = 0.0;

      double tuP3 = 0.0;
      double tP3 = 0.0;

      tP3 += tuP3;

      for (int i = 1; i <= 5; i++) {
        xP3 =
            x[0] +
            x[1] * tP3 +
            x[2] * tP3 * tP3 +
            x[3] * tP3 * tP3 * tP3 +
            x[4] * tP3 * tP3 * tP3 * tP3;

        yP3 =
            y[0] +
            y[1] * tP3 +
            y[2] * tP3 * tP3 +
            y[3] * tP3 * tP3 * tP3 +
            y[4] * tP3 * tP3 * tP3 * tP3;

        dP3 =
            d[0] +
            d[1] * tP3 +
            d[2] * tP3 * tP3 +
            d[3] * tP3 * tP3 * tP3 +
            d[4] * tP3 * tP3 * tP3 * tP3;

        muP3 =
            mu[0] +
            mu[1] * tP3 +
            mu[2] * tP3 * tP3 +
            mu[3] * tP3 * tP3 * tP3 +
            mu[4] * tP3 * tP3 * tP3 * tP3;

        xpP3 =
            x[1] +
            2 * x[2] * tP3 +
            3 * x[3] * tP3 * tP3 +
            4 * x[4] * tP3 * tP3 * tP3;

        ypP3 =
            y[1] +
            2 * y[2] * tP3 +
            3 * y[3] * tP3 * tP3 +
            4 * y[4] * tP3 * tP3 * tP3;

        l1P3 =
            l1[0] +
            l1[1] * tP3 +
            l1[2] * tP3 * tP3 +
            l1[3] * tP3 * tP3 * tP3 +
            l1[4] * tP3 * tP3 * tP3 * tP3;

        omP3 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dP3)) * math.cos(mf.rad(dP3))),
        );

        msP3 = SafeMath.sqrt(xP3 * xP3 + yP3 * yP3);

        y1P3 = yP3 * omP3;
        m1P3 = SafeMath.sqrt(xP3 * xP3 + y1P3 * y1P3);

        roP3 = SafeMath.safeDiv(msP3, m1P3);

        n2P3 = xpP3 * xpP3 + ypP3 * ypP3;
        nsP3 = SafeMath.sqrt(n2P3);

        psP3 = SafeMath.asin(
          SafeMath.safeDiv((xP3 * ypP3 - xpP3 * yP3), (nsP3 * (l1P3 - roP3))),
        );

        tuP3 =
            SafeMath.safeDiv((roP3 - l1P3), nsP3) * math.cos(psP3) -
            SafeMath.safeDiv((xP3 * xpP3 + yP3 * ypP3), (nsP3 * nsP3));

        tP3 = tP3 + tuP3;
      }

      // ===============================
      // Waktu P3
      // ===============================

      double p3TD = mf.mod(t0 + tP3, 24.0);
      double p3UT = mf.mod(p3TD - dt / 3600.0, 24.0);

      // ===============================
      // Koordinat saat kontak P3
      // ===============================

      double d1P3 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dP3)), (math.cos(mf.rad(dP3)) * ba)),
        ),
      );

      double rhP3 = SafeMath.sqrt(
        math.sin(mf.rad(dP3)) * math.sin(mf.rad(dP3)) +
            (math.cos(mf.rad(dP3)) * ba) * (math.cos(mf.rad(dP3)) * ba),
      );

      double yIP3 = SafeMath.safeDiv(yP3, rhP3);

      double mIP3 = SafeMath.sqrt(xP3 * xP3 + yIP3 * yIP3);

      double x1P3 = SafeMath.safeDiv(xP3, mIP3);
      double y2P3 = SafeMath.safeDiv(yIP3, mIP3);

      double pi1P3 = mf.deg(SafeMath.asin(y2P3 * math.cos(mf.rad(d1P3))));

      piP3 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P3))));

      double x2P3 = -y2P3 * math.sin(mf.rad(dP3));

      double haP3 = mf.mod(mf.deg(math.atan2(x1P3, x2P3)), 360.0);

      double caP3 = haP3 - muP3 + (0.004178 * dt);

      if (caP3 > 180) {
        ldP3 = caP3 - 360;
      } else if (caP3 < -180) {
        ldP3 = caP3 + 360;
      } else {
        ldP3 = caP3;
      }

      // ===============================
      // Azimuth & Altitude P3
      // ===============================

      altP3 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piP3)) * math.sin(mf.rad(dP3)) +
              math.cos(mf.rad(piP3)) *
                  math.cos(mf.rad(dP3)) *
                  math.cos(mf.rad(haP3)),
        ),
      );

      azmP3 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haP3)),
                math.cos(mf.rad(haP3)) * math.sin(mf.rad(piP3)) -
                    math.tan(mf.rad(dP3)) * math.cos(mf.rad(piP3)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak P3

      jdSolarEclipseP3TD = mf.floor(jde2 - 0.5) + 0.5 + p3TD / 24.0;

      jdSolarEclipseP3UT = mf.floor(jde2 - 0.5) + 0.5 + p3UT / 24.0;

      //KONTAK U1, U2, U3, U4

      // ===============================
      // U1
      // ===============================

      double xU1 = 0.0;
      double yU1 = 0.0;
      double dU1 = 0.0;
      double muU1 = 0.0;
      double xpU1 = 0.0;
      double ypU1 = 0.0;
      double l2U1 = 0.0;
      double omU1 = 0.0;
      double msU1 = 0.0;
      double y1U1 = 0.0;
      double m1U1 = 0.0;
      double roU1 = 0.0;
      double n2U1 = 0.0;
      double nsU1 = 0.0;
      double psU1 = 0.0;

      double tuU1 = 0.0;
      double tU1 = 0.0;

      tU1 += tuU1;

      for (int i = 1; i <= 5; i++) {
        xU1 =
            x[0] +
            x[1] * tU1 +
            x[2] * tU1 * tU1 +
            x[3] * tU1 * tU1 * tU1 +
            x[4] * tU1 * tU1 * tU1 * tU1;
        yU1 =
            y[0] +
            y[1] * tU1 +
            y[2] * tU1 * tU1 +
            y[3] * tU1 * tU1 * tU1 +
            y[4] * tU1 * tU1 * tU1 * tU1;
        dU1 =
            d[0] +
            d[1] * tU1 +
            d[2] * tU1 * tU1 +
            d[3] * tU1 * tU1 * tU1 +
            d[4] * tU1 * tU1 * tU1 * tU1;
        muU1 =
            mu[0] +
            mu[1] * tU1 +
            mu[2] * tU1 * tU1 +
            mu[3] * tU1 * tU1 * tU1 +
            mu[4] * tU1 * tU1 * tU1 * tU1;

        xpU1 =
            x[1] +
            2 * x[2] * tU1 +
            3 * x[3] * tU1 * tU1 +
            4 * x[4] * tU1 * tU1 * tU1;

        ypU1 =
            y[1] +
            2 * y[2] * tU1 +
            3 * y[3] * tU1 * tU1 +
            4 * y[4] * tU1 * tU1 * tU1;

        l2U1 =
            l2[0] +
            l2[1] * tU1 +
            l2[2] * tU1 * tU1 +
            l2[3] * tU1 * tU1 * tU1 +
            l2[4] * tU1 * tU1 * tU1 * tU1;

        omU1 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dU1)) * math.cos(mf.rad(dU1))),
        );
        msU1 = SafeMath.sqrt(xU1 * xU1 + yU1 * yU1);

        y1U1 = yU1 * omU1;
        m1U1 = SafeMath.sqrt(xU1 * xU1 + y1U1 * y1U1);
        roU1 = SafeMath.safeDiv(msU1, m1U1);

        n2U1 = xpU1 * xpU1 + ypU1 * ypU1;
        nsU1 = SafeMath.sqrt(n2U1);

        if (l2U1 < 0.0) {
          psU1 = SafeMath.asin(
            SafeMath.safeDiv((xU1 * ypU1 - xpU1 * yU1), (nsU1 * (l2U1 - roU1))),
          );
          tuU1 =
              SafeMath.safeDiv((roU1 - l2U1), nsU1) * -math.cos(psU1) -
              SafeMath.safeDiv((xU1 * xpU1 + yU1 * ypU1), (nsU1 * nsU1));
        } else {
          psU1 = SafeMath.asin(
            SafeMath.safeDiv((xU1 * ypU1 - xpU1 * yU1), (nsU1 * (l2U1 + roU1))),
          );
          tuU1 =
              SafeMath.safeDiv((roU1 + l2U1), nsU1) * -math.cos(psU1) -
              SafeMath.safeDiv((xU1 * xpU1 + yU1 * ypU1), (nsU1 * nsU1));
        }

        tU1 = tU1 + tuU1;
      }

      // ===============================
      // Waktu U1
      // ===============================

      double u1TD = mf.mod(t0 + tU1, 24.0);
      double u1UT = mf.mod(u1TD - dt / 3600.0, 24.0);

      // ===============================
      // Koordinat saat kontak U1
      // ===============================

      double d1U1 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dU1)), (math.cos(mf.rad(dU1)) * ba)),
        ),
      );

      double rhU1 = SafeMath.sqrt(
        math.sin(mf.rad(dU1)) * math.sin(mf.rad(dU1)) +
            (math.cos(mf.rad(dU1)) * ba) * (math.cos(mf.rad(dU1)) * ba),
      );

      double yIU1 = SafeMath.safeDiv(yU1, rhU1);
      double mIU1 = SafeMath.sqrt(xU1 * xU1 + yIU1 * yIU1);

      double x1U1 = SafeMath.safeDiv(xU1, mIU1);
      double y2U1 = SafeMath.safeDiv(yIU1, mIU1);

      double pi1U1 = mf.deg(SafeMath.asin(y2U1 * math.cos(mf.rad(d1U1))));

      piU1 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U1))));

      double x2U1 = -y2U1 * math.sin(mf.rad(dU1));

      double haU1 = mf.mod(mf.deg(math.atan2(x1U1, x2U1)), 360.0);

      double caU1 = haU1 - muU1 + (0.004178 * dt);

      if (caU1 > 180) {
        ldU1 = caU1 - 360;
      } else if (caU1 < -180) {
        ldU1 = caU1 + 360;
      } else {
        ldU1 = caU1;
      }

      // ===============================
      // Azimuth & Altitude U1
      // ===============================

      altU1 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piU1)) * math.sin(mf.rad(dU1)) +
              math.cos(mf.rad(piU1)) *
                  math.cos(mf.rad(dU1)) *
                  math.cos(mf.rad(haU1)),
        ),
      );

      azmU1 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haU1)),
                math.cos(mf.rad(haU1)) * math.sin(mf.rad(piU1)) -
                    math.tan(mf.rad(dU1)) * math.cos(mf.rad(piU1)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak U1

      jdSolarEclipseU1TD = mf.floor(jde2 - 0.5) + 0.5 + u1TD / 24.0;

      jdSolarEclipseU1UT = mf.floor(jde2 - 0.5) + 0.5 + u1UT / 24.0;

      // ===============================
      // U2
      // ===============================

      double xU2 = 0.0;
      double yU2 = 0.0;
      double dU2 = 0.0;
      double muU2 = 0.0;
      double xpU2 = 0.0;
      double ypU2 = 0.0;
      double l2U2 = 0.0;
      double omU2 = 0.0;
      double msU2 = 0.0;
      double y1U2 = 0.0;
      double m1U2 = 0.0;
      double roU2 = 0.0;
      double n2U2 = 0.0;
      double nsU2 = 0.0;
      double psU2 = 0.0;

      double tuU2 = 0.0;
      double tU2 = 0.0;

      tU2 += tuU2;

      for (int i = 1; i <= 5; i++) {
        xU2 =
            x[0] +
            x[1] * tU2 +
            x[2] * tU2 * tU2 +
            x[3] * tU2 * tU2 * tU2 +
            x[4] * tU2 * tU2 * tU2 * tU2;

        yU2 =
            y[0] +
            y[1] * tU2 +
            y[2] * tU2 * tU2 +
            y[3] * tU2 * tU2 * tU2 +
            y[4] * tU2 * tU2 * tU2 * tU2;

        dU2 =
            d[0] +
            d[1] * tU2 +
            d[2] * tU2 * tU2 +
            d[3] * tU2 * tU2 * tU2 +
            d[4] * tU2 * tU2 * tU2 * tU2;

        muU2 =
            mu[0] +
            mu[1] * tU2 +
            mu[2] * tU2 * tU2 +
            mu[3] * tU2 * tU2 * tU2 +
            mu[4] * tU2 * tU2 * tU2 * tU2;

        xpU2 =
            x[1] +
            2 * x[2] * tU2 +
            3 * x[3] * tU2 * tU2 +
            4 * x[4] * tU2 * tU2 * tU2;

        ypU2 =
            y[1] +
            2 * y[2] * tU2 +
            3 * y[3] * tU2 * tU2 +
            4 * y[4] * tU2 * tU2 * tU2;

        l2U2 =
            l2[0] +
            l2[1] * tU2 +
            l2[2] * tU2 * tU2 +
            l2[3] * tU2 * tU2 * tU2 +
            l2[4] * tU2 * tU2 * tU2 * tU2;

        omU2 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dU2)) * math.cos(mf.rad(dU2))),
        );

        msU2 = SafeMath.sqrt(xU2 * xU2 + yU2 * yU2);

        y1U2 = yU2 * omU2;
        m1U2 = SafeMath.sqrt(xU2 * xU2 + y1U2 * y1U2);
        roU2 = SafeMath.safeDiv(msU2, m1U2);

        n2U2 = xpU2 * xpU2 + ypU2 * ypU2;
        nsU2 = SafeMath.sqrt(n2U2);

        if (l2U2 < 0.0) {
          psU2 = SafeMath.asin(
            SafeMath.safeDiv((xU2 * ypU2 - xpU2 * yU2), (nsU2 * (l2U2 + roU2))),
          );
        } else {
          psU2 = SafeMath.asin(
            SafeMath.safeDiv((xU2 * ypU2 - xpU2 * yU2), (nsU2 * (l2U2 - roU2))),
          );
        }

        if (l2U2 < 0.0) {
          tuU2 =
              SafeMath.safeDiv((roU2 + l2U2), nsU2) * -math.cos(psU2) -
              SafeMath.safeDiv((xU2 * xpU2 + yU2 * ypU2), (nsU2 * nsU2));
        } else {
          tuU2 =
              SafeMath.safeDiv((roU2 - l2U2), nsU2) * -math.cos(psU2) -
              SafeMath.safeDiv((xU2 * xpU2 + yU2 * ypU2), (nsU2 * nsU2));
        }

        tU2 = tU2 + tuU2;
      }

      double u2TD = mf.mod(t0 + tU2, 24.0);
      double u2UT = mf.mod(u2TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak U2

      double d1U2 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dU2)), (math.cos(mf.rad(dU2)) * ba)),
        ),
      );

      double rhU2 = SafeMath.sqrt(
        math.sin(mf.rad(dU2)) * math.sin(mf.rad(dU2)) +
            (math.cos(mf.rad(dU2)) * ba) * (math.cos(mf.rad(dU2)) * ba),
      );

      double yIU2 = SafeMath.safeDiv(yU2, rhU2);
      double mIU2 = SafeMath.sqrt(xU2 * xU2 + yIU2 * yIU2);

      double x1U2 = SafeMath.safeDiv(xU2, mIU2);
      double y2U2 = SafeMath.safeDiv(yIU2, mIU2);

      double pi1U2 = mf.deg(SafeMath.asin(y2U2 * math.cos(mf.rad(d1U2))));

      piU2 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U2))));

      double x2U2 = -y2U2 * math.sin(mf.rad(dU2));

      double haU2 = mf.mod(mf.deg(math.atan2(x1U2, x2U2)), 360.0);

      double caU2 = haU2 - muU2 + (0.004178 * dt);

      if (caU2 > 180) {
        ldU2 = caU2 - 360;
      } else if (caU2 < -180) {
        ldU2 = caU2 + 360;
      } else {
        ldU2 = caU2;
      }

      // Azimuth dan Altitude saat kontak U2

      altU2 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piU2)) * math.sin(mf.rad(dU2)) +
              math.cos(mf.rad(piU2)) *
                  math.cos(mf.rad(dU2)) *
                  math.cos(mf.rad(haU2)),
        ),
      );

      azmU2 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haU2)),
                math.cos(mf.rad(haU2)) * math.sin(mf.rad(piU2)) -
                    math.tan(mf.rad(dU2)) * math.cos(mf.rad(piU2)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak U2

      jdSolarEclipseU2TD = mf.floor(jde2 - 0.5) + 0.5 + u2TD / 24.0;

      jdSolarEclipseU2UT = mf.floor(jde2 - 0.5) + 0.5 + u2UT / 24.0;

      // ===============================
      // U3
      // ===============================

      double xU3 = 0.0;
      double yU3 = 0.0;
      double dU3 = 0.0;
      double muU3 = 0.0;
      double xpU3 = 0.0;
      double ypU3 = 0.0;
      double l2U3 = 0.0;
      double omU3 = 0.0;
      double msU3 = 0.0;
      double y1U3 = 0.0;
      double m1U3 = 0.0;
      double roU3 = 0.0;
      double n2U3 = 0.0;
      double nsU3 = 0.0;
      double psU3 = 0.0;

      double tuU3 = 0.0;
      double tU3 = 0.0;

      tU3 += tuU3;

      for (int i = 1; i <= 5; i++) {
        xU3 =
            x[0] +
            x[1] * tU3 +
            x[2] * tU3 * tU3 +
            x[3] * tU3 * tU3 * tU3 +
            x[4] * tU3 * tU3 * tU3 * tU3;

        yU3 =
            y[0] +
            y[1] * tU3 +
            y[2] * tU3 * tU3 +
            y[3] * tU3 * tU3 * tU3 +
            y[4] * tU3 * tU3 * tU3 * tU3;

        dU3 =
            d[0] +
            d[1] * tU3 +
            d[2] * tU3 * tU3 +
            d[3] * tU3 * tU3 * tU3 +
            d[4] * tU3 * tU3 * tU3 * tU3;

        muU3 =
            mu[0] +
            mu[1] * tU3 +
            mu[2] * tU3 * tU3 +
            mu[3] * tU3 * tU3 * tU3 +
            mu[4] * tU3 * tU3 * tU3 * tU3;

        xpU3 =
            x[1] +
            2 * x[2] * tU3 +
            3 * x[3] * tU3 * tU3 +
            4 * x[4] * tU3 * tU3 * tU3;

        ypU3 =
            y[1] +
            2 * y[2] * tU3 +
            3 * y[3] * tU3 * tU3 +
            4 * y[4] * tU3 * tU3 * tU3;

        l2U3 =
            l2[0] +
            l2[1] * tU3 +
            l2[2] * tU3 * tU3 +
            l2[3] * tU3 * tU3 * tU3 +
            l2[4] * tU3 * tU3 * tU3 * tU3;

        omU3 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dU3)) * math.cos(mf.rad(dU3))),
        );

        msU3 = SafeMath.sqrt(xU3 * xU3 + yU3 * yU3);

        y1U3 = yU3 * omU3;
        m1U3 = SafeMath.sqrt(xU3 * xU3 + y1U3 * y1U3);
        roU3 = SafeMath.safeDiv(msU3, m1U3);

        n2U3 = xpU3 * xpU3 + ypU3 * ypU3;
        nsU3 = SafeMath.sqrt(n2U3);

        if (l2U3 < 0.0) {
          psU3 = SafeMath.asin(
            SafeMath.safeDiv((xU3 * ypU3 - xpU3 * yU3), (nsU3 * (l2U3 + roU3))),
          );
        } else {
          psU3 = SafeMath.asin(
            SafeMath.safeDiv((xU3 * ypU3 - xpU3 * yU3), (nsU3 * (l2U3 - roU3))),
          );
        }

        if (l2U3 < 0.0) {
          tuU3 =
              SafeMath.safeDiv((roU3 + l2U3), nsU3) * math.cos(psU3) -
              SafeMath.safeDiv((xU3 * xpU3 + yU3 * ypU3), (nsU3 * nsU3));
        } else {
          tuU3 =
              SafeMath.safeDiv((roU3 - l2U3), nsU3) * math.cos(psU3) -
              SafeMath.safeDiv((xU3 * xpU3 + yU3 * ypU3), (nsU3 * nsU3));
        }

        tU3 = tU3 + tuU3;
      }

      double u3TD = mf.mod(t0 + tU3, 24.0);
      double u3UT = mf.mod(u3TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak U3

      double d1U3 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dU3)), (math.cos(mf.rad(dU3)) * ba)),
        ),
      );

      double rhU3 = SafeMath.sqrt(
        math.sin(mf.rad(dU3)) * math.sin(mf.rad(dU3)) +
            (math.cos(mf.rad(dU3)) * ba) * (math.cos(mf.rad(dU3)) * ba),
      );

      double yIU3 = SafeMath.safeDiv(yU3, rhU3);
      double mIU3 = SafeMath.sqrt(xU3 * xU3 + yIU3 * yIU3);

      double x1U3 = SafeMath.safeDiv(xU3, mIU3);
      double y2U3 = SafeMath.safeDiv(yIU3, mIU3);

      double pi1U3 = mf.deg(SafeMath.asin(y2U3 * math.cos(mf.rad(d1U3))));

      piU3 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U3))));

      double x2U3 = -y2U3 * math.sin(mf.rad(dU3));

      double haU3 = mf.mod(mf.deg(math.atan2(x1U3, x2U3)), 360.0);

      double caU3 = haU3 - muU3 + (0.004178 * dt);

      if (caU3 > 180) {
        ldU3 = caU3 - 360;
      } else if (caU3 < -180) {
        ldU3 = caU3 + 360;
      } else {
        ldU3 = caU3;
      }

      // Azimuth dan Altitude saat kontak U3

      altU3 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piU3)) * math.sin(mf.rad(dU3)) +
              math.cos(mf.rad(piU3)) *
                  math.cos(mf.rad(dU3)) *
                  math.cos(mf.rad(haU3)),
        ),
      );

      azmU3 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haU3)),
                math.cos(mf.rad(haU3)) * math.sin(mf.rad(piU3)) -
                    math.tan(mf.rad(dU3)) * math.cos(mf.rad(piU3)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak U3

      jdSolarEclipseU3TD = mf.floor(jde2 - 0.5) + 0.5 + u3TD / 24.0;

      jdSolarEclipseU3UT = mf.floor(jde2 - 0.5) + 0.5 + u3UT / 24.0;

      // ===============================
      // U4
      // ===============================

      double xU4 = 0.0;
      double yU4 = 0.0;
      double dU4 = 0.0;
      double muU4 = 0.0;
      double xpU4 = 0.0;
      double ypU4 = 0.0;
      double l2U4 = 0.0;
      double omU4 = 0.0;
      double msU4 = 0.0;
      double y1U4 = 0.0;
      double m1U4 = 0.0;
      double roU4 = 0.0;
      double n2U4 = 0.0;
      double nsU4 = 0.0;
      double psU4 = 0.0;

      double tuU4 = 0.0;
      double tU4 = 0.0;

      tU4 += tuU4;

      for (int i = 1; i <= 5; i++) {
        xU4 =
            x[0] +
            x[1] * tU4 +
            x[2] * tU4 * tU4 +
            x[3] * tU4 * tU4 * tU4 +
            x[4] * tU4 * tU4 * tU4 * tU4;

        yU4 =
            y[0] +
            y[1] * tU4 +
            y[2] * tU4 * tU4 +
            y[3] * tU4 * tU4 * tU4 +
            y[4] * tU4 * tU4 * tU4 * tU4;

        dU4 =
            d[0] +
            d[1] * tU4 +
            d[2] * tU4 * tU4 +
            d[3] * tU4 * tU4 * tU4 +
            d[4] * tU4 * tU4 * tU4 * tU4;

        muU4 =
            mu[0] +
            mu[1] * tU4 +
            mu[2] * tU4 * tU4 +
            mu[3] * tU4 * tU4 * tU4 +
            mu[4] * tU4 * tU4 * tU4 * tU4;

        xpU4 =
            x[1] +
            2 * x[2] * tU4 +
            3 * x[3] * tU4 * tU4 +
            4 * x[4] * tU4 * tU4 * tU4;

        ypU4 =
            y[1] +
            2 * y[2] * tU4 +
            3 * y[3] * tU4 * tU4 +
            4 * y[4] * tU4 * tU4 * tU4;

        l2U4 =
            l2[0] +
            l2[1] * tU4 +
            l2[2] * tU4 * tU4 +
            l2[3] * tU4 * tU4 * tU4 +
            l2[4] * tU4 * tU4 * tU4 * tU4;

        omU4 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dU4)) * math.cos(mf.rad(dU4))),
        );

        msU4 = SafeMath.sqrt(xU4 * xU4 + yU4 * yU4);

        y1U4 = yU4 * omU4;
        m1U4 = SafeMath.sqrt(xU4 * xU4 + y1U4 * y1U4);
        roU4 = SafeMath.safeDiv(msU4, m1U4);

        n2U4 = xpU4 * xpU4 + ypU4 * ypU4;
        nsU4 = SafeMath.sqrt(n2U4);

        if (l2U4 < 0.0) {
          psU4 = SafeMath.asin(
            SafeMath.safeDiv((xU4 * ypU4 - xpU4 * yU4), (nsU4 * (l2U4 - roU4))),
          );
        } else {
          psU4 = SafeMath.asin(
            SafeMath.safeDiv((xU4 * ypU4 - xpU4 * yU4), (nsU4 * (l2U4 + roU4))),
          );
        }

        if (l2U4 < 0.0) {
          tuU4 =
              SafeMath.safeDiv((roU4 - l2U4), nsU4) * math.cos(psU4) -
              SafeMath.safeDiv((xU4 * xpU4 + yU4 * ypU4), (nsU4 * nsU4));
        } else {
          tuU4 =
              SafeMath.safeDiv((roU4 + l2U4), nsU4) * math.cos(psU4) -
              SafeMath.safeDiv((xU4 * xpU4 + yU4 * ypU4), (nsU4 * nsU4));
        }

        tU4 = tU4 + tuU4;
      }

      double u4TD = mf.mod(t0 + tU4, 24.0);
      double u4UT = mf.mod(u4TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak U4

      double d1U4 = mf.deg(
        math.atan(
          SafeMath.safeDiv(
            (math.sin(mf.rad(dU4))),
            (math.cos(mf.rad(dU4)) * ba),
          ),
        ),
      );

      double rhU4 = SafeMath.sqrt(
        math.sin(mf.rad(dU4)) * math.sin(mf.rad(dU4)) +
            (math.cos(mf.rad(dU4)) * ba) * (math.cos(mf.rad(dU4)) * ba),
      );

      double yIU4 = SafeMath.safeDiv(yU4, rhU4);
      double mIU4 = SafeMath.sqrt(xU4 * xU4 + yIU4 * yIU4);

      double x1U4 = SafeMath.safeDiv(xU4, mIU4);
      double y2U4 = SafeMath.safeDiv(yIU4, mIU4);

      double pi1U4 = mf.deg(SafeMath.asin(y2U4 * math.cos(mf.rad(d1U4))));

      piU4 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U4))));

      double x2U4 = -y2U4 * math.sin(mf.rad(dU4));

      double haU4 = mf.mod(mf.deg(math.atan2(x1U4, x2U4)), 360.0);

      double caU4 = haU4 - muU4 + (0.004178 * dt);

      if (caU4 > 180) {
        ldU4 = caU4 - 360;
      } else if (caU4 < -180) {
        ldU4 = caU4 + 360;
      } else {
        ldU4 = caU4;
      }

      // Azimuth dan Altitude saat kontak U4

      altU4 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piU4)) * math.sin(mf.rad(dU4)) +
              math.cos(mf.rad(piU4)) *
                  math.cos(mf.rad(dU4)) *
                  math.cos(mf.rad(haU4)),
        ),
      );

      azmU4 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haU4)),
                math.cos(mf.rad(haU4)) * math.sin(mf.rad(piU4)) -
                    math.tan(mf.rad(dU4)) * math.cos(mf.rad(piU4)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak U4

      jdSolarEclipseU4TD = mf.floor(jde2 - 0.5) + 0.5 + u4TD / 24.0;

      jdSolarEclipseU4UT = mf.floor(jde2 - 0.5) + 0.5 + u4UT / 24.0;

      // ===============================
      // C1
      // ===============================

      double xC1 = 0.0;
      double yC1 = 0.0;
      double dC1 = 0.0;
      double muC1 = 0.0;
      double xpC1 = 0.0;
      double ypC1 = 0.0;
      double omC1 = 0.0;
      double uC1 = 0.0;
      double vC1 = 0.0;
      double aC1 = 0.0;
      double bC1 = 0.0;
      double n2C1 = 0.0;
      double nsC1 = 0.0;
      double psC1 = 0.0;
      double tuC1 = 0.0;
      double tC1 = 0.0;

      tC1 += tuC1;

      for (int i = 1; i <= 5; i++) {
        xC1 =
            x[0] +
            x[1] * tC1 +
            x[2] * tC1 * tC1 +
            x[3] * tC1 * tC1 * tC1 +
            x[4] * tC1 * tC1 * tC1 * tC1;

        yC1 =
            y[0] +
            y[1] * tC1 +
            y[2] * tC1 * tC1 +
            y[3] * tC1 * tC1 * tC1 +
            y[4] * tC1 * tC1 * tC1 * tC1;

        dC1 =
            d[0] +
            d[1] * tC1 +
            d[2] * tC1 * tC1 +
            d[3] * tC1 * tC1 * tC1 +
            d[4] * tC1 * tC1 * tC1 * tC1;

        muC1 =
            mu[0] +
            mu[1] * tC1 +
            mu[2] * tC1 * tC1 +
            mu[3] * tC1 * tC1 * tC1 +
            mu[4] * tC1 * tC1 * tC1 * tC1;

        xpC1 =
            x[1] +
            2 * x[2] * tC1 +
            3 * x[3] * tC1 * tC1 +
            4 * x[4] * tC1 * tC1 * tC1;

        ypC1 =
            y[1] +
            2 * y[2] * tC1 +
            3 * y[3] * tC1 * tC1 +
            4 * y[4] * tC1 * tC1 * tC1;

        omC1 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dC1)) * math.cos(mf.rad(dC1))),
        );

        uC1 = xC1;
        vC1 = yC1 * omC1;
        aC1 = xpC1;
        bC1 = ypC1 * omC1;

        n2C1 = aC1 * aC1 + bC1 * bC1;
        nsC1 = SafeMath.sqrt(n2C1);

        psC1 = SafeMath.safeDiv((aC1 * vC1 - uC1 * bC1), nsC1);

        tuC1 =
            -SafeMath.safeDiv(uC1 * aC1 + vC1 * bC1, n2C1) -
            SafeMath.safeDiv(SafeMath.sqrt(1 - psC1 * psC1), nsC1);

        tC1 = tC1 + tuC1;
      }

      double c1TD = mf.mod(t0 + tC1, 24.0);
      double c1UT = mf.mod(c1TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak C1

      double d1C1 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dC1)), (math.cos(mf.rad(dC1)) * ba)),
        ),
      );

      double rhC1 = SafeMath.sqrt(
        math.sin(mf.rad(dC1)) * math.sin(mf.rad(dC1)) +
            (math.cos(mf.rad(dC1)) * ba) * (math.cos(mf.rad(dC1)) * ba),
      );

      double yIC1 = SafeMath.safeDiv(yC1, rhC1);
      double mIC1 = SafeMath.sqrt(xC1 * xC1 + yIC1 * yIC1);

      double x1C1 = SafeMath.safeDiv(xC1, mIC1);
      double y2C1 = SafeMath.safeDiv(yIC1, mIC1);

      double pi1C1 = mf.deg(SafeMath.asin(y2C1 * math.cos(mf.rad(d1C1))));

      piC1 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1C1))));

      double x2C1 = -y2C1 * math.sin(mf.rad(dC1));

      double haC1 = mf.mod(mf.deg(math.atan2(x1C1, x2C1)), 360.0);

      double caC1 = haC1 - muC1 + (0.004178 * dt);

      if (caC1 > 180) {
        ldC1 = caC1 - 360;
      } else if (caC1 < -180) {
        ldC1 = caC1 + 360;
      } else {
        ldC1 = caC1;
      }

      // Azimuth dan Altitude saat kontak C1

      altC1 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piC1)) * math.sin(mf.rad(dC1)) +
              math.cos(mf.rad(piC1)) *
                  math.cos(mf.rad(dC1)) *
                  math.cos(mf.rad(haC1)),
        ),
      );

      azmC1 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haC1)),
                math.cos(mf.rad(haC1)) * math.sin(mf.rad(piC1)) -
                    math.tan(mf.rad(dC1)) * math.cos(mf.rad(piC1)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak C1

      jdSolarEclipseC1TD = mf.floor(jde2 - 0.5) + 0.5 + c1TD / 24.0;

      jdSolarEclipseC1UT = mf.floor(jde2 - 0.5) + 0.5 + c1UT / 24.0;

      // ===============================
      // C2
      // ===============================

      double xC2 = 0.0;
      double yC2 = 0.0;
      double dC2 = 0.0;
      double muC2 = 0.0;
      double xpC2 = 0.0;
      double ypC2 = 0.0;
      double omC2 = 0.0;
      double uC2 = 0.0;
      double vC2 = 0.0;
      double aC2 = 0.0;
      double bC2 = 0.0;
      double n2C2 = 0.0;
      double nsC2 = 0.0;
      double psC2 = 0.0;
      double tuC2 = 0.0;
      double tC2 = 0.0;

      tC2 += tuC2;

      for (int i = 1; i <= 5; i++) {
        xC2 =
            x[0] +
            x[1] * tC2 +
            x[2] * tC2 * tC2 +
            x[3] * tC2 * tC2 * tC2 +
            x[4] * tC2 * tC2 * tC2 * tC2;

        yC2 =
            y[0] +
            y[1] * tC2 +
            y[2] * tC2 * tC2 +
            y[3] * tC2 * tC2 * tC2 +
            y[4] * tC2 * tC2 * tC2 * tC2;

        dC2 =
            d[0] +
            d[1] * tC2 +
            d[2] * tC2 * tC2 +
            d[3] * tC2 * tC2 * tC2 +
            d[4] * tC2 * tC2 * tC2 * tC2;

        muC2 =
            mu[0] +
            mu[1] * tC2 +
            mu[2] * tC2 * tC2 +
            mu[3] * tC2 * tC2 * tC2 +
            mu[4] * tC2 * tC2 * tC2 * tC2;

        xpC2 =
            x[1] +
            2 * x[2] * tC2 +
            3 * x[3] * tC2 * tC2 +
            4 * x[4] * tC2 * tC2 * tC2;

        ypC2 =
            y[1] +
            2 * y[2] * tC2 +
            3 * y[3] * tC2 * tC2 +
            4 * y[4] * tC2 * tC2 * tC2;

        omC2 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dC2)) * math.cos(mf.rad(dC2))),
        );

        uC2 = xC2;
        vC2 = yC2 * omC2;
        aC2 = xpC2;
        bC2 = ypC2 * omC2;

        n2C2 = aC2 * aC2 + bC2 * bC2;
        nsC2 = SafeMath.sqrt(n2C2);

        psC2 = SafeMath.safeDiv((aC2 * vC2 - uC2 * bC2), nsC2);

        tuC2 =
            SafeMath.safeDiv(-(uC2 * aC2 + vC2 * bC2), n2C2) +
            SafeMath.sqrt(1 - psC2 * psC2) / nsC2;

        tC2 = tC2 + tuC2;
      }

      double c2TD = mf.mod(t0 + tC2, 24.0);
      double c2UT = mf.mod(c2TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak C2

      double d1C2 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dC2)), (math.cos(mf.rad(dC2)) * ba)),
        ),
      );

      double rhC2 = SafeMath.sqrt(
        math.sin(mf.rad(dC2)) * math.sin(mf.rad(dC2)) +
            (math.cos(mf.rad(dC2)) * ba) * (math.cos(mf.rad(dC2)) * ba),
      );

      double yIC2 = SafeMath.safeDiv(yC2, rhC2);

      double mIC2 = SafeMath.sqrt(xC2 * xC2 + yIC2 * yIC2);

      double x1C2 = SafeMath.safeDiv(xC2, mIC2);
      double y2C2 = SafeMath.safeDiv(yIC2, mIC2);

      double pi1C2 = mf.deg(SafeMath.asin(y2C2 * math.cos(mf.rad(d1C2))));

      piC2 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1C2))));

      double x2C2 = -y2C2 * math.sin(mf.rad(dC2));

      double haC2 = mf.mod(mf.deg(math.atan2(x1C2, x2C2)), 360.0);

      double caC2 = haC2 - muC2 + (0.004178 * dt);

      if (caC2 > 180) {
        ldC2 = caC2 - 360;
      } else if (caC2 < -180) {
        ldC2 = caC2 + 360;
      } else {
        ldC2 = caC2;
      }

      // Azimuth dan Altitude saat kontak C2

      altC2 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piC2)) * math.sin(mf.rad(dC2)) +
              math.cos(mf.rad(piC2)) *
                  math.cos(mf.rad(dC2)) *
                  math.cos(mf.rad(haC2)),
        ),
      );

      azmC2 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haC2)),
                math.cos(mf.rad(haC2)) * math.sin(mf.rad(piC2)) -
                    math.tan(mf.rad(dC2)) * math.cos(mf.rad(piC2)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak C2

      jdSolarEclipseC2TD = mf.floor(jde2 - 0.5) + 0.5 + c2TD / 24.0;

      jdSolarEclipseC2UT = mf.floor(jde2 - 0.5) + 0.5 + c2UT / 24.0;
    } else {
      // hanya P1 dan P4

      //KONTAK P1 & P4
      //Penumbral First External Contact (P1)

      double xP1 = 0.0;
      double yP1 = 0.0;
      double dP1 = 0.0;
      double muP1 = 0.0;
      double xpP1 = 0.0;
      double ypP1 = 0.0;
      double l1P1 = 0.0;
      double omP1 = 0.0;
      double msP1 = 0.0;
      double y1P1 = 0.0;
      double m1P1 = 0.0;
      double roP1 = 0.0;
      double n2P1 = 0.0;
      double nsP1 = 0.0;
      double psP1 = 0.0;

      double tuP1 = 0.0;
      double tP1 = 0.0;

      tP1 += tuP1;

      for (int i = 1; i <= 5; i++) {
        xP1 =
            x[0] +
            x[1] * tP1 +
            x[2] * tP1 * tP1 +
            x[3] * tP1 * tP1 * tP1 +
            x[4] * tP1 * tP1 * tP1 * tP1;

        yP1 =
            y[0] +
            y[1] * tP1 +
            y[2] * tP1 * tP1 +
            y[3] * tP1 * tP1 * tP1 +
            y[4] * tP1 * tP1 * tP1 * tP1;

        dP1 =
            d[0] +
            d[1] * tP1 +
            d[2] * tP1 * tP1 +
            d[3] * tP1 * tP1 * tP1 +
            d[4] * tP1 * tP1 * tP1 * tP1;

        muP1 =
            mu[0] +
            mu[1] * tP1 +
            mu[2] * tP1 * tP1 +
            mu[3] * tP1 * tP1 * tP1 +
            mu[4] * tP1 * tP1 * tP1 * tP1;

        xpP1 =
            x[1] +
            2 * x[2] * tP1 +
            3 * x[3] * tP1 * tP1 +
            4 * x[4] * tP1 * tP1 * tP1;

        ypP1 =
            y[1] +
            2 * y[2] * tP1 +
            3 * y[3] * tP1 * tP1 +
            4 * y[4] * tP1 * tP1 * tP1;

        l1P1 =
            l1[0] +
            l1[1] * tP1 +
            l1[2] * tP1 * tP1 +
            l1[3] * tP1 * tP1 * tP1 +
            l1[4] * tP1 * tP1 * tP1 * tP1;

        omP1 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(1 - e2 * math.cos(mf.rad(dP1)) * math.cos(mf.rad(dP1))),
        );

        msP1 = SafeMath.sqrt(xP1 * xP1 + yP1 * yP1);

        y1P1 = yP1 * omP1;
        m1P1 = SafeMath.sqrt(xP1 * xP1 + y1P1 * y1P1);
        roP1 = SafeMath.safeDiv(msP1, m1P1);

        n2P1 = xpP1 * xpP1 + ypP1 * ypP1;
        nsP1 = SafeMath.sqrt(n2P1);

        psP1 = SafeMath.asin(
          SafeMath.safeDiv((xP1 * ypP1 - xpP1 * yP1), (nsP1 * (l1P1 + roP1))),
        );

        tuP1 =
            SafeMath.safeDiv((l1P1 + roP1), nsP1) * -math.cos(psP1) -
            SafeMath.safeDiv((xP1 * xpP1 + yP1 * ypP1), (nsP1 * nsP1));

        tP1 = tP1 + tuP1;
      }

      double p1TD = mf.mod(t0 + tP1, 24.0);
      double p1UT = mf.mod(p1TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak P1
      double d1P1 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dP1)), (math.cos(mf.rad(dP1)) * ba)),
        ),
      );

      double rhP1 = SafeMath.sqrt(
        math.sin(mf.rad(dP1)) * math.sin(mf.rad(dP1)) +
            (math.cos(mf.rad(dP1)) * ba) * (math.cos(mf.rad(dP1)) * ba),
      );

      double yIP1 = SafeMath.safeDiv(yP1, rhP1);
      double mIP1 = SafeMath.sqrt(xP1 * xP1 + yIP1 * yIP1);

      double x1P1 = SafeMath.safeDiv(xP1, mIP1);
      double y2P1 = SafeMath.safeDiv(yIP1, mIP1);

      double pi1P1 = mf.deg(SafeMath.asin(y2P1 * math.cos(mf.rad(d1P1))));

      piP1 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P1))));

      double x2P1 = -y2P1 * math.sin(mf.rad(dP1));

      double haP1 = mf.mod(mf.deg(math.atan2(x1P1, x2P1)), 360.0);

      double caP1 = haP1 - muP1 + (0.004178 * dt);

      ldP1;

      if (caP1 > 180) {
        ldP1 = caP1 - 360;
      } else if (caP1 < -180) {
        ldP1 = caP1 + 360;
      } else {
        ldP1 = caP1;
      }

      // Azimuth dan Altitude
      altP1 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piP1)) * math.sin(mf.rad(dP1)) +
              math.cos(mf.rad(piP1)) *
                  math.cos(mf.rad(dP1)) *
                  math.cos(mf.rad(haP1)),
        ),
      );

      azmP1 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haP1)),
                math.cos(mf.rad(haP1)) * math.sin(mf.rad(piP1)) -
                    math.tan(mf.rad(dP1)) * math.cos(mf.rad(piP1)),
              ),
            ) +
            180,
        360.0,
      );

      //Waktu Kontak P1

      jdSolarEclipseP1TD = mf.floor(jde2 - 0.5) + 0.5 + p1TD / 24.0;
      jdSolarEclipseP1UT = mf.floor(jde2 - 0.5) + 0.5 + p1UT / 24.0;

      // Penumbral Last External Contact (P4)

      double xP4 = 0.0;
      double yP4 = 0.0;
      double dP4 = 0.0;
      double muP4 = 0.0;
      double xpP4 = 0.0;
      double ypP4 = 0.0;
      double l1P4 = 0.0;
      double omP4 = 0.0;
      double msP4 = 0.0;
      double y1P4 = 0.0;
      double m1P4 = 0.0;
      double roP4 = 0.0;
      double n2P4 = 0.0;
      double nsP4 = 0.0;
      double psP4 = 0.0;

      double tuP4 = 0.0;
      double tP4 = 0.0;

      tP4 += tuP4;

      for (int i = 1; i <= 5; i++) {
        xP4 =
            x[0] +
            x[1] * tP4 +
            x[2] * tP4 * tP4 +
            x[3] * tP4 * tP4 * tP4 +
            x[4] * tP4 * tP4 * tP4 * tP4;

        yP4 =
            y[0] +
            y[1] * tP4 +
            y[2] * tP4 * tP4 +
            y[3] * tP4 * tP4 * tP4 +
            y[4] * tP4 * tP4 * tP4 * tP4;

        dP4 =
            d[0] +
            d[1] * tP4 +
            d[2] * tP4 * tP4 +
            d[3] * tP4 * tP4 * tP4 +
            d[4] * tP4 * tP4 * tP4 * tP4;

        muP4 =
            mu[0] +
            mu[1] * tP4 +
            mu[2] * tP4 * tP4 +
            mu[3] * tP4 * tP4 * tP4 +
            mu[4] * tP4 * tP4 * tP4 * tP4;

        xpP4 =
            x[1] +
            2 * x[2] * tP4 +
            3 * x[3] * tP4 * tP4 +
            4 * x[4] * tP4 * tP4 * tP4;

        ypP4 =
            y[1] +
            2 * y[2] * tP4 +
            3 * y[3] * tP4 * tP4 +
            4 * y[4] * tP4 * tP4 * tP4;

        l1P4 =
            l1[0] +
            l1[1] * tP4 +
            l1[2] * tP4 * tP4 +
            l1[3] * tP4 * tP4 * tP4 +
            l1[4] * tP4 * tP4 * tP4 * tP4;

        omP4 = SafeMath.safeDiv(
          1.0,
          SafeMath.sqrt(
            1.0 - e2 * math.cos(mf.rad(dP4)) * math.cos(mf.rad(dP4)),
          ),
        );

        msP4 = SafeMath.sqrt(xP4 * xP4 + yP4 * yP4);

        y1P4 = yP4 * omP4;

        m1P4 = SafeMath.sqrt(xP4 * xP4 + y1P4 * y1P4);

        roP4 = SafeMath.safeDiv(msP4, m1P4);

        n2P4 = xpP4 * xpP4 + ypP4 * ypP4;

        nsP4 = SafeMath.sqrt(n2P4);

        psP4 = SafeMath.asin(
          SafeMath.safeDiv((xP4 * ypP4 - xpP4 * yP4), (nsP4 * (l1P4 + roP4))),
        );

        tuP4 =
            SafeMath.safeDiv((l1P4 + roP4), nsP4) * math.cos(psP4) -
            SafeMath.safeDiv((xP4 * xpP4 + yP4 * ypP4), (nsP4 * nsP4));

        tP4 = tP4 + tuP4;
      }

      double p4TD = mf.mod(t0 + tP4, 24.0);
      double p4UT = mf.mod(p4TD - dt / 3600.0, 24.0);

      // Koordinat saat kontak P4

      double d1P4 = mf.deg(
        math.atan(
          SafeMath.safeDiv(math.sin(mf.rad(dP4)), (math.cos(mf.rad(dP4)) * ba)),
        ),
      );

      double rhP4 = SafeMath.sqrt(
        math.sin(mf.rad(dP4)) * math.sin(mf.rad(dP4)) +
            (math.cos(mf.rad(dP4)) * ba) * (math.cos(mf.rad(dP4)) * ba),
      );

      double yIP4 = SafeMath.safeDiv(yP4, rhP4);

      double mIP4 = SafeMath.sqrt(xP4 * xP4 + yIP4 * yIP4);

      double x1P4 = SafeMath.safeDiv(xP4, mIP4);
      double y2P4 = SafeMath.safeDiv(yIP4, mIP4);

      double pi1P4 = mf.deg(SafeMath.asin(y2P4 * math.cos(mf.rad(d1P4))));

      piP4 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P4))));

      double x2P4 = -y2P4 * math.sin(mf.rad(dP4));

      double haP4 = mf.mod(mf.deg(math.atan2(x1P4, x2P4)), 360.0);

      double caP4 = haP4 - muP4 + (0.004178 * dt);

      ldP4;

      if (caP4 > 180.0) {
        ldP4 = caP4 - 360.0;
      } else if (caP4 < -180.0) {
        ldP4 = caP4 + 360.0;
      } else {
        ldP4 = caP4;
      }

      // Azimuth dan Altitude saat kontak P4

      altP4 = mf.deg(
        SafeMath.asin(
          math.sin(mf.rad(piP4)) * math.sin(mf.rad(dP4)) +
              math.cos(mf.rad(piP4)) *
                  math.cos(mf.rad(dP4)) *
                  math.cos(mf.rad(haP4)),
        ),
      );

      azmP4 = mf.mod(
        mf.deg(
              math.atan2(
                math.sin(mf.rad(haP4)),
                math.cos(mf.rad(haP4)) * math.sin(mf.rad(piP4)) -
                    math.tan(mf.rad(dP4)) * math.cos(mf.rad(piP4)),
              ),
            ) +
            180.0,
        360.0,
      );

      //Waktu Kontak P4

      jdSolarEclipseP4TD = mf.floor(jde2 - 0.5) + 0.5 + p4TD / 24.0;
      jdSolarEclipseP4UT = mf.floor(jde2 - 0.5) + 0.5 + p4UT / 24.0;
    }

    //Durasi keseluruhan Gerhana
    final double dur2 = 0;

    //KESIMPULAN

    return SolarEclipseGlobalResult(
      ada: true,
      keterangan: "Ada gerhana",

      besselian: bessel,

      p1: EclipseContactGlobal(
        jd: jdSolarEclipseP1TD,
        jd2: jdSolarEclipseP1UT,
        longitude: ldP1,
        latitude: piP1,
        azimuth: azmP1,
        altitude: altP1,
      ),
      u1: EclipseContactGlobal(
        jd: jdSolarEclipseU1TD,
        jd2: jdSolarEclipseU1UT,
        longitude: ldU1,
        latitude: piU1,
        azimuth: azmU1,
        altitude: altU1,
      ),
      c1: EclipseContactGlobal(
        jd: jdSolarEclipseC1TD,
        jd2: jdSolarEclipseC1UT,
        longitude: ldC1,
        latitude: piC1,
        azimuth: azmC1,
        altitude: altC1,
      ),
      u2: EclipseContactGlobal(
        jd: jdSolarEclipseU2TD,
        jd2: jdSolarEclipseU2UT,
        longitude: ldU2,
        latitude: piU2,
        azimuth: azmU2,
        altitude: altU2,
      ),
      p2: EclipseContactGlobal(
        jd: jdSolarEclipseP2TD,
        jd2: jdSolarEclipseP2UT,
        longitude: ldP2,
        latitude: piP2,
        azimuth: azmP2,
        altitude: altP2,
      ),
      mx: EclipseContactGlobal(
        jd: jdSolarEclipseMxTD,
        jd2: jdSolarEclipseMxUT,
        longitude: ldMx,
        latitude: piMx,
        azimuth: azmMx,
        altitude: altMx,
      ),
      p3: EclipseContactGlobal(
        jd: jdSolarEclipseP3TD,
        jd2: jdSolarEclipseP3UT,
        longitude: ldP3,
        latitude: piP3,
        azimuth: azmP3,
        altitude: altP3,
      ),
      u3: EclipseContactGlobal(
        jd: jdSolarEclipseU3TD,
        jd2: jdSolarEclipseU3UT,
        longitude: ldU3,
        latitude: piU3,
        azimuth: azmU3,
        altitude: altU3,
      ),
      c2: EclipseContactGlobal(
        jd: jdSolarEclipseC2TD,
        jd2: jdSolarEclipseC2UT,
        longitude: ldC2,
        latitude: piC2,
        azimuth: azmC2,
        altitude: altC2,
      ),
      u4: EclipseContactGlobal(
        jd: jdSolarEclipseU4TD,
        jd2: jdSolarEclipseU4UT,
        longitude: ldU4,
        latitude: piU4,
        azimuth: azmU4,
        altitude: altU4,
      ),
      p4: EclipseContactGlobal(
        jd: jdSolarEclipseP4TD,
        jd2: jdSolarEclipseP4UT,
        longitude: ldP4,
        latitude: piP4,
        azimuth: azmP4,
        altitude: altP4,
      ),

      ephemerisMaximum: EclipseEphemerisGlobal(
        sun: EclipseEphemerisBodyGlobal(
          ra: raS / 15,
          dec: dcS,
          sd: sdS,
          hp: hpS,
        ),
        moon: EclipseEphemerisBodyGlobal(
          ra: raM / 15,
          dec: dcM,
          sd: sdM,
          hp: hpM,
        ),
      ),

      magnitude: mag,
      jenis: jse,
      durasiGerhana: dur,
      durasiTotalitas: dur2,
      lebar: wd,
    );
  }

  List<SolarEclipseGlobalSummary> solarEclipseGlobalRangeHijri({
    required int tahunAwalH,
    required int tahunAkhirH,
    required TimeScale timeScale,
  }) {
    final List<SolarEclipseGlobalSummary> hasil = [];

    for (int thn = tahunAwalH; thn <= tahunAkhirH; thn++) {
      for (int bln = 1; bln <= 12; bln++) {
        final eclipse = solarEclipseGlobal(blnH: bln, thnH: thn);

        if (eclipse == null || eclipse.ada != true) continue;

        double? p1;
        double? max;
        double? p4;

        if (timeScale == TimeScale.jdTD) {
          p1 = eclipse.p1?.jd;
          max = eclipse.mx?.jd;
          p4 = eclipse.p4?.jd;
        } else {
          p1 = eclipse.p1?.jd2;
          max = eclipse.mx?.jd2;
          p4 = eclipse.p4?.jd2;
        }

        hasil.add(
          SolarEclipseGlobalSummary(
            tahunHijri: thn,
            bulanHijri: bln,
            p1: p1,
            max: max,
            p4: p4,
            durasi: eclipse.durasiGerhana,
            jenis: eclipse.jenis ?? "",
          ),
        );
      }
    }

    return hasil;
  }

  List<SolarEclipseLocalSummary> solarEclipseLocalRangeHijri({
    required int tahunAwalH,
    required int tahunAkhirH,
    required double gLon,
    required double gLat,
    required double elev,
    required double pres,
    required double temp,
    required double tmZn,
    required TimeScale timeScale,
  }) {
    final List<SolarEclipseLocalSummary> hasil = [];

    for (int thn = tahunAwalH; thn <= tahunAkhirH; thn++) {
      for (int bln = 1; bln <= 12; bln++) {
        final eclipse = solarEclipseLocal(
          blnH: bln,
          thnH: thn,
          gLon: gLon,
          gLat: gLat,
          elev: elev,
          pres: pres,
          temp: temp,
          tmZn: tmZn,
        );

        if (eclipse == null || eclipse.ada != true) continue;

        // ============================
        // Tentukan JD sesuai TimeScale
        // ============================

        double? convert(double? jd) {
          if (jd == null) return null;

          switch (timeScale) {
            case TimeScale.jdTD:
              return jd; // sudah TD
            case TimeScale.jdUT:
              return jd - (eclipse.deltaT ?? 0) / 86400.0;
          }
        }

        final u1 = convert(eclipse.u1?.jd);
        final u2 = convert(eclipse.u2?.jd);
        final max = convert(eclipse.mx?.jd);
        final u3 = convert(eclipse.u3?.jd);
        final u4 = convert(eclipse.u4?.jd);

        hasil.add(
          SolarEclipseLocalSummary(
            tahunHijri: thn,
            bulanHijri: bln,
            u1: u1,
            u2: u2,
            mx: max,
            u3: u3,
            u4: u4,

            // altitude TIDAK ikut timeScale
            altU1: eclipse.u1?.altitude,
            altU2: eclipse.u2?.altitude,
            altMx: eclipse.mx?.altitude,
            altU3: eclipse.u3?.altitude,
            altU4: eclipse.u4?.altitude,

            durasiTotal: eclipse.durasiTotalitas,
            durasiGerhana: eclipse.durasiGerhana,
            jenis: eclipse.jenis ?? "",
          ),
        );
      }
    }

    return hasil;
  }
}
