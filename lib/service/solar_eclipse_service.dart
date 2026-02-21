import 'dart:math' as math;
import 'package:myhisab/core/dynamical_time.dart';
import 'package:myhisab/core/julian_day.dart';
import 'package:myhisab/core/math_utils.dart';
import 'package:myhisab/core/moon_distance.dart';
import 'package:myhisab/core/moon_function.dart';
import 'package:myhisab/core/sun_function.dart';

final julianDay = JulianDay();
final dynamicalTime = DynamicalTime();

final sn = SunFunction();
final mf = MathFunction();
final mo = MoonFunction();
final md = MoonDistance();

class SolarEclipseService {
  double sBesselian(int hijriMonth, int hijriYear, String optResult) {
    final jdeSolarEclipse1 = mo.jdeEclipseModified(hijriMonth, hijriYear, 1);

    if (jdeSolarEclipse1 <= 0) return double.nan;

    final jdeSolarEclipse2 =
        mf.floor(jdeSolarEclipse1) +
        (((jdeSolarEclipse1 - mf.floor(jdeSolarEclipse1)) * 24).round()) / 24.0;

    final t0 = mf.mod(
      (((jdeSolarEclipse2 - mf.floor(jdeSolarEclipse2)) * 24).round())
          .toDouble(),
      24.0,
    );

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

    final ghaSm2 = sn.sunGeocentricGreenwichHourAngle(
      jdeSolarEclipse2 - 2 / 24,
      0,
    );
    final ghaSm1 = sn.sunGeocentricGreenwichHourAngle(
      jdeSolarEclipse2 - 1 / 24,
      0,
    );
    final ghaS00 = sn.sunGeocentricGreenwichHourAngle(jdeSolarEclipse2, 0);
    final ghaSp1 = sn.sunGeocentricGreenwichHourAngle(
      jdeSolarEclipse2 + 1 / 24,
      0,
    );
    final ghaSp2 = sn.sunGeocentricGreenwichHourAngle(
      jdeSolarEclipse2 + 2 / 24,
      0,
    );

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

    final rMm2 = md.moonGeocentricDistance(jdeSolarEclipse2 - 2 / 24, 0, "AU");
    final rMm1 = md.moonGeocentricDistance(jdeSolarEclipse2 - 1 / 24, 0, "AU");
    final rM00 = md.moonGeocentricDistance(jdeSolarEclipse2, 0, "AU");
    final rMp1 = md.moonGeocentricDistance(jdeSolarEclipse2 + 1 / 24, 0, "AU");
    final rMp2 = md.moonGeocentricDistance(jdeSolarEclipse2 + 2 / 24, 0, "AU");

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

    switch (optResult) {
      case "JDS":
        return jdeSolarEclipse2;

      case "DT":
        return deltaT;

      // x
      case "x0":
        return mf.interp5(xm2, xm1, x00, xp1, xp2, 0);
      case "x1":
        return mf.interp5(xm2, xm1, x00, xp1, xp2, 1);
      case "x2":
        return mf.interp5(xm2, xm1, x00, xp1, xp2, 2);
      case "x3":
        return mf.interp5(xm2, xm1, x00, xp1, xp2, 3);
      case "x4":
        return mf.interp5(xm2, xm1, x00, xp1, xp2, 4);

      // y
      case "y0":
        return mf.interp5(ym2, ym1, y00, yp1, yp2, 0);
      case "y1":
        return mf.interp5(ym2, ym1, y00, yp1, yp2, 1);
      case "y2":
        return mf.interp5(ym2, ym1, y00, yp1, yp2, 2);
      case "y3":
        return mf.interp5(ym2, ym1, y00, yp1, yp2, 3);
      case "y4":
        return mf.interp5(ym2, ym1, y00, yp1, yp2, 4);

      // d
      case "d0":
        return mf.interp5(dm2, dm1, d00, dp1, dp2, 0);
      case "d1":
        return mf.interp5(dm2, dm1, d00, dp1, dp2, 1);
      case "d2":
        return mf.interp5(dm2, dm1, d00, dp1, dp2, 2);
      case "d3":
        return mf.interp5(dm2, dm1, d00, dp1, dp2, 3);
      case "d4":
        return mf.interp5(dm2, dm1, d00, dp1, dp2, 4);

      // l1
      case "l10":
        return mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 0);
      case "l11":
        return mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 1);
      case "l12":
        return mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 2);
      case "l13":
        return mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 3);
      case "l14":
        return mf.interp5(l1m2, l1m1, l100, l1p1, l1p2, 4);

      // l2
      case "l20":
        return mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 0);
      case "l21":
        return mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 1);
      case "l22":
        return mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 2);
      case "l23":
        return mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 3);
      case "l24":
        return mf.interp5(l2m2, l2m1, l200, l2p1, l2p2, 4);

      // mu
      case "mu0":
        return mf.interp5(mum2, mum1, mu00, mup1, mup2, 0);
      case "mu1":
        return mf.interp5(mum2, mum1, mu00, mup1, mup2, 1);
      case "mu2":
        return mf.interp5(mum2, mum1, mu00, mup1, mup2, 2);
      case "mu3":
        return mf.interp5(mum2, mum1, mu00, mup1, mup2, 3);
      case "mu4":
        return mf.interp5(mum2, mum1, mu00, mup1, mup2, 4);

      // f1,f2
      case "f1":
        return tanf100;
      case "f2":
        return tanf200;

      // SUN raw
      case "dSm2":
        return dSm2;
      case "dSm1":
        return dSm1;
      case "dS00":
        return dS00;
      case "dSp1":
        return dSp1;
      case "dSp2":
        return dSp2;

      case "arSm2":
        return arSm2;
      case "arSm1":
        return arSm1;
      case "arS00":
        return arS00;
      case "arSp1":
        return arSp1;
      case "arSp2":
        return arSp2;

      case "rSm2":
        return rSm2;
      case "rSm1":
        return rSm1;
      case "rS00":
        return rS00;
      case "rSp1":
        return rSp1;
      case "rSp2":
        return rSp2;

      case "ghaSm2":
        return ghaSm2;
      case "ghaSm1":
        return ghaSm1;
      case "ghaS00":
        return ghaS00;
      case "ghaSp1":
        return ghaSp1;
      case "ghaSp2":
        return ghaSp2;

      // MOON raw
      case "dMm2":
        return dMm2;
      case "dMm1":
        return dMm1;
      case "dM00":
        return dM00;
      case "dMp1":
        return dMp1;
      case "dMp2":
        return dMp2;

      case "arMm2":
        return arMm2;
      case "arMm1":
        return arMm1;
      case "arM00":
        return arM00;
      case "arMp1":
        return arMp1;
      case "arMp2":
        return arMp2;

      case "rMm2":
        return rMm2;
      case "rMm1":
        return rMm1;
      case "rM00":
        return rM00;
      case "rMp1":
        return rMp1;
      case "rMp2":
        return rMp2;

      case "hpMm2":
        return hpMm2;
      case "hpMm1":
        return hpMm1;
      case "hpM00":
        return hpM00;
      case "hpMp1":
        return hpMp1;
      case "hpMp2":
        return hpMp2;

      case "bm2":
        return bm2;
      case "bm1":
        return bm1;
      case "b00":
        return b00;
      case "bp1":
        return bp1;
      case "bp2":
        return bp2;

      case "g1m2":
        return g1m2;
      case "g1m1":
        return g1m1;
      case "g100":
        return g100;
      case "g1p1":
        return g1p1;
      case "g1p2":
        return g1p2;

      case "g2m2":
        return g2m2;
      case "g2m1":
        return g2m1;
      case "g200":
        return g200;
      case "g2p1":
        return g2p1;
      case "g2p2":
        return g2p2;

      case "g3m2":
        return g3m2;
      case "g3m1":
        return g3m1;
      case "g300":
        return g300;
      case "g3p1":
        return g3p1;
      case "g3p2":
        return g3p2;

      default:
        return mf.mod(t0 + 12, 24.0);
    }
  }

  Map<String, dynamic> solarEclipseLocal({
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
    final jdEclipse2 = sBesselian(blnH, thnH, "JDS");

    if (jdEclipse2.isNaN) {
      return {"ADA": false, "KET": "Tidak ada gerhana"};
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
    final x0 = sBesselian(blnH, thnH, "x0");
    final x1 = sBesselian(blnH, thnH, "x1");
    final x2 = sBesselian(blnH, thnH, "x2");
    final x3 = sBesselian(blnH, thnH, "x3");
    final x4 = sBesselian(blnH, thnH, "x4");

    final y0 = sBesselian(blnH, thnH, "y0");
    final y1 = sBesselian(blnH, thnH, "y1");
    final y2 = sBesselian(blnH, thnH, "y2");
    final y3 = sBesselian(blnH, thnH, "y3");
    final y4 = sBesselian(blnH, thnH, "y4");

    final d0 = sBesselian(blnH, thnH, "d0");
    final d1 = sBesselian(blnH, thnH, "d1");
    final d2 = sBesselian(blnH, thnH, "d2");
    final d3 = sBesselian(blnH, thnH, "d3");
    final d4 = sBesselian(blnH, thnH, "d4");

    final mu0 = sBesselian(blnH, thnH, "mu0");
    final mu1 = sBesselian(blnH, thnH, "mu1");
    final mu2 = sBesselian(blnH, thnH, "mu2");
    final mu3 = sBesselian(blnH, thnH, "mu3");
    final mu4 = sBesselian(blnH, thnH, "mu4");

    final l10 = sBesselian(blnH, thnH, "l10");
    final l11 = sBesselian(blnH, thnH, "l11");
    final l12 = sBesselian(blnH, thnH, "l12");
    final l13 = sBesselian(blnH, thnH, "l13");
    final l14 = sBesselian(blnH, thnH, "l14");

    final l20 = sBesselian(blnH, thnH, "l20");
    final l21 = sBesselian(blnH, thnH, "l21");
    final l22 = sBesselian(blnH, thnH, "l22");
    final l23 = sBesselian(blnH, thnH, "l23");
    final l24 = sBesselian(blnH, thnH, "l24");

    final tanf1 = sBesselian(blnH, thnH, "f1");
    final tanf2 = sBesselian(blnH, thnH, "f2");

    // ===================== Waktu Gerhana =====================
    final jde1 = mo.jdeEclipseModified(blnH, thnH, 1);
    final jde2 =
        (jde1.floor()) + (((jde1 - jde1.floor()) * 24).roundToDouble()) / 24.0;

    final deltaT = dynamicalTime.deltaT(jde2);
    final t0 = (((jde2 + 0.5) - (jde2 + 0.5).floor()) * 24).roundToDouble();

    tMx += ppMx;

    // ===================== Iterasi 5 kali =====================
    for (int i = 1; i <= 5; i++) {
      pi = math.atan(0.99664719 * math.tan(mf.rad(gLat)));

      S = 0.99664719 * math.sin(pi) + (elev / 6378140) * math.sin(mf.rad(gLat));
      C = math.cos(pi) + (elev / 6378140) * math.cos(mf.rad(gLat));

      xMx =
          x0 +
          x1 * tMx +
          x2 * tMx * tMx +
          x3 * tMx * tMx * tMx +
          x4 * tMx * tMx * tMx * tMx;
      yMx =
          y0 +
          y1 * tMx +
          y2 * tMx * tMx +
          y3 * tMx * tMx * tMx +
          y4 * tMx * tMx * tMx * tMx;
      dMx =
          d0 +
          d1 * tMx +
          d2 * tMx * tMx +
          d3 * tMx * tMx * tMx +
          d4 * tMx * tMx * tMx * tMx;

      muMx =
          mu0 +
          mu1 * tMx +
          mu2 * tMx * tMx +
          mu3 * tMx * tMx * tMx +
          mu4 * tMx * tMx * tMx * tMx;

      l1Mx =
          l10 +
          l11 * tMx +
          l12 * tMx * tMx +
          l13 * tMx * tMx * tMx +
          l14 * tMx * tMx * tMx * tMx;
      l2Mx =
          l20 +
          l21 * tMx +
          l22 * tMx * tMx +
          l23 * tMx * tMx * tMx +
          l24 * tMx * tMx * tMx * tMx;

      xpMx = x1 + 2 * x2 * tMx + 3 * x3 * tMx * tMx + 4 * x4 * tMx * tMx * tMx;
      ypMx = y1 + 2 * y2 * tMx + 3 * y3 * tMx * tMx + 4 * y4 * tMx * tMx * tMx;

      hMx = mf.rad(muMx + gLon - 0.00417807 * deltaT);

      pMx = C * math.sin(hMx);
      qMx =
          S * math.cos(mf.rad(dMx)) - C * math.cos(hMx) * math.sin(mf.rad(dMx));
      rMx =
          S * math.sin(mf.rad(dMx)) + C * math.cos(hMx) * math.cos(mf.rad(dMx));

      prMx = 0.01745329 * mu1 * C * math.cos(hMx);
      qpMx = 0.01745329 * (mu1 * pMx * math.sin(mf.rad(dMx)) - rMx * d1);

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
    final nn = math.sqrt(nMx);

    final zz = (aMx * vMx - uMx * bMx) / (nn * l1p);
    final tau = (l1p / nn) * math.sqrt(1 - zz * zz);

    final mag = (l1p - mm) / (l1p + l2p);

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

    // Hisab Kontak U2 dan U3
    final double qq = (aMx * vMx - uMx * bMx) / (nn * l2p);
    final double t2 = ((l2p / nn) * math.sqrt(1 - qq * qq)).abs();
    final double aU2 = aaMx - t2;
    final double aU3 = aaMx + t2;
    final double jdSolarU2 = (jde2 + 0.5).floorToDouble() - 0.5 + (aU2 / 24.0);
    final double jdSolarU3 = (jde2 + 0.5).floorToDouble() - 0.5 + (aU3 / 24.0);

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
          x0 +
          x1 * tU1 +
          x2 * tU1 * tU1 +
          x3 * math.pow(tU1, 3) +
          x4 * math.pow(tU1, 4);
      yU1 =
          y0 +
          y1 * tU1 +
          y2 * tU1 * tU1 +
          y3 * math.pow(tU1, 3) +
          y4 * math.pow(tU1, 4);
      dU1 =
          d0 +
          d1 * tU1 +
          d2 * tU1 * tU1 +
          d3 * math.pow(tU1, 3) +
          d4 * math.pow(tU1, 4);
      muU1 =
          mu0 +
          mu1 * tU1 +
          mu2 * tU1 * tU1 +
          mu3 * math.pow(tU1, 3) +
          mu4 * math.pow(tU1, 4);
      l1U1 =
          l10 +
          l11 * tU1 +
          l12 * tU1 * tU1 +
          l13 * math.pow(tU1, 3) +
          l14 * math.pow(tU1, 4);

      xpU1 = x1 + 2 * x2 * tU1 + 3 * x3 * tU1 * tU1 + 4 * x4 * math.pow(tU1, 3);
      ypU1 = y1 + 2 * y2 * tU1 + 3 * y3 * tU1 * tU1 + 4 * y4 * math.pow(tU1, 3);

      hU1 = mf.rad(muU1 + gLon - 0.00417807 * deltaT);
      pU1 = c * math.sin(hU1);
      qU1 =
          s * math.cos(mf.rad(dU1)) - c * math.cos(hU1) * math.sin(mf.rad(dU1));
      rU1 =
          s * math.sin(mf.rad(dU1)) + c * math.cos(hU1) * math.cos(mf.rad(dU1));

      prU1 = 0.01745329 * mu1 * c * math.cos(hU1);
      qpU1 = 0.01745329 * (mu1 * pU1 * math.sin(mf.rad(dU1)) - rU1 * d1);

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
    jdSolarU1 = (jde2 + 0.5).floorToDouble() - 0.5 + ((t0 + aaU1) / 24.0);

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
          x0 +
          x1 * tU4 +
          x2 * tU4 * tU4 +
          x3 * math.pow(tU4, 3) +
          x4 * math.pow(tU4, 4);
      yU4 =
          y0 +
          y1 * tU4 +
          y2 * tU4 * tU4 +
          y3 * math.pow(tU4, 3) +
          y4 * math.pow(tU4, 4);
      dU4 =
          d0 +
          d1 * tU4 +
          d2 * tU4 * tU4 +
          d3 * math.pow(tU4, 3) +
          d4 * math.pow(tU4, 4);
      muU4 =
          mu0 +
          mu1 * tU4 +
          mu2 * tU4 * tU4 +
          mu3 * math.pow(tU4, 3) +
          mu4 * math.pow(tU4, 4);
      l1U4 =
          l10 +
          l11 * tU4 +
          l12 * tU4 * tU4 +
          l13 * math.pow(tU4, 3) +
          l14 * math.pow(tU4, 4);

      xpU4 = x1 + 2 * x2 * tU4 + 3 * x3 * tU4 * tU4 + 4 * x4 * math.pow(tU4, 3);
      ypU4 = y1 + 2 * y2 * tU4 + 3 * y3 * tU4 * tU4 + 4 * y4 * math.pow(tU4, 3);

      hU4 = mf.rad(muU4 + gLon - 0.00417807 * deltaT);
      pU4 = c * math.sin(hU4);
      qU4 =
          s * math.cos(mf.rad(dU4)) - c * math.cos(hU4) * math.sin(mf.rad(dU4));
      rU4 =
          s * math.sin(mf.rad(dU4)) + c * math.cos(hU4) * math.cos(mf.rad(dU4));

      prU4 = 0.01745329 * mu1 * c * math.cos(hU4);
      qpU4 = 0.01745329 * (mu1 * pU4 * math.sin(mf.rad(dU4)) - rU4 * d1);

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
    double durT = (jdSolarU3 - jdSolarU2) * 24.0;

    // Hisab Azimuth tiap kontak
    final double azmU1 = sn.sunTopocentricAzimuth(
      jdSolarU1,
      0.0,
      gLon,
      gLat,
      elev,
    );

    final double azmU2 = sn.sunTopocentricAzimuth(
      jdSolarU2,
      0.0,
      gLon,
      gLat,
      elev,
    );

    final double azmMx = sn.sunTopocentricAzimuth(
      jdSolarMx,
      0.0,
      gLon,
      gLat,
      elev,
    );

    final double azmU3 = sn.sunTopocentricAzimuth(
      jdSolarU3,
      0.0,
      gLon,
      gLat,
      elev,
    );

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

    final double altU2 = sn.sunTopocentricAltitude(
      jdSolarU2,
      0.0,
      gLon,
      gLat,
      elev,
      pres,
      temp,
      "htoc",
    );

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

    final double altU3 = sn.sunTopocentricAltitude(
      jdSolarU3,
      0.0,
      gLon,
      gLat,
      elev,
      pres,
      temp,
      "htoc",
    );

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

    return {
      "ADA": true,
      "KET": "Ada gerhana",

      "DT": deltaT,
      "T0": t0,

      "ELEMEN": {
        "x": [x0, x1, x2, x3, x4],
        "y": [y0, y1, y2, y3, y4],
        "d": [d0, d1, d2, d3, d4],
        "mu": [mu0, mu1, mu2, mu3, mu4],
        "l1": [l10, l11, l12, l13, l14],
        "l2": [l20, l21, l22, l23, l24],
        "tanf1": tanf1,
        "tanf2": tanf2,
      },

      "CONTACT": {
        "U1": {"JD": jdSolarU1, "azm": azmU1, "alt": altU1},
        "U2": {"JD": jdSolarU2, "azm": azmU2, "alt": altU2},
        "MX": {
          "JD": jdSolarMx,
          "azm": azmMx,
          "alt": altMx,

          // Ephemeris saat puncak
          "SUN": {"RA": raS / 15, "DEC": dcS, "SD": sdS, "HP": hpS},

          "MOON": {"RA": raM / 15, "DEC": dcM, "SD": sdM, "HP": hpM},
        },
        "U3": {"JD": jdSolarU3, "azm": azmU3, "alt": altU3},
        "U4": {"JD": jdSolarU4, "azm": azmU4, "alt": altU4},
      },

      "MAG": mag3,
      "OBS": obs,
      "JSE": jSE,
      "DURG": durG,
      "DURT": durT,
    };
  }

  String formatKontakGerhanaLokal(Map<String, dynamic>? contact, double tmZn) {
    if (contact == null) return "-";

    final double? jdUT = contact["JD"];
    if (jdUT == null) return "-";

    final double jdLocal = jdUT + (tmZn / 24.0);

    final String tanggal = julianDay.jdkm(jdLocal);

    double jamDes = double.parse(julianDay.jdkm(jdLocal, 0, "Jam Des"));

    jamDes = jamDes % 24;
    if (jamDes < 0) jamDes += 24;

    final String jam = mf.dhhms(jamDes, optResult: "HH:MM:SS", secDecPlaces: 1);

    final double? azm = contact["azm"];
    final double? alt = contact["alt"];

    return """
Tanggal  : $tanggal
Jam      : $jam
Azimuth  : ${azm != null ? mf.dddms(azm, optResult: "DDD°MM'SS\"", sdp: 0, posNegSign: "+-") : "-"}
Altitude : ${alt != null ? mf.dddms(alt, optResult: "DDD°MM'SS\"", sdp: 0, posNegSign: "+-") : "-"}
""";
  }

  String formatEphemerisMX(Map<String, dynamic>? mx) {
    if (mx == null) return "-";

    final sun = mx["SUN"];
    final moon = mx["MOON"];

    return """
========================================
DATA MATAHARI & BULAN SAAT PUNCAK GERHANA
========================================
☀️ MATAHARI
R.A : ${sun?["RA"] != null ? mf.dhhms(sun["RA"], optResult: "HHMMSS", secDecPlaces: 2) : "-"}
Dec : ${sun?["DEC"] != null ? mf.dddms(sun["DEC"], optResult: "DDD°MM'SS\"", sdp: 0, posNegSign: "+-") : "-"}
S.D : ${sun?["SD"] != null ? mf.dddms(sun["SD"], optResult: "DDD°MM'SS\"", sdp: 0) : "-"}
H.P : ${sun?["HP"] != null ? mf.dddms(sun["HP"], optResult: "DDD°MM'SS\"", sdp: 0) : "-"}

🌙 BULAN
R.A : ${moon?["RA"] != null ? mf.dhhms(moon["RA"], optResult: "HHMMSS", secDecPlaces: 2) : "-"}
Dec : ${moon?["DEC"] != null ? mf.dddms(moon["DEC"], optResult: "DDD°MM'SS\"", sdp: 0, posNegSign: "+-") : "-"}
S.D : ${moon?["SD"] != null ? mf.dddms(moon["SD"], optResult: "DDD°MM'SS\"", sdp: 0) : "-"}
H.P : ${moon?["HP"] != null ? mf.dddms(moon["HP"], optResult: "DDD°MM'SS\"", sdp: 0) : "-"}
""";
  }

  Map<String, dynamic> solarEclipseGlobal({
    required int blnH,
    required int thnH,
  }) {
    // 🔴 CEK DULU APAKAH ADA GERHANA
    final jdEclipse2 = sBesselian(blnH, thnH, "JDS");

    /// ===== CEK ADA / TIDAK GERHANA =====
    if (jdEclipse2.isNaN) {
      return {"ADA": false, "KET": "Tidak ada gerhana"};
    }

    // ===================== Data Besselian =====================
    final t0 = sBesselian(blnH, thnH, "t0");
    final dt = sBesselian(blnH, thnH, "DT");

    final x0 = sBesselian(blnH, thnH, "x0");
    final x1 = sBesselian(blnH, thnH, "x1");
    final x2 = sBesselian(blnH, thnH, "x2");
    final x3 = sBesselian(blnH, thnH, "x3");
    final x4 = sBesselian(blnH, thnH, "x4");

    final y0 = sBesselian(blnH, thnH, "y0");
    final y1 = sBesselian(blnH, thnH, "y1");
    final y2 = sBesselian(blnH, thnH, "y2");
    final y3 = sBesselian(blnH, thnH, "y3");
    final y4 = sBesselian(blnH, thnH, "y4");

    final d0 = sBesselian(blnH, thnH, "d0");
    final d1 = sBesselian(blnH, thnH, "d1");
    final d2 = sBesselian(blnH, thnH, "d2");
    final d3 = sBesselian(blnH, thnH, "d3");
    final d4 = sBesselian(blnH, thnH, "d4");

    final mu0 = sBesselian(blnH, thnH, "mu0");
    final mu1 = sBesselian(blnH, thnH, "mu1");
    final mu2 = sBesselian(blnH, thnH, "mu2");
    final mu3 = sBesselian(blnH, thnH, "mu3");
    final mu4 = sBesselian(blnH, thnH, "mu4");

    final l10 = sBesselian(blnH, thnH, "l10");
    final l11 = sBesselian(blnH, thnH, "l11");
    final l12 = sBesselian(blnH, thnH, "l12");
    final l13 = sBesselian(blnH, thnH, "l13");
    final l14 = sBesselian(blnH, thnH, "l14");

    final l20 = sBesselian(blnH, thnH, "l20");
    final l21 = sBesselian(blnH, thnH, "l21");
    final l22 = sBesselian(blnH, thnH, "l22");
    final l23 = sBesselian(blnH, thnH, "l23");
    final l24 = sBesselian(blnH, thnH, "l24");

    final tanf1 = sBesselian(blnH, thnH, "f1");
    final tanf2 = sBesselian(blnH, thnH, "f2");

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
          x0 +
          x1 * tMx +
          x2 * tMx * tMx +
          x3 * tMx * tMx * tMx +
          x4 * tMx * tMx * tMx * tMx;

      yMx =
          y0 +
          y1 * tMx +
          y2 * tMx * tMx +
          y3 * tMx * tMx * tMx +
          y4 * tMx * tMx * tMx * tMx;

      dMx =
          d0 +
          d1 * tMx +
          d2 * tMx * tMx +
          d3 * tMx * tMx * tMx +
          d4 * tMx * tMx * tMx * tMx;

      muMx =
          mu0 +
          mu1 * tMx +
          mu2 * tMx * tMx +
          mu3 * tMx * tMx * tMx +
          mu4 * tMx * tMx * tMx * tMx;

      xpMx = x1 + 2 * x2 * tMx + 3 * x3 * tMx * tMx + 4 * x4 * tMx * tMx * tMx;

      ypMx = y1 + 2 * y2 * tMx + 3 * y3 * tMx * tMx + 4 * y4 * tMx * tMx * tMx;

      mbMx = mf.mod(mf.deg(math.atan2(yMx, xMx)), 360.0);
      msMx = math.sqrt(xMx * xMx + yMx * yMx);

      nbMx = mf.mod(mf.deg(math.atan2(ypMx, xpMx)), 360.0);
      nsMx = math.sqrt(xpMx * xpMx + ypMx * ypMx);

      tuMx = -(msMx * math.cos(mf.rad(mbMx - nbMx)) / nsMx);
      tMx += tuMx;
    }

    mXTD = mf.mod(t0 + tMx, 24.0);
    mXUT = mf.mod(t0 + tMx - dt / 3600.0, 24.0);

    // ==========================
    // Tipe, Jenis, Durasi Gerhana
    // ==========================

    final double l1Mx =
        l10 +
        l11 * tuMx +
        l12 * tuMx * tuMx +
        l13 * tuMx * tuMx * tuMx +
        l14 * tuMx * tuMx * tuMx * tuMx;

    final double l2Mx =
        l20 +
        l21 * tuMx +
        l22 * tuMx * tuMx +
        l23 * tuMx * tuMx * tuMx +
        l24 * tuMx * tuMx * tuMx * tuMx;

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

    final double rho0 = math.sqrt(1 - e2 * math.cos(mf.rad(dMx)));
    final double d1Mx = mf.deg(
      math.atan(math.sin(mf.rad(dMx)) / (math.cos(mf.rad(dMx)) * ba)),
    );

    final double y1Mx = yMx / rho0;
    final double m1Mx = math.sqrt(xMx * xMx + y1Mx * y1Mx);
    final double y2Mx = y1Mx / m1Mx;
    final double bBig = math.sqrt(1 - xMx * xMx - y1Mx * y1Mx);

    final double pi1Mx = (msMx < 0.9972)
        ? mf.deg(
            math.asin(
              y1Mx * math.cos(mf.rad(d1Mx)) + bBig * math.sin(mf.rad(d1Mx)),
            ),
          )
        : mf.deg(math.asin(y2Mx * math.cos(mf.rad(d1Mx))));

    final double phiMx = mf.deg(math.atan(ab * math.tan(mf.rad(pi1Mx))));

    final double x2Mx = (msMx < 0.9972)
        ? -y1Mx * math.sin(mf.rad(d1Mx)) + bBig * math.cos(mf.rad(d1Mx))
        : -y1Mx * math.sin(mf.rad(d1Mx));

    final double haMx = mf.mod(mf.deg(math.atan2(xMx, x2Mx)), 360.0);

    final double calc = haMx - muMx + (0.004178 * dt);
    final double lmdMx = (calc > 180)
        ? calc - 360
        : (calc < -180 ? calc + 360 : calc);

    // ==========================
    final double l1pMx = l1Mx - bBig * tanf1;
    final double l2pMx = l2Mx - bBig * tanf2;

    final double pp = mf.rad(mu1);

    final double aa = ypMx - pp * xMx * math.sin(mf.rad(dMx));

    final double bb = xpMx + pp * yMx * math.sin(mf.rad(dMx));

    final double cc = bb - pp * bBig * math.cos(mf.rad(dMx));

    final double ns1 = math.sqrt(cc * cc + aa * aa);

    final double dur = (mf.abs(7200 * l2pMx / ns1)) / 60.0;

    // ==========================
    // Azimuth & Altitude puncak gerhana
    // ==========================

    final double altMx = mf.deg(
      math.asin(
        math.sin(mf.rad(phiMx)) * math.sin(mf.rad(dMx)) +
            math.cos(mf.rad(phiMx)) *
                math.cos(mf.rad(dMx)) *
                math.cos(mf.rad(haMx)),
      ),
    );

    final double azmMx = mf.mod(
      mf.deg(
            math.atan2(
              math.sin(mf.rad(haMx)),
              math.cos(mf.rad(haMx)) * math.sin(mf.rad(phiMx)) -
                  math.tan(mf.rad(dMx)) * math.cos(mf.rad(phiMx)),
            ),
          ) +
          180,
      360.0,
    );

    // ==========================
    // Magnitudo gerhana
    // ==========================

    final double rho = msMx / m1Mx;
    final double ddd = msMx - rho;

    final double mag1 = (l1pMx - l2pMx) / (l1pMx + l2pMx);

    final double mag2 = (l1Mx - ddd) / (l1Mx + l2Mx);

    final double mag = (msMx < 0.9972) ? mag1 : mag2;
    // ==========================
    // Lebar gerhana
    // ==========================

    final double kk = math.sqrt(
      bBig * bBig + math.pow((xMx * cc + yMx * aa) / ns1, 2.0),
    );

    final double wd = mf.abs(12756 * l2pMx / kk);

    // ==========================
    // Obskurasi (belum beres)
    // ==========================

    final double cBg = (msMx < 0.9972)
        ? math.acos(
            (l1pMx * l1pMx + l2pMx * l2pMx - 2 * ddd * ddd) /
                (l1pMx * l1pMx - l2pMx * l2pMx),
          )
        : math.acos(
            (l1Mx * l1Mx + l2Mx * l2Mx - 2 * ddd * ddd) /
                (l1Mx * l1Mx - l2Mx * l2Mx),
          );

    final double bBg = (msMx < 0.9972)
        ? math.acos((l1pMx * l2pMx + ddd * ddd) / (ddd * (l1pMx * l2pMx)))
        : math.acos((l1Mx * l2Mx + ddd * ddd) / (ddd * (l1Mx * l2Mx)));

    final double aBg = math.pi - (bBg + cBg);

    final double sSm = (msMx < 0.9972)
        ? (l1pMx - l2pMx) / (l1pMx + l2pMx)
        : (l1Mx - l2Mx) / (l1Mx + l2Mx);

    final double spB = (l2Mx < 0)
        ? 1.0
        : (l2Mx > 0.0 && l2Mx < 0.0047)
        ? sSm * sSm
        : (l2Mx > 0.0047)
        ? sSm * sSm
        : ((sSm * sSm) * aBg + sSm - bBg * math.sin(cBg)) / math.pi;

    //Waktu Kontak Maksimal
    final double jdEclipse = sBesselian(blnH, thnH, "JDS");

    final double jdSolarEclipseMxTD =
        mf.floor(jdEclipse - 0.5) + 0.5 + mXTD / 24.0;

    final double jdSolarEclipseMxUT =
        mf.floor(jdEclipse - 0.5) + 0.5 + mXUT / 24.0;

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
          x0 +
          x1 * tP1 +
          x2 * tP1 * tP1 +
          x3 * tP1 * tP1 * tP1 +
          x4 * tP1 * tP1 * tP1 * tP1;

      yP1 =
          y0 +
          y1 * tP1 +
          y2 * tP1 * tP1 +
          y3 * tP1 * tP1 * tP1 +
          y4 * tP1 * tP1 * tP1 * tP1;

      dP1 =
          d0 +
          d1 * tP1 +
          d2 * tP1 * tP1 +
          d3 * tP1 * tP1 * tP1 +
          d4 * tP1 * tP1 * tP1 * tP1;

      muP1 =
          mu0 +
          mu1 * tP1 +
          mu2 * tP1 * tP1 +
          mu3 * tP1 * tP1 * tP1 +
          mu4 * tP1 * tP1 * tP1 * tP1;

      xpP1 = x1 + 2 * x2 * tP1 + 3 * x3 * tP1 * tP1 + 4 * x4 * tP1 * tP1 * tP1;

      ypP1 = y1 + 2 * y2 * tP1 + 3 * y3 * tP1 * tP1 + 4 * y4 * tP1 * tP1 * tP1;

      l1P1 =
          l10 +
          l11 * tP1 +
          l12 * tP1 * tP1 +
          l13 * tP1 * tP1 * tP1 +
          l14 * tP1 * tP1 * tP1 * tP1;

      omP1 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dP1)) * math.cos(mf.rad(dP1)));

      msP1 = math.sqrt(xP1 * xP1 + yP1 * yP1);

      y1P1 = yP1 * omP1;
      m1P1 = math.sqrt(xP1 * xP1 + y1P1 * y1P1);
      roP1 = msP1 / m1P1;

      n2P1 = xpP1 * xpP1 + ypP1 * ypP1;
      nsP1 = math.sqrt(n2P1);

      psP1 = math.asin((xP1 * ypP1 - xpP1 * yP1) / (nsP1 * (l1P1 + roP1)));

      tuP1 =
          ((l1P1 + roP1) / nsP1) * -math.cos(psP1) -
          (xP1 * xpP1 + yP1 * ypP1) / (nsP1 * nsP1);

      tP1 = tP1 + tuP1;
    }

    double p1TD = mf.mod(t0 + tP1, 24.0);
    double p1UT = mf.mod(p1TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak P1
    double d1P1 = mf.deg(
      math.atan(math.sin(mf.rad(dP1)) / (math.cos(mf.rad(dP1)) * ba)),
    );

    double rhP1 = math.sqrt(
      math.sin(mf.rad(dP1)) * math.sin(mf.rad(dP1)) +
          (math.cos(mf.rad(dP1)) * ba) * (math.cos(mf.rad(dP1)) * ba),
    );

    double yIP1 = yP1 / rhP1;
    double mIP1 = math.sqrt(xP1 * xP1 + yIP1 * yIP1);

    double x1P1 = xP1 / mIP1;
    double y2P1 = yIP1 / mIP1;

    double pi1P1 = mf.deg(math.asin(y2P1 * math.cos(mf.rad(d1P1))));

    double piP1 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P1))));

    double x2P1 = -y2P1 * math.sin(mf.rad(dP1));

    double haP1 = mf.mod(mf.deg(math.atan2(x1P1, x2P1)), 360.0);

    double caP1 = haP1 - muP1 + (0.004178 * dt);

    double ldP1;

    if (caP1 > 180) {
      ldP1 = caP1 - 360;
    } else if (caP1 < -180) {
      ldP1 = caP1 + 360;
    } else {
      ldP1 = caP1;
    }

    // Azimuth dan Altitude
    double altP1 = mf.deg(
      math.asin(
        math.sin(mf.rad(piP1)) * math.sin(mf.rad(dP1)) +
            math.cos(mf.rad(piP1)) *
                math.cos(mf.rad(dP1)) *
                math.cos(mf.rad(haP1)),
      ),
    );

    double azmP1 = mf.mod(
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

    final double jdSolarEclipseP1TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + p1TD / 24.0;

    final double jdSolarEclipseP1UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + p1UT / 24.0;

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
          x0 +
          x1 * tP4 +
          x2 * tP4 * tP4 +
          x3 * tP4 * tP4 * tP4 +
          x4 * tP4 * tP4 * tP4 * tP4;

      yP4 =
          y0 +
          y1 * tP4 +
          y2 * tP4 * tP4 +
          y3 * tP4 * tP4 * tP4 +
          y4 * tP4 * tP4 * tP4 * tP4;

      dP4 =
          d0 +
          d1 * tP4 +
          d2 * tP4 * tP4 +
          d3 * tP4 * tP4 * tP4 +
          d4 * tP4 * tP4 * tP4 * tP4;

      muP4 =
          mu0 +
          mu1 * tP4 +
          mu2 * tP4 * tP4 +
          mu3 * tP4 * tP4 * tP4 +
          mu4 * tP4 * tP4 * tP4 * tP4;

      xpP4 =
          x1 +
          2.0 * x2 * tP4 +
          3.0 * x3 * tP4 * tP4 +
          4.0 * x4 * tP4 * tP4 * tP4;

      ypP4 =
          y1 +
          2.0 * y2 * tP4 +
          3.0 * y3 * tP4 * tP4 +
          4.0 * y4 * tP4 * tP4 * tP4;

      l1P4 =
          l10 +
          l11 * tP4 +
          l12 * tP4 * tP4 +
          l13 * tP4 * tP4 * tP4 +
          l14 * tP4 * tP4 * tP4 * tP4;

      omP4 =
          1.0 /
          math.sqrt(1.0 - e2 * math.cos(mf.rad(dP4)) * math.cos(mf.rad(dP4)));

      msP4 = math.sqrt(xP4 * xP4 + yP4 * yP4);

      y1P4 = yP4 * omP4;

      m1P4 = math.sqrt(xP4 * xP4 + y1P4 * y1P4);

      roP4 = msP4 / m1P4;

      n2P4 = xpP4 * xpP4 + ypP4 * ypP4;

      nsP4 = math.sqrt(n2P4);

      psP4 = math.asin((xP4 * ypP4 - xpP4 * yP4) / (nsP4 * (l1P4 + roP4)));

      tuP4 =
          ((l1P4 + roP4) / nsP4) * math.cos(psP4) -
          (xP4 * xpP4 + yP4 * ypP4) / (nsP4 * nsP4);

      tP4 = tP4 + tuP4;
    }

    double p4TD = mf.mod(t0 + tP4, 24.0);
    double p4UT = mf.mod(p4TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak P4

    double d1P4 = mf.deg(
      math.atan(math.sin(mf.rad(dP4)) / (math.cos(mf.rad(dP4)) * ba)),
    );

    double rhP4 = math.sqrt(
      math.sin(mf.rad(dP4)) * math.sin(mf.rad(dP4)) +
          (math.cos(mf.rad(dP4)) * ba) * (math.cos(mf.rad(dP4)) * ba),
    );

    double yIP4 = yP4 / rhP4;

    double mIP4 = math.sqrt(xP4 * xP4 + yIP4 * yIP4);

    double x1P4 = xP4 / mIP4;
    double y2P4 = yIP4 / mIP4;

    double pi1P4 = mf.deg(math.asin(y2P4 * math.cos(mf.rad(d1P4))));

    double piP4 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P4))));

    double x2P4 = -y2P4 * math.sin(mf.rad(dP4));

    double haP4 = mf.mod(mf.deg(math.atan2(x1P4, x2P4)), 360.0);

    double caP4 = haP4 - muP4 + (0.004178 * dt);

    double ldP4;

    if (caP4 > 180.0) {
      ldP4 = caP4 - 360.0;
    } else if (caP4 < -180.0) {
      ldP4 = caP4 + 360.0;
    } else {
      ldP4 = caP4;
    }

    // Azimuth dan Altitude saat kontak P4

    double altP4 = mf.deg(
      math.asin(
        math.sin(mf.rad(piP4)) * math.sin(mf.rad(dP4)) +
            math.cos(mf.rad(piP4)) *
                math.cos(mf.rad(dP4)) *
                math.cos(mf.rad(haP4)),
      ),
    );

    double azmP4 = mf.mod(
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

    final double jdSolarEclipseP4TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + p4TD / 24.0;

    final double jdSolarEclipseP4UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + p4UT / 24.0;

    // Penumbral First Internal Contact (P2)

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
          x0 +
          x1 * tP2 +
          x2 * tP2 * tP2 +
          x3 * tP2 * tP2 * tP2 +
          x4 * tP2 * tP2 * tP2 * tP2;

      yP2 =
          y0 +
          y1 * tP2 +
          y2 * tP2 * tP2 +
          y3 * tP2 * tP2 * tP2 +
          y4 * tP2 * tP2 * tP2 * tP2;

      dP2 =
          d0 +
          d1 * tP2 +
          d2 * tP2 * tP2 +
          d3 * tP2 * tP2 * tP2 +
          d4 * tP2 * tP2 * tP2 * tP2;

      muP2 =
          mu0 +
          mu1 * tP2 +
          mu2 * tP2 * tP2 +
          mu3 * tP2 * tP2 * tP2 +
          mu4 * tP2 * tP2 * tP2 * tP2;

      xpP2 =
          x1 +
          2.0 * x2 * tP2 +
          3.0 * x3 * tP2 * tP2 +
          4.0 * x4 * tP2 * tP2 * tP2;

      ypP2 =
          y1 +
          2.0 * y2 * tP2 +
          3.0 * y3 * tP2 * tP2 +
          4.0 * y4 * tP2 * tP2 * tP2;

      l1P2 =
          l10 +
          l11 * tP2 +
          l12 * tP2 * tP2 +
          l13 * tP2 * tP2 * tP2 +
          l14 * tP2 * tP2 * tP2 * tP2;

      omP2 =
          1.0 /
          math.sqrt(1.0 - e2 * math.cos(mf.rad(dP2)) * math.cos(mf.rad(dP2)));

      msP2 = math.sqrt(xP2 * xP2 + yP2 * yP2);

      y1P2 = yP2 * omP2;

      m1P2 = math.sqrt(xP2 * xP2 + y1P2 * y1P2);

      roP2 = msP2 / m1P2;

      n2P2 = xpP2 * xpP2 + ypP2 * ypP2;

      nsP2 = math.sqrt(n2P2);

      psP2 = math.asin((xP2 * ypP2 - xpP2 * yP2) / (nsP2 * (l1P2 - roP2)));

      tuP2 =
          ((roP2 - l1P2) / nsP2) * -math.cos(psP2) -
          (xP2 * xpP2 + yP2 * ypP2) / (nsP2 * nsP2);

      tP2 = tP2 + tuP2;
    }

    double p2TD = mf.mod(t0 + tP2, 24.0);

    double p2UT = mf.mod(p2TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak P2

    double d1P2 = mf.deg(
      math.atan(math.sin(mf.rad(dP2)) / (math.cos(mf.rad(dP2)) * ba)),
    );

    double rhP2 = math.sqrt(
      math.sin(mf.rad(dP2)) * math.sin(mf.rad(dP2)) +
          (math.cos(mf.rad(dP2)) * ba) * (math.cos(mf.rad(dP2)) * ba),
    );

    double yIP2 = yP2 / rhP2;

    double mIP2 = math.sqrt(xP2 * xP2 + yIP2 * yIP2);

    double x1P2 = xP2 / mIP2;

    double y2P2 = yIP2 / mIP2;

    double pi1P2 = mf.deg(math.asin(y2P2 * math.cos(mf.rad(d1P2))));

    double piP2 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P2))));

    double x2P2 = -y2P2 * math.sin(mf.rad(dP2));

    double haP2 = mf.mod(mf.deg(math.atan2(x1P2, x2P2)), 360.0);

    double caP2 = haP2 - muP2 + (0.004178 * dt);

    double ldP2;

    if (caP2 > 180.0) {
      ldP2 = caP2 - 360.0;
    } else if (caP2 < -180.0) {
      ldP2 = caP2 + 360.0;
    } else {
      ldP2 = caP2;
    }

    // Azimuth dan Altitude saat kontak P2

    double altP2 = mf.deg(
      math.asin(
        math.sin(mf.rad(piP2)) * math.sin(mf.rad(dP2)) +
            math.cos(mf.rad(piP2)) *
                math.cos(mf.rad(dP2)) *
                math.cos(mf.rad(haP2)),
      ),
    );

    double azmP2 = mf.mod(
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

    final double jdSolarEclipseP2TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + p2TD / 24.0;

    final double jdSolarEclipseP2UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + p2UT / 24.0;

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
          x0 +
          x1 * tP3 +
          x2 * tP3 * tP3 +
          x3 * tP3 * tP3 * tP3 +
          x4 * tP3 * tP3 * tP3 * tP3;

      yP3 =
          y0 +
          y1 * tP3 +
          y2 * tP3 * tP3 +
          y3 * tP3 * tP3 * tP3 +
          y4 * tP3 * tP3 * tP3 * tP3;

      dP3 =
          d0 +
          d1 * tP3 +
          d2 * tP3 * tP3 +
          d3 * tP3 * tP3 * tP3 +
          d4 * tP3 * tP3 * tP3 * tP3;

      muP3 =
          mu0 +
          mu1 * tP3 +
          mu2 * tP3 * tP3 +
          mu3 * tP3 * tP3 * tP3 +
          mu4 * tP3 * tP3 * tP3 * tP3;

      xpP3 = x1 + 2 * x2 * tP3 + 3 * x3 * tP3 * tP3 + 4 * x4 * tP3 * tP3 * tP3;

      ypP3 = y1 + 2 * y2 * tP3 + 3 * y3 * tP3 * tP3 + 4 * y4 * tP3 * tP3 * tP3;

      l1P3 =
          l10 +
          l11 * tP3 +
          l12 * tP3 * tP3 +
          l13 * tP3 * tP3 * tP3 +
          l14 * tP3 * tP3 * tP3 * tP3;

      omP3 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dP3)) * math.cos(mf.rad(dP3)));

      msP3 = math.sqrt(xP3 * xP3 + yP3 * yP3);

      y1P3 = yP3 * omP3;
      m1P3 = math.sqrt(xP3 * xP3 + y1P3 * y1P3);

      roP3 = msP3 / m1P3;

      n2P3 = xpP3 * xpP3 + ypP3 * ypP3;
      nsP3 = math.sqrt(n2P3);

      psP3 = math.asin((xP3 * ypP3 - xpP3 * yP3) / (nsP3 * (l1P3 - roP3)));

      tuP3 =
          ((roP3 - l1P3) / nsP3) * math.cos(psP3) -
          (xP3 * xpP3 + yP3 * ypP3) / (nsP3 * nsP3);

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
      math.atan(math.sin(mf.rad(dP3)) / (math.cos(mf.rad(dP3)) * ba)),
    );

    double rhP3 = math.sqrt(
      math.sin(mf.rad(dP3)) * math.sin(mf.rad(dP3)) +
          (math.cos(mf.rad(dP3)) * ba) * (math.cos(mf.rad(dP3)) * ba),
    );

    double yIP3 = yP3 / rhP3;

    double mIP3 = math.sqrt(xP3 * xP3 + yIP3 * yIP3);

    double x1P3 = xP3 / mIP3;
    double y2P3 = yIP3 / mIP3;

    double pi1P3 = mf.deg(math.asin(y2P3 * math.cos(mf.rad(d1P3))));

    double piP3 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1P3))));

    double x2P3 = -y2P3 * math.sin(mf.rad(dP3));

    double haP3 = mf.mod(mf.deg(math.atan2(x1P3, x2P3)), 360.0);

    double caP3 = haP3 - muP3 + (0.004178 * dt);

    double ldP3;

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

    double altP3 = mf.deg(
      math.asin(
        math.sin(mf.rad(piP3)) * math.sin(mf.rad(dP3)) +
            math.cos(mf.rad(piP3)) *
                math.cos(mf.rad(dP3)) *
                math.cos(mf.rad(haP3)),
      ),
    );

    double azmP3 = mf.mod(
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

    final double jdSolarEclipseP3TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + p3TD / 24.0;

    final double jdSolarEclipseP3UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + p3UT / 24.0;

    // ===============================
    // Umbral First External Contact (U1)
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
          x0 +
          x1 * tU1 +
          x2 * tU1 * tU1 +
          x3 * tU1 * tU1 * tU1 +
          x4 * tU1 * tU1 * tU1 * tU1;
      yU1 =
          y0 +
          y1 * tU1 +
          y2 * tU1 * tU1 +
          y3 * tU1 * tU1 * tU1 +
          y4 * tU1 * tU1 * tU1 * tU1;
      dU1 =
          d0 +
          d1 * tU1 +
          d2 * tU1 * tU1 +
          d3 * tU1 * tU1 * tU1 +
          d4 * tU1 * tU1 * tU1 * tU1;
      muU1 =
          mu0 +
          mu1 * tU1 +
          mu2 * tU1 * tU1 +
          mu3 * tU1 * tU1 * tU1 +
          mu4 * tU1 * tU1 * tU1 * tU1;

      xpU1 = x1 + 2 * x2 * tU1 + 3 * x3 * tU1 * tU1 + 4 * x4 * tU1 * tU1 * tU1;

      ypU1 = y1 + 2 * y2 * tU1 + 3 * y3 * tU1 * tU1 + 4 * y4 * tU1 * tU1 * tU1;

      l2U1 =
          l20 +
          l21 * tU1 +
          l22 * tU1 * tU1 +
          l23 * tU1 * tU1 * tU1 +
          l24 * tU1 * tU1 * tU1 * tU1;

      omU1 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dU1)) * math.cos(mf.rad(dU1)));
      msU1 = math.sqrt(xU1 * xU1 + yU1 * yU1);

      y1U1 = yU1 * omU1;
      m1U1 = math.sqrt(xU1 * xU1 + y1U1 * y1U1);
      roU1 = msU1 / m1U1;

      n2U1 = xpU1 * xpU1 + ypU1 * ypU1;
      nsU1 = math.sqrt(n2U1);

      if (l2U1 < 0.0) {
        psU1 = math.asin((xU1 * ypU1 - xpU1 * yU1) / (nsU1 * (l2U1 - roU1)));
        tuU1 =
            ((roU1 - l2U1) / nsU1) * -math.cos(psU1) -
            (xU1 * xpU1 + yU1 * ypU1) / (nsU1 * nsU1);
      } else {
        psU1 = math.asin((xU1 * ypU1 - xpU1 * yU1) / (nsU1 * (l2U1 + roU1)));
        tuU1 =
            ((roU1 + l2U1) / nsU1) * -math.cos(psU1) -
            (xU1 * xpU1 + yU1 * ypU1) / (nsU1 * nsU1);
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
      math.atan(math.sin(mf.rad(dU1)) / (math.cos(mf.rad(dU1)) * ba)),
    );

    double rhU1 = math.sqrt(
      math.sin(mf.rad(dU1)) * math.sin(mf.rad(dU1)) +
          (math.cos(mf.rad(dU1)) * ba) * (math.cos(mf.rad(dU1)) * ba),
    );

    double yIU1 = yU1 / rhU1;
    double mIU1 = math.sqrt(xU1 * xU1 + yIU1 * yIU1);

    double x1U1 = xU1 / mIU1;
    double y2U1 = yIU1 / mIU1;

    double pi1U1 = mf.deg(math.asin(y2U1 * math.cos(mf.rad(d1U1))));

    double piU1 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U1))));

    double x2U1 = -y2U1 * math.sin(mf.rad(dU1));

    double haU1 = mf.mod(mf.deg(math.atan2(x1U1, x2U1)), 360.0);

    double caU1 = haU1 - muU1 + (0.004178 * dt);

    double ldU1;
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

    double altU1 = mf.deg(
      math.asin(
        math.sin(mf.rad(piU1)) * math.sin(mf.rad(dU1)) +
            math.cos(mf.rad(piU1)) *
                math.cos(mf.rad(dU1)) *
                math.cos(mf.rad(haU1)),
      ),
    );

    double azmU1 = mf.mod(
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

    final double jdSolarEclipseU1TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + u1TD / 24.0;

    final double jdSolarEclipseU1UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + u1UT / 24.0;

    // Umbral Last External Contact (U4)

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
          x0 +
          x1 * tU4 +
          x2 * tU4 * tU4 +
          x3 * tU4 * tU4 * tU4 +
          x4 * tU4 * tU4 * tU4 * tU4;

      yU4 =
          y0 +
          y1 * tU4 +
          y2 * tU4 * tU4 +
          y3 * tU4 * tU4 * tU4 +
          y4 * tU4 * tU4 * tU4 * tU4;

      dU4 =
          d0 +
          d1 * tU4 +
          d2 * tU4 * tU4 +
          d3 * tU4 * tU4 * tU4 +
          d4 * tU4 * tU4 * tU4 * tU4;

      muU4 =
          mu0 +
          mu1 * tU4 +
          mu2 * tU4 * tU4 +
          mu3 * tU4 * tU4 * tU4 +
          mu4 * tU4 * tU4 * tU4 * tU4;

      xpU4 = x1 + 2 * x2 * tU4 + 3 * x3 * tU4 * tU4 + 4 * x4 * tU4 * tU4 * tU4;

      ypU4 = y1 + 2 * y2 * tU4 + 3 * y3 * tU4 * tU4 + 4 * y4 * tU4 * tU4 * tU4;

      l2U4 =
          l20 +
          l21 * tU4 +
          l22 * tU4 * tU4 +
          l23 * tU4 * tU4 * tU4 +
          l24 * tU4 * tU4 * tU4 * tU4;

      omU4 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dU4)) * math.cos(mf.rad(dU4)));

      msU4 = math.sqrt(xU4 * xU4 + yU4 * yU4);

      y1U4 = yU4 * omU4;
      m1U4 = math.sqrt(xU4 * xU4 + y1U4 * y1U4);
      roU4 = msU4 / m1U4;

      n2U4 = xpU4 * xpU4 + ypU4 * ypU4;
      nsU4 = math.sqrt(n2U4);

      if (l2U4 < 0.0) {
        psU4 = math.asin((xU4 * ypU4 - xpU4 * yU4) / (nsU4 * (l2U4 - roU4)));
      } else {
        psU4 = math.asin((xU4 * ypU4 - xpU4 * yU4) / (nsU4 * (l2U4 + roU4)));
      }

      if (l2U4 < 0.0) {
        tuU4 =
            ((roU4 - l2U4) / nsU4) * math.cos(psU4) -
            (xU4 * xpU4 + yU4 * ypU4) / (nsU4 * nsU4);
      } else {
        tuU4 =
            ((roU4 + l2U4) / nsU4) * math.cos(psU4) -
            (xU4 * xpU4 + yU4 * ypU4) / (nsU4 * nsU4);
      }

      tU4 = tU4 + tuU4;
    }

    double u4TD = mf.mod(t0 + tU4, 24.0);
    double u4UT = mf.mod(u4TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak U4

    double d1U4 = mf.deg(
      math.atan((math.sin(mf.rad(dU4))) / (math.cos(mf.rad(dU4)) * ba)),
    );

    double rhU4 = math.sqrt(
      math.sin(mf.rad(dU4)) * math.sin(mf.rad(dU4)) +
          (math.cos(mf.rad(dU4)) * ba) * (math.cos(mf.rad(dU4)) * ba),
    );

    double yIU4 = yU4 / rhU4;
    double mIU4 = math.sqrt(xU4 * xU4 + yIU4 * yIU4);

    double x1U4 = xU4 / mIU4;
    double y2U4 = yIU4 / mIU4;

    double pi1U4 = mf.deg(math.asin(y2U4 * math.cos(mf.rad(d1U4))));

    double piU4 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U4))));

    double x2U4 = -y2U4 * math.sin(mf.rad(dU4));

    double haU4 = mf.mod(mf.deg(math.atan2(x1U4, x2U4)), 360.0);

    double caU4 = haU4 - muU4 + (0.004178 * dt);

    double ldU4;
    if (caU4 > 180) {
      ldU4 = caU4 - 360;
    } else if (caU4 < -180) {
      ldU4 = caU4 + 360;
    } else {
      ldU4 = caU4;
    }

    // Azimuth dan Altitude saat kontak U4

    double altU4 = mf.deg(
      math.asin(
        math.sin(mf.rad(piU4)) * math.sin(mf.rad(dU4)) +
            math.cos(mf.rad(piU4)) *
                math.cos(mf.rad(dU4)) *
                math.cos(mf.rad(haU4)),
      ),
    );

    double azmU4 = mf.mod(
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

    final double jdSolarEclipseU4TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + u4TD / 24.0;

    final double jdSolarEclipseU4UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + u4UT / 24.0;

    // Umbral First Internal Contact (U2)

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
          x0 +
          x1 * tU2 +
          x2 * tU2 * tU2 +
          x3 * tU2 * tU2 * tU2 +
          x4 * tU2 * tU2 * tU2 * tU2;

      yU2 =
          y0 +
          y1 * tU2 +
          y2 * tU2 * tU2 +
          y3 * tU2 * tU2 * tU2 +
          y4 * tU2 * tU2 * tU2 * tU2;

      dU2 =
          d0 +
          d1 * tU2 +
          d2 * tU2 * tU2 +
          d3 * tU2 * tU2 * tU2 +
          d4 * tU2 * tU2 * tU2 * tU2;

      muU2 =
          mu0 +
          mu1 * tU2 +
          mu2 * tU2 * tU2 +
          mu3 * tU2 * tU2 * tU2 +
          mu4 * tU2 * tU2 * tU2 * tU2;

      xpU2 = x1 + 2 * x2 * tU2 + 3 * x3 * tU2 * tU2 + 4 * x4 * tU2 * tU2 * tU2;

      ypU2 = y1 + 2 * y2 * tU2 + 3 * y3 * tU2 * tU2 + 4 * y4 * tU2 * tU2 * tU2;

      l2U2 =
          l20 +
          l21 * tU2 +
          l22 * tU2 * tU2 +
          l23 * tU2 * tU2 * tU2 +
          l24 * tU2 * tU2 * tU2 * tU2;

      omU2 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dU2)) * math.cos(mf.rad(dU2)));

      msU2 = math.sqrt(xU2 * xU2 + yU2 * yU2);

      y1U2 = yU2 * omU2;
      m1U2 = math.sqrt(xU2 * xU2 + y1U2 * y1U2);
      roU2 = msU2 / m1U2;

      n2U2 = xpU2 * xpU2 + ypU2 * ypU2;
      nsU2 = math.sqrt(n2U2);

      if (l2U2 < 0.0) {
        psU2 = math.asin((xU2 * ypU2 - xpU2 * yU2) / (nsU2 * (l2U2 + roU2)));
      } else {
        psU2 = math.asin((xU2 * ypU2 - xpU2 * yU2) / (nsU2 * (l2U2 - roU2)));
      }

      if (l2U2 < 0.0) {
        tuU2 =
            ((roU2 + l2U2) / nsU2) * -math.cos(psU2) -
            (xU2 * xpU2 + yU2 * ypU2) / (nsU2 * nsU2);
      } else {
        tuU2 =
            ((roU2 - l2U2) / nsU2) * -math.cos(psU2) -
            (xU2 * xpU2 + yU2 * ypU2) / (nsU2 * nsU2);
      }

      tU2 = tU2 + tuU2;
    }

    double u2TD = mf.mod(t0 + tU2, 24.0);
    double u2UT = mf.mod(u2TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak U2

    double d1U2 = mf.deg(
      math.atan(math.sin(mf.rad(dU2)) / (math.cos(mf.rad(dU2)) * ba)),
    );

    double rhU2 = math.sqrt(
      math.sin(mf.rad(dU2)) * math.sin(mf.rad(dU2)) +
          (math.cos(mf.rad(dU2)) * ba) * (math.cos(mf.rad(dU2)) * ba),
    );

    double yIU2 = yU2 / rhU2;
    double mIU2 = math.sqrt(xU2 * xU2 + yIU2 * yIU2);

    double x1U2 = xU2 / mIU2;
    double y2U2 = yIU2 / mIU2;

    double pi1U2 = mf.deg(math.asin(y2U2 * math.cos(mf.rad(d1U2))));

    double piU2 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U2))));

    double x2U2 = -y2U2 * math.sin(mf.rad(dU2));

    double haU2 = mf.mod(mf.deg(math.atan2(x1U2, x2U2)), 360.0);

    double caU2 = haU2 - muU2 + (0.004178 * dt);

    double ldU2;
    if (caU2 > 180) {
      ldU2 = caU2 - 360;
    } else if (caU2 < -180) {
      ldU2 = caU2 + 360;
    } else {
      ldU2 = caU2;
    }

    // Azimuth dan Altitude saat kontak U2

    double altU2 = mf.deg(
      math.asin(
        math.sin(mf.rad(piU2)) * math.sin(mf.rad(dU2)) +
            math.cos(mf.rad(piU2)) *
                math.cos(mf.rad(dU2)) *
                math.cos(mf.rad(haU2)),
      ),
    );

    double azmU2 = mf.mod(
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

    final double jdSolarEclipseU2TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + u2TD / 24.0;

    final double jdSolarEclipseU2UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + u2UT / 24.0;

    // Umbral Last Internal Contact (U3)

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
          x0 +
          x1 * tU3 +
          x2 * tU3 * tU3 +
          x3 * tU3 * tU3 * tU3 +
          x4 * tU3 * tU3 * tU3 * tU3;

      yU3 =
          y0 +
          y1 * tU3 +
          y2 * tU3 * tU3 +
          y3 * tU3 * tU3 * tU3 +
          y4 * tU3 * tU3 * tU3 * tU3;

      dU3 =
          d0 +
          d1 * tU3 +
          d2 * tU3 * tU3 +
          d3 * tU3 * tU3 * tU3 +
          d4 * tU3 * tU3 * tU3 * tU3;

      muU3 =
          mu0 +
          mu1 * tU3 +
          mu2 * tU3 * tU3 +
          mu3 * tU3 * tU3 * tU3 +
          mu4 * tU3 * tU3 * tU3 * tU3;

      xpU3 = x1 + 2 * x2 * tU3 + 3 * x3 * tU3 * tU3 + 4 * x4 * tU3 * tU3 * tU3;

      ypU3 = y1 + 2 * y2 * tU3 + 3 * y3 * tU3 * tU3 + 4 * y4 * tU3 * tU3 * tU3;

      l2U3 =
          l20 +
          l21 * tU3 +
          l22 * tU3 * tU3 +
          l23 * tU3 * tU3 * tU3 +
          l24 * tU3 * tU3 * tU3 * tU3;

      omU3 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dU3)) * math.cos(mf.rad(dU3)));

      msU3 = math.sqrt(xU3 * xU3 + yU3 * yU3);

      y1U3 = yU3 * omU3;
      m1U3 = math.sqrt(xU3 * xU3 + y1U3 * y1U3);
      roU3 = msU3 / m1U3;

      n2U3 = xpU3 * xpU3 + ypU3 * ypU3;
      nsU3 = math.sqrt(n2U3);

      if (l2U3 < 0.0) {
        psU3 = math.asin((xU3 * ypU3 - xpU3 * yU3) / (nsU3 * (l2U3 + roU3)));
      } else {
        psU3 = math.asin((xU3 * ypU3 - xpU3 * yU3) / (nsU3 * (l2U3 - roU3)));
      }

      if (l2U3 < 0.0) {
        tuU3 =
            ((roU3 + l2U3) / nsU3) * math.cos(psU3) -
            (xU3 * xpU3 + yU3 * ypU3) / (nsU3 * nsU3);
      } else {
        tuU3 =
            ((roU3 - l2U3) / nsU3) * math.cos(psU3) -
            (xU3 * xpU3 + yU3 * ypU3) / (nsU3 * nsU3);
      }

      tU3 = tU3 + tuU3;
    }

    double u3TD = mf.mod(t0 + tU3, 24.0);
    double u3UT = mf.mod(u3TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak U3

    double d1U3 = mf.deg(
      math.atan(math.sin(mf.rad(dU3)) / (math.cos(mf.rad(dU3)) * ba)),
    );

    double rhU3 = math.sqrt(
      math.sin(mf.rad(dU3)) * math.sin(mf.rad(dU3)) +
          (math.cos(mf.rad(dU3)) * ba) * (math.cos(mf.rad(dU3)) * ba),
    );

    double yIU3 = yU3 / rhU3;
    double mIU3 = math.sqrt(xU3 * xU3 + yIU3 * yIU3);

    double x1U3 = xU3 / mIU3;
    double y2U3 = yIU3 / mIU3;

    double pi1U3 = mf.deg(math.asin(y2U3 * math.cos(mf.rad(d1U3))));

    double piU3 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1U3))));

    double x2U3 = -y2U3 * math.sin(mf.rad(dU3));

    double haU3 = mf.mod(mf.deg(math.atan2(x1U3, x2U3)), 360.0);

    double caU3 = haU3 - muU3 + (0.004178 * dt);

    double ldU3;
    if (caU3 > 180) {
      ldU3 = caU3 - 360;
    } else if (caU3 < -180) {
      ldU3 = caU3 + 360;
    } else {
      ldU3 = caU3;
    }

    // Azimuth dan Altitude saat kontak U3

    double altU3 = mf.deg(
      math.asin(
        math.sin(mf.rad(piU3)) * math.sin(mf.rad(dU3)) +
            math.cos(mf.rad(piU3)) *
                math.cos(mf.rad(dU3)) *
                math.cos(mf.rad(haU3)),
      ),
    );

    double azmU3 = mf.mod(
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

    final double jdSolarEclipseU3TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + u3TD / 24.0;

    final double jdSolarEclipseU3UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + u3UT / 24.0;

    // Extreme Central Line Limit 1 (C1)

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
          x0 +
          x1 * tC1 +
          x2 * tC1 * tC1 +
          x3 * tC1 * tC1 * tC1 +
          x4 * tC1 * tC1 * tC1 * tC1;

      yC1 =
          y0 +
          y1 * tC1 +
          y2 * tC1 * tC1 +
          y3 * tC1 * tC1 * tC1 +
          y4 * tC1 * tC1 * tC1 * tC1;

      dC1 =
          d0 +
          d1 * tC1 +
          d2 * tC1 * tC1 +
          d3 * tC1 * tC1 * tC1 +
          d4 * tC1 * tC1 * tC1 * tC1;

      muC1 =
          mu0 +
          mu1 * tC1 +
          mu2 * tC1 * tC1 +
          mu3 * tC1 * tC1 * tC1 +
          mu4 * tC1 * tC1 * tC1 * tC1;

      xpC1 = x1 + 2 * x2 * tC1 + 3 * x3 * tC1 * tC1 + 4 * x4 * tC1 * tC1 * tC1;

      ypC1 = y1 + 2 * y2 * tC1 + 3 * y3 * tC1 * tC1 + 4 * y4 * tC1 * tC1 * tC1;

      omC1 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dC1)) * math.cos(mf.rad(dC1)));

      uC1 = xC1;
      vC1 = yC1 * omC1;
      aC1 = xpC1;
      bC1 = ypC1 * omC1;

      n2C1 = aC1 * aC1 + bC1 * bC1;
      nsC1 = math.sqrt(n2C1);

      psC1 = (aC1 * vC1 - uC1 * bC1) / nsC1;

      tuC1 =
          -(uC1 * aC1 + vC1 * bC1) / n2C1 - math.sqrt(1 - psC1 * psC1) / nsC1;

      tC1 = tC1 + tuC1;
    }

    double c1TD = mf.mod(t0 + tC1, 24.0);
    double c1UT = mf.mod(c1TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak C1

    double d1C1 = mf.deg(
      math.atan(math.sin(mf.rad(dC1)) / (math.cos(mf.rad(dC1)) * ba)),
    );

    double rhC1 = math.sqrt(
      math.sin(mf.rad(dC1)) * math.sin(mf.rad(dC1)) +
          (math.cos(mf.rad(dC1)) * ba) * (math.cos(mf.rad(dC1)) * ba),
    );

    double yIC1 = yC1 / rhC1;
    double mIC1 = math.sqrt(xC1 * xC1 + yIC1 * yIC1);

    double x1C1 = xC1 / mIC1;
    double y2C1 = yIC1 / mIC1;

    double pi1C1 = mf.deg(math.asin(y2C1 * math.cos(mf.rad(d1C1))));

    double piC1 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1C1))));

    double x2C1 = -y2C1 * math.sin(mf.rad(dC1));

    double haC1 = mf.mod(mf.deg(math.atan2(x1C1, x2C1)), 360.0);

    double caC1 = haC1 - muC1 + (0.004178 * dt);

    double ldC1;
    if (caC1 > 180) {
      ldC1 = caC1 - 360;
    } else if (caC1 < -180) {
      ldC1 = caC1 + 360;
    } else {
      ldC1 = caC1;
    }

    // Azimuth dan Altitude saat kontak C1

    double altC1 = mf.deg(
      math.asin(
        math.sin(mf.rad(piC1)) * math.sin(mf.rad(dC1)) +
            math.cos(mf.rad(piC1)) *
                math.cos(mf.rad(dC1)) *
                math.cos(mf.rad(haC1)),
      ),
    );

    double azmC1 = mf.mod(
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

    final double jdSolarEclipseC1TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + c1TD / 24.0;

    final double jdSolarEclipseC1UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + c1UT / 24.0;

    // Extreme Central Line Limit 2 (C2)

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
          x0 +
          x1 * tC2 +
          x2 * tC2 * tC2 +
          x3 * tC2 * tC2 * tC2 +
          x4 * tC2 * tC2 * tC2 * tC2;

      yC2 =
          y0 +
          y1 * tC2 +
          y2 * tC2 * tC2 +
          y3 * tC2 * tC2 * tC2 +
          y4 * tC2 * tC2 * tC2 * tC2;

      dC2 =
          d0 +
          d1 * tC2 +
          d2 * tC2 * tC2 +
          d3 * tC2 * tC2 * tC2 +
          d4 * tC2 * tC2 * tC2 * tC2;

      muC2 =
          mu0 +
          mu1 * tC2 +
          mu2 * tC2 * tC2 +
          mu3 * tC2 * tC2 * tC2 +
          mu4 * tC2 * tC2 * tC2 * tC2;

      xpC2 = x1 + 2 * x2 * tC2 + 3 * x3 * tC2 * tC2 + 4 * x4 * tC2 * tC2 * tC2;

      ypC2 = y1 + 2 * y2 * tC2 + 3 * y3 * tC2 * tC2 + 4 * y4 * tC2 * tC2 * tC2;

      omC2 =
          1 / math.sqrt(1 - e2 * math.cos(mf.rad(dC2)) * math.cos(mf.rad(dC2)));

      uC2 = xC2;
      vC2 = yC2 * omC2;
      aC2 = xpC2;
      bC2 = ypC2 * omC2;

      n2C2 = aC2 * aC2 + bC2 * bC2;
      nsC2 = math.sqrt(n2C2);

      psC2 = (aC2 * vC2 - uC2 * bC2) / nsC2;

      tuC2 =
          -(uC2 * aC2 + vC2 * bC2) / n2C2 + math.sqrt(1 - psC2 * psC2) / nsC2;

      tC2 = tC2 + tuC2;
    }

    double c2TD = mf.mod(t0 + tC2, 24.0);
    double c2UT = mf.mod(c2TD - dt / 3600.0, 24.0);

    // Koordinat saat kontak C2

    double d1C2 = mf.deg(
      math.atan(math.sin(mf.rad(dC2)) / (math.cos(mf.rad(dC2)) * ba)),
    );

    double rhC2 = math.sqrt(
      math.sin(mf.rad(dC2)) * math.sin(mf.rad(dC2)) +
          (math.cos(mf.rad(dC2)) * ba) * (math.cos(mf.rad(dC2)) * ba),
    );

    double yIC2 = yC2 / rhC2;

    double mIC2 = math.sqrt(xC2 * xC2 + yIC2 * yIC2);

    double x1C2 = xC2 / mIC2;
    double y2C2 = yIC2 / mIC2;

    double pi1C2 = mf.deg(math.asin(y2C2 * math.cos(mf.rad(d1C2))));

    double piC2 = mf.deg(math.atan(ab * math.tan(mf.rad(pi1C2))));

    double x2C2 = -y2C2 * math.sin(mf.rad(dC2));

    double haC2 = mf.mod(mf.deg(math.atan2(x1C2, x2C2)), 360.0);

    double caC2 = haC2 - muC2 + (0.004178 * dt);

    double ldC2;

    if (caC2 > 180) {
      ldC2 = caC2 - 360;
    } else if (caC2 < -180) {
      ldC2 = caC2 + 360;
    } else {
      ldC2 = caC2;
    }

    // Azimuth dan Altitude saat kontak C2

    double altC2 = mf.deg(
      math.asin(
        math.sin(mf.rad(piC2)) * math.sin(mf.rad(dC2)) +
            math.cos(mf.rad(piC2)) *
                math.cos(mf.rad(dC2)) *
                math.cos(mf.rad(haC2)),
      ),
    );

    double azmC2 = mf.mod(
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

    final double jdSolarEclipseC2TD =
        mf.floor(jdEclipse - 0.5) + 0.5 + c2TD / 24.0;

    final double jdSolarEclipseC2UT =
        mf.floor(jdEclipse - 0.5) + 0.5 + c2UT / 24.0;

    //KESIMPULAN

    return {
      "ADA": true,

      "JSE": jse,
      "dt": dt,
      "JDMXTD": jdSolarEclipseMxTD,
      "JDMXUT": jdSolarEclipseMxUT,
      "lbr": wd ?? 0.0,

      // ===== KONTAK PUNCAK =====
      "MX": {
        "MXTD": jdSolarEclipseMxTD,
        "MXUT": jdSolarEclipseMxUT,
        "lmdMX": lmdMx,
        "phiMX": phiMx,
        "azmMX": azmMx,
        "altMX": altMx,
      },

      // ===== KONTAK P1 =====
      "P1": {
        "P1TD": jdSolarEclipseP1TD,
        "P1UT": jdSolarEclipseP1UT,
        "phiP1": piP1,
        "lmdP1": ldP1,
        "azmP1": azmP1,
        "altP1": altP1,
      },

      // ===== KONTAK U1 =====
      "U1": {
        "U1TD": jdSolarEclipseU1TD,
        "U1UT": jdSolarEclipseU1UT,
        "phiU1": piU1,
        "lmdU1": ldU1,
        "azmU1": azmU1,
        "altU1": altU1,
      },

      // ===== KONTAK U2 =====
      "U2": {
        "U2TD": jdSolarEclipseU2TD,
        "U2UT": jdSolarEclipseU2UT,
        "phiU2": piU2,
        "lmdU2": ldU2,
        "azmU2": azmU2,
        "altU2": altU2,
      },

      // ===== KONTAK C1 =====
      "C1": {
        "C1TD": jdSolarEclipseC1TD,
        "C1UT": jdSolarEclipseC1UT,
        "phiC1": piC1,
        "lmdC1": ldC1,
        "azmC1": azmC1,
        "altC1": altC1,
      },

      // ===== KONTAK C2 =====
      "C2": {
        "C2TD": jdSolarEclipseC2TD,
        "C2UT": jdSolarEclipseC2UT,
        "phiC2": piC2,
        "lmdC2": ldC2,
        "azmC2": azmC2,
        "altC2": altC2,
      },

      // ===== KONTAK U3 =====
      "U3": {
        "U3TD": jdSolarEclipseU3TD,
        "U3UT": jdSolarEclipseU3UT,
        "phiU3": piU3,
        "lmdU3": ldU3,
        "azmU3": azmU3,
        "altU3": altU3,
      },

      // ===== KONTAK U4 =====
      "U4": {
        "U4TD": jdSolarEclipseU4TD,
        "U4UT": jdSolarEclipseU4UT,
        "phiU4": piU4,
        "lmdU4": ldU4,
        "azmU4": azmU4,
        "altU4": altU4,
      },

      // ===== KONTAK P2 =====
      "P2": {
        "P2TD": jdSolarEclipseP2TD,
        "P2UT": jdSolarEclipseP2UT,
        "phiP2": piP2,
        "lmdP2": ldP2,
        "azmP2": azmP2,
        "altP2": altP2,
      },

      // ===== KONTAK P3 =====
      "P3": {
        "P3TD": jdSolarEclipseP3TD,
        "P3UT": jdSolarEclipseP3UT,
        "phiP3": piP3,
        "lmdP3": ldP3,
        "azmP3": azmP3,
        "altP3": altP3,
      },

      // ===== KONTAK P4 =====
      "P4": {
        "P4TD": jdSolarEclipseP4TD,
        "P4UT": jdSolarEclipseP4UT,
        "phiP4": piP4,
        "lmdP4": ldP4,
        "azmP4": azmP4,
        "altP4": altP4,
      },

      "MAG": mag,
      "DUR": dur,
    };
  }

  String formatKontakGerhana(Map<String, dynamic> k) {
    final jdTD =
        (k["MXTD"] ??
                k["P1TD"] ??
                k["P2TD"] ??
                k["U1TD"] ??
                k["U2TD"] ??
                k["C1TD"] ??
                k["C2TD"] ??
                k["U3TD"] ??
                k["U4TD"] ??
                k["P3TD"] ??
                k["P4TD"])
            as double;

    final jdUT =
        (k["MXUT"] ??
                k["P1UT"] ??
                k["P2UT"] ??
                k["U1UT"] ??
                k["U2UT"] ??
                k["C1UT"] ??
                k["C2UT"] ??
                k["U3UT"] ??
                k["U4UT"] ??
                k["P3UT"] ??
                k["P4UT"])
            as double;

    final lmd =
        (k["lmdMX"] ??
                k["lmdP1"] ??
                k["lmdP2"] ??
                k["lmdU1"] ??
                k["lmdU2"] ??
                k["lmdC1"] ??
                k["lmdC2"] ??
                k["lmdU3"] ??
                k["lmdU4"] ??
                k["lmdP3"] ??
                k["lmdP4"])
            as double;
    final phi =
        (k["phiMX"] ??
                k["phiP1"] ??
                k["phiP2"] ??
                k["phiU1"] ??
                k["phiU2"] ??
                k["phiC1"] ??
                k["phiC2"] ??
                k["phiU3"] ??
                k["phiU4"] ??
                k["phiP3"] ??
                k["phiP4"])
            as double;
    final azm =
        (k["azmMX"] ??
                k["azmP1"] ??
                k["azmP2"] ??
                k["azmU1"] ??
                k["azmU2"] ??
                k["azmC1"] ??
                k["azmC2"] ??
                k["azmU3"] ??
                k["azmU4"] ??
                k["azmP3"] ??
                k["azmP4"])
            as double;
    final alt =
        (k["altMX"] ??
                k["altP1"] ??
                k["altP2"] ??
                k["altU1"] ??
                k["altU2"] ??
                k["altC1"] ??
                k["altC2"] ??
                k["altU3"] ??
                k["altU4"] ??
                k["altP3"] ??
                k["altP4"])
            as double;

    return """
${julianDay.jdkm(jdTD)}
Jam TD   : ${mf.dhhms(double.parse(julianDay.jdkm(jdTD, 0, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 1)}
Jam UT   : ${mf.dhhms(double.parse(julianDay.jdkm(jdUT, 0, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 1)}
Bujur    : ${mf.dddms(lmd, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}
Lintang  : ${mf.dddms(phi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}
Azimuth  : ${mf.dddms(azm, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}
Altitude : ${mf.dddms(alt, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}
""";
  }
}
