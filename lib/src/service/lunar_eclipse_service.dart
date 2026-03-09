import 'dart:math' as math;
import 'package:myhisab/src/core/astronomy/dynamical_time.dart';
import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/math/math_utils.dart';
import 'package:myhisab/src/core/astronomy/moon_function.dart';
import 'package:myhisab/src/core/astronomy/sun_function.dart';
import 'package:myhisab/src/model/lunar_eclipse/lunar_besselian_result.dart';
import 'package:myhisab/src/model/lunar_eclipse/lunar_eclipse_global_result.dart';
import 'package:myhisab/src/model/lunar_eclipse/lunar_eclipse_local_result.dart';
import 'package:myhisab/src/model/lunar_eclipse/lunar_eclipse_global_range_result.dart';
import 'package:myhisab/src/model/lunar_eclipse/lunar_eclipse_local_range_result.dart';
import 'package:myhisab/src/core/astronomy/time_scale.dart';
import 'package:myhisab/src/model/helper_eclipse/helper_eclipse.dart';

class LunarEclipseService {
  final julDay = JulianDay();
  final dyTme = DynamicalTime();

  final sn = SunFunction();
  final mf = MathFunction();
  final mo = MoonFunction();

  LunarBesselianResult? lBesselian(int blnH, int thnH) {
    final jdEclipse1 = mo.jdeEclipseModified(blnH, thnH, 2);
    if (jdEclipse1 <= 0) return null;

    final jdEclipse2 =
        mf.floor(jdEclipse1) +
        (((jdEclipse1 - mf.floor(jdEclipse1)) * 24).roundToDouble() / 24.0);

    final t0 = mf.mod(
      (((jdEclipse2 + 0.5) - mf.floor(jdEclipse2 + 0.5)) * 24).roundToDouble(),
      24.0,
    );

    final dT = dyTme.deltaT(jdEclipse2);

    // ---------------- Data Matahari ----------------
    final aRsM2 = sn.sunGeocentricRightAscension(jdEclipse2 - 2 / 24, 0);
    final aRsM1 = sn.sunGeocentricRightAscension(jdEclipse2 - 1 / 24, 0);
    final aRs00 = sn.sunGeocentricRightAscension(jdEclipse2, 0);
    final aRsP1 = sn.sunGeocentricRightAscension(jdEclipse2 + 1 / 24, 0);
    final aRsP2 = sn.sunGeocentricRightAscension(jdEclipse2 + 2 / 24, 0);

    final dsM2 = sn.sunGeocentricDeclination(jdEclipse2 - 2 / 24, 0);
    final dsM1 = sn.sunGeocentricDeclination(jdEclipse2 - 1 / 24, 0);
    final ds00 = sn.sunGeocentricDeclination(jdEclipse2, 0);
    final dsP1 = sn.sunGeocentricDeclination(jdEclipse2 + 1 / 24, 0);
    final dsP2 = sn.sunGeocentricDeclination(jdEclipse2 + 2 / 24, 0);

    final ssM2 = sn.sunGeocentricSemidiameter(jdEclipse2 - 2 / 24, 0);
    final ssM1 = sn.sunGeocentricSemidiameter(jdEclipse2 - 1 / 24, 0);
    final ss00 = sn.sunGeocentricSemidiameter(jdEclipse2, 0);
    final ssP1 = sn.sunGeocentricSemidiameter(jdEclipse2 + 1 / 24, 0);
    final ssP2 = sn.sunGeocentricSemidiameter(jdEclipse2 + 2 / 24, 0);

    final hpsM2 = sn.sunEquatorialHorizontalParallax(jdEclipse2 - 2 / 24, 0);
    final hpsM1 = sn.sunEquatorialHorizontalParallax(jdEclipse2 - 1 / 24, 0);
    final hps00 = sn.sunEquatorialHorizontalParallax(jdEclipse2, 0);
    final hpsP1 = sn.sunEquatorialHorizontalParallax(jdEclipse2 + 1 / 24, 0);
    final hpsP2 = sn.sunEquatorialHorizontalParallax(jdEclipse2 + 2 / 24, 0);

    // ---------------- Data Bulan ----------------
    final aRmM2 = mo.moonGeocentricRightAscension(jdEclipse2 - 2 / 24, 0);
    final aRmM1 = mo.moonGeocentricRightAscension(jdEclipse2 - 1 / 24, 0);
    final aRm00 = mo.moonGeocentricRightAscension(jdEclipse2, 0);
    final aRmP1 = mo.moonGeocentricRightAscension(jdEclipse2 + 1 / 24, 0);
    final aRmP2 = mo.moonGeocentricRightAscension(jdEclipse2 + 2 / 24, 0);

    final dmM2 = mo.moonGeocentricDeclination(jdEclipse2 - 2 / 24, 0);
    final dmM1 = mo.moonGeocentricDeclination(jdEclipse2 - 1 / 24, 0);
    final dm00 = mo.moonGeocentricDeclination(jdEclipse2, 0);
    final dmP1 = mo.moonGeocentricDeclination(jdEclipse2 + 1 / 24, 0);
    final dmP2 = mo.moonGeocentricDeclination(jdEclipse2 + 2 / 24, 0);

    final smM2 = mo.moonGeocentricSemidiameter(jdEclipse2 - 2 / 24, 0);
    final smM1 = mo.moonGeocentricSemidiameter(jdEclipse2 - 1 / 24, 0);
    final sm00 = mo.moonGeocentricSemidiameter(jdEclipse2, 0);
    final smP1 = mo.moonGeocentricSemidiameter(jdEclipse2 + 1 / 24, 0);
    final smP2 = mo.moonGeocentricSemidiameter(jdEclipse2 + 2 / 24, 0);

    final muM2 = mo.moonGeocentricGreenwichHourAngle(jdEclipse2 - 2 / 24, 0);
    final muM1 = mo.moonGeocentricGreenwichHourAngle(jdEclipse2 - 1 / 24, 0);
    final mu00 = mo.moonGeocentricGreenwichHourAngle(jdEclipse2, 0);
    final muP1 = mo.moonGeocentricGreenwichHourAngle(jdEclipse2 + 1 / 24, 0);
    final muP2 = mo.moonGeocentricGreenwichHourAngle(jdEclipse2 + 2 / 24, 0);

    final hpmM2 = mo
        .moonEquatorialHorizontalParallax(jdEclipse2 - 2 / 24, 0)
        .toDouble();
    final hpmM1 = mo
        .moonEquatorialHorizontalParallax(jdEclipse2 - 1 / 24, 0)
        .toDouble();
    final hpm00 = mo.moonEquatorialHorizontalParallax(jdEclipse2, 0).toDouble();
    final hpmP1 = mo
        .moonEquatorialHorizontalParallax(jdEclipse2 + 1 / 24, 0)
        .toDouble();
    final hpmP2 = mo
        .moonEquatorialHorizontalParallax(jdEclipse2 + 2 / 24, 0)
        .toDouble();

    // -----Transformasi Equatorial ke Rektangular/Kartesius 3d: (x,y,z)-----
    final aM2 = mf.mod(aRsM2 + 180, 360);
    final aM1 = mf.mod(aRsM1 + 180, 360);
    final a00 = mf.mod(aRs00 + 180, 360);
    final aP1 = mf.mod(aRsP1 + 180, 360);
    final aP2 = mf.mod(aRsP2 + 180, 360);

    final dM2 = -dsM2;
    final dM1 = -dsM1;
    final d00 = -ds00;
    final dP1 = -dsP1;
    final dP2 = -dsP2;

    double e(double aRm, double a, double d) =>
        0.25 * (aRm - a) * math.sin(mf.rad(2 * d)) * math.sin(mf.rad(aRm - a));

    final eM2 = e(aRmM2, aM2, dM2);
    final eM1 = e(aRmM1, aM1, dM1);
    final e00 = e(aRm00, a00, d00);
    final eP1 = e(aRmP1, aP1, dP1);
    final eP2 = e(aRmP2, aP2, dP2);

    double f1(double hpm, double hps, double ss) => 1.01 * hpm + hps + ss;
    double f2(double hpm, double hps, double ss) => 1.01 * hpm + hps - ss;

    final f1M2 = f1(hpmM2, hpsM2, ssM2);
    final f1M1 = f1(hpmM1, hpsM1, ssM1);
    final f100 = f1(hpm00, hps00, ss00);
    final f1P1 = f1(hpmP1, hpsP1, ssP1);
    final f1P2 = f1(hpmP2, hpsP2, ssP2);

    final f2M2 = f2(hpmM2, hpsM2, ssM2);
    final f2M1 = f2(hpmM1, hpsM1, ssM1);
    final f200 = f2(hpm00, hps00, ss00);
    final f2P1 = f2(hpmP1, hpsP1, ssP1);
    final f2P2 = f2(hpmP2, hpsP2, ssP2);

    double x(double aRm, double a, double dm) =>
        (aRm - a) * math.cos(mf.rad(dm));

    double y(double dm, double d, double e) => dm - d + e;

    final xM2 = x(aRmM2, aM2, dmM2);
    final xM1 = x(aRmM1, aM1, dmM1);
    final x00 = x(aRm00, a00, dm00);
    final xP1 = x(aRmP1, aP1, dmP1);
    final xP2 = x(aRmP2, aP2, dmP2);

    final yM2 = y(dmM2, dM2, eM2);
    final yM1 = y(dmM1, dM1, eM1);
    final y00 = y(dm00, d00, e00);
    final yP1 = y(dmP1, dP1, eP1);
    final yP2 = y(dmP2, dP2, eP2);

    return LunarBesselianResult(
      jde: jdEclipse2,
      deltaT: dT,
      t0: t0,

      x: [
        mf.interp5(xM2, xM1, x00, xP1, xP2, 0),
        mf.interp5(xM2, xM1, x00, xP1, xP2, 1),
        mf.interp5(xM2, xM1, x00, xP1, xP2, 2),
        mf.interp5(xM2, xM1, x00, xP1, xP2, 3),
        mf.interp5(xM2, xM1, x00, xP1, xP2, 4),
      ],

      y: [
        mf.interp5(yM2, yM1, y00, yP1, yP2, 0),
        mf.interp5(yM2, yM1, y00, yP1, yP2, 1),
        mf.interp5(yM2, yM1, y00, yP1, yP2, 2),
        mf.interp5(yM2, yM1, y00, yP1, yP2, 3),
        mf.interp5(yM2, yM1, y00, yP1, yP2, 4),
      ],

      f1: [
        mf.interp5(f1M2, f1M1, f100, f1P1, f1P2, 0),
        mf.interp5(f1M2, f1M1, f100, f1P1, f1P2, 1),
        mf.interp5(f1M2, f1M1, f100, f1P1, f1P2, 2),
        mf.interp5(f1M2, f1M1, f100, f1P1, f1P2, 3),
        mf.interp5(f1M2, f1M1, f100, f1P1, f1P2, 4),
      ],

      f2: [
        mf.interp5(f2M2, f2M1, f200, f2P1, f2P2, 0),
        mf.interp5(f2M2, f2M1, f200, f2P1, f2P2, 1),
        mf.interp5(f2M2, f2M1, f200, f2P1, f2P2, 2),
        mf.interp5(f2M2, f2M1, f200, f2P1, f2P2, 3),
        mf.interp5(f2M2, f2M1, f200, f2P1, f2P2, 4),
      ],

      sm: [
        mf.interp5(smM2, smM1, sm00, smP1, smP2, 0),
        mf.interp5(smM2, smM1, sm00, smP1, smP2, 1),
        mf.interp5(smM2, smM1, sm00, smP1, smP2, 2),
        mf.interp5(smM2, smM1, sm00, smP1, smP2, 3),
        mf.interp5(smM2, smM1, sm00, smP1, smP2, 4),
      ],

      mu: [
        mf.interp5(muM2, muM1, mu00, muP1, muP2, 0),
        mf.interp5(muM2, muM1, mu00, muP1, muP2, 1),
        mf.interp5(muM2, muM1, mu00, muP1, muP2, 2),
        mf.interp5(muM2, muM1, mu00, muP1, muP2, 3),
        mf.interp5(muM2, muM1, mu00, muP1, muP2, 4),
      ],

      hp: [
        mf.interp5(hpmM2, hpmM1, hpm00, hpmP1, hpmP2, 0),
        mf.interp5(hpmM2, hpmM1, hpm00, hpmP1, hpmP2, 1),
        mf.interp5(hpmM2, hpmM1, hpm00, hpmP1, hpmP2, 2),
        mf.interp5(hpmM2, hpmM1, hpm00, hpmP1, hpmP2, 3),
        mf.interp5(hpmM2, hpmM1, hpm00, hpmP1, hpmP2, 4),
      ],

      d: [
        mf.interp5(dM2, dM1, d00, dP1, dP2, 0),
        mf.interp5(dM2, dM1, d00, dP1, dP2, 1),
        mf.interp5(dM2, dM1, d00, dP1, dP2, 2),
        mf.interp5(dM2, dM1, d00, dP1, dP2, 3),
        mf.interp5(dM2, dM1, d00, dP1, dP2, 4),
      ],

      dm: [
        mf.interp5(dmM2, dmM1, dm00, dmP1, dmP2, 0),
        mf.interp5(dmM2, dmM1, dm00, dmP1, dmP2, 1),
        mf.interp5(dmM2, dmM1, dm00, dmP1, dmP2, 2),
        mf.interp5(dmM2, dmM1, dm00, dmP1, dmP2, 3),
        mf.interp5(dmM2, dmM1, dm00, dmP1, dmP2, 4),
      ],
    );
  }

  LunarEclipseLocalResult? lunarEclipseLocal({
    required int blnH,
    required int thnH,
    required double gLon,
    required double gLat,
    required double elev,
    required double pres,
    required double temp,
    required double tmZn,
  }) {
    final bessel = lBesselian(blnH, thnH);
    if (bessel == null || !bessel.isValid) return null;

    final dt = bessel.deltaT;
    final jdE2 = bessel.jde;
    final t0 = bessel.t0;

    final x = bessel.x;
    final y = bessel.y;
    final f1c = bessel.f1;
    final f2c = bessel.f2;
    final smc = bessel.sm;

    double t = 0.0;
    double tx = 0.0;

    double? xVal, yVal, xDer, yDer, f1, f2, sm;

    // =====================================
    // ITERASI TENGAH GERHANA
    // =====================================

    for (int i = 0; i < 3; i++) {
      t += tx;

      final t2 = t * t;
      final t3 = t2 * t;
      final t4 = t2 * t2;

      xVal = x[0] + x[1] * t + x[2] * t2 + x[3] * t3 + x[4] * t4;
      yVal = y[0] + y[1] * t + y[2] * t2 + y[3] * t3 + y[4] * t4;

      xDer = x[1] + 2 * x[2] * t + 3 * x[3] * t2 + 4 * x[4] * t3;
      yDer = y[1] + 2 * y[2] * t + 3 * y[3] * t2 + 4 * y[4] * t3;

      f1 = f1c[0] + f1c[1] * t + f1c[2] * t2 + f1c[3] * t3 + f1c[4] * t4;
      f2 = f2c[0] + f2c[1] * t + f2c[2] * t2 + f2c[3] * t3 + f2c[4] * t4;
      sm = smc[0] + smc[1] * t + smc[2] * t2 + smc[3] * t3 + smc[4] * t4;

      final n2 = xDer * xDer + yDer * yDer;
      if (n2 == 0.0) return null;

      tx = -(xVal * xDer + yVal * yDer) / n2;
    }

    if (xVal == null ||
        yVal == null ||
        xDer == null ||
        yDer == null ||
        f1 == null ||
        f2 == null ||
        sm == null) {
      return null;
    }

    final n = math.sqrt(xDer * xDer + yDer * yDer);
    if (n == 0.0) return null;

    final d = math.sqrt(xVal * xVal + yVal * yVal);

    final l1 = f1 + sm;
    final l2 = f2 + sm;
    final l3 = f2 - sm;

    final testP = l1 * l1 - d * d;
    if (testP <= 0) return null;

    final testU = l2 * l2 - d * d;
    final testT = l3 * l3 - d * d;

    final hasUmbral = testU > 0;
    final hasTotal = testT > 0;

    final double? tm1 = testP > 0 ? math.sqrt(testP) / n : null;
    final tm2 = hasUmbral ? math.sqrt(testU) / n : null;
    final tm3 = hasTotal ? math.sqrt(testT) / n : null;

    // =====================================
    // KONVERSI JD
    // =====================================

    final jdBase = mf.floor(jdE2 + 0.5) - 0.5;
    final mx = jdBase + ((t0 + t) / 24) - dt / 86400;

    double? p1, p4, u1, u2, u3, u4;

    if (tm1 != null) {
      p1 = jdBase + ((t0 + t - tm1) / 24) - dt / 86400;
      p4 = jdBase + ((t0 + t + tm1) / 24) - dt / 86400;
    }

    if (tm2 != null) {
      u1 = jdBase + ((t0 + t - tm2) / 24) - dt / 86400;
      u4 = jdBase + ((t0 + t + tm2) / 24) - dt / 86400;
    }

    if (tm3 != null) {
      u2 = jdBase + ((t0 + t - tm3) / 24) - dt / 86400;
      u3 = jdBase + ((t0 + t + tm3) / 24) - dt / 86400;
    }

    // =====================================
    // DURASI
    // =====================================

    final durP = tm1 != null ? 2 * tm1 : null;
    final durU = tm2 != null ? 2 * tm2 : null;
    final durT = tm3 != null ? 2 * tm3 : null;

    // =====================================
    // MAGNITUDE
    // =====================================

    final magPen = (l1 - d) / (2 * sm);
    final magUmb = hasUmbral ? (l2 - d) / (2 * sm) : null;

    final radPen = l1 - sm;
    final radUmb = hasUmbral ? (l2 - sm) : null;

    final jenis = hasTotal
        ? "GERHANA BULAN TOTAL"
        : hasUmbral
        ? "GERHANA BULAN SEBAGIAN"
        : "GERHANA BULAN PENUMBRAL";

    final mo = MoonFunction();
    final sn = SunFunction();

    // =====================================
    // AZIMUTH & ALTITUDE (pakai pres & temp)
    // =====================================

    double? alt(double? jd) => jd == null
        ? null
        : mo.moonTopocentricAltitude(
            jd,
            dt,
            gLon,
            gLat,
            elev,
            pres,
            temp,
            'htoc',
          );

    double? az(double? jd) =>
        jd == null ? null : mo.moonTopocentricAzimuth(jd, dt, gLon, gLat, elev);

    final azmP1 = az(p1);
    final azmU1 = az(u1);
    final azmU2 = az(u2);
    final azmMax = az(mx);
    final azmU3 = az(u3);
    final azmU4 = az(u4);
    final azmP4 = az(p4);

    final altP1 = alt(p1);
    final altU1 = alt(u1);
    final altU2 = alt(u2);
    final altMax = alt(mx);
    final altU3 = alt(u3);
    final altU4 = alt(u4);
    final altP4 = alt(p4);

    // =====================================
    // DATA EPHEMERIS SAAT PUNCAK
    // =====================================

    double? safe(double? v) {
      if (v == null) return null;
      if (v.isNaN || v.isInfinite) return null;
      return v;
    }

    EclipseEphemerisBody? sunData;
    EclipseEphemerisBody? moonData;

    if (mx.isFinite) {
      final raS = safe(sn.sunGeocentricRightAscension(mx, 0));
      final dcS = safe(sn.sunGeocentricDeclination(mx, 0));
      final sdS = safe(sn.sunGeocentricSemidiameter(mx, 0));
      final hpS = safe(sn.sunEquatorialHorizontalParallax(mx, 0));

      final raM = safe(mo.moonGeocentricRightAscension(mx, 0));
      final dcM = safe(mo.moonGeocentricDeclination(mx, 0));
      final sdM = safe(mo.moonGeocentricSemidiameter(mx, 0));
      final hpM = safe(mo.moonEquatorialHorizontalParallax(mx, 0));

      sunData = EclipseEphemerisBody(
        ra: raS != null ? raS / 15.0 : null, // konversi ke jam
        dec: dcS,
        sd: sdS,
        hp: hpS,
      );

      moonData = EclipseEphemerisBody(
        ra: raM != null ? raM / 15.0 : null, // konversi ke jam
        dec: dcM,
        sd: sdM,
        hp: hpM,
      );
    }

    // =====================================
    // RETURN
    // =====================================

    return LunarEclipseLocalResult(
      isValid: true,
      ada: true,

      p1: p1,
      u1: u1,
      u2: u2,
      mx: mx,
      u3: u3,
      u4: u4,
      p4: p4,

      azmP1: azmP1,
      azmU1: azmU1,
      azmU2: azmU2,
      azmMx: azmMax,
      azmU3: azmU3,
      azmU4: azmU4,
      azmP4: azmP4,

      altP1: altP1,
      altU1: altU1,
      altU2: altU2,
      altMx: altMax,
      altU3: altU3,
      altU4: altU4,
      altP4: altP4,

      durasiPenumbral: durP,
      durasiUmbral: durU,
      durasiTotal: durT,
      magnitudePenumbral: magPen,
      magnitudeUmbral: magUmb,
      radiusPenumbral: radPen,
      radiusUmbral: radUmb,

      sun: sunData,
      moon: moonData,

      jenis: jenis,
    );
  }

  LunarEclipseGlobalResult? lunarEclipseGlobal({
    required int blnH,
    required int thnH,
  }) {
    final bessel = lBesselian(blnH, thnH);
    if (bessel == null || !bessel.isValid) return null;

    final dt = bessel.deltaT;
    final jdE2 = bessel.jde;
    final t0 = bessel.t0;

    final x = bessel.x;
    final y = bessel.y;
    final f1c = bessel.f1;
    final f2c = bessel.f2;
    final smc = bessel.sm;

    double t = 0.0;
    double tx = 0.0;

    double? xVal, yVal, xDer, yDer, f1, f2, sm;

    // =====================================
    // ITERASI TENGAH GERHANA
    // =====================================

    for (int i = 0; i < 3; i++) {
      t += tx;

      final t2 = t * t;
      final t3 = t2 * t;
      final t4 = t2 * t2;

      xVal = x[0] + x[1] * t + x[2] * t2 + x[3] * t3 + x[4] * t4;
      yVal = y[0] + y[1] * t + y[2] * t2 + y[3] * t3 + y[4] * t4;

      xDer = x[1] + 2 * x[2] * t + 3 * x[3] * t2 + 4 * x[4] * t3;
      yDer = y[1] + 2 * y[2] * t + 3 * y[3] * t2 + 4 * y[4] * t3;

      f1 = f1c[0] + f1c[1] * t + f1c[2] * t2 + f1c[3] * t3 + f1c[4] * t4;
      f2 = f2c[0] + f2c[1] * t + f2c[2] * t2 + f2c[3] * t3 + f2c[4] * t4;
      sm = smc[0] + smc[1] * t + smc[2] * t2 + smc[3] * t3 + smc[4] * t4;

      final n2 = xDer * xDer + yDer * yDer;
      if (n2 == 0.0) return null;

      tx = -(xVal * xDer + yVal * yDer) / n2;
    }

    if (xVal == null ||
        yVal == null ||
        xDer == null ||
        yDer == null ||
        f1 == null ||
        f2 == null ||
        sm == null) {
      return null;
    }

    final n = math.sqrt(xDer * xDer + yDer * yDer);
    if (n == 0.0) return null;

    final d = math.sqrt(xVal * xVal + yVal * yVal);

    final l1 = f1 + sm;
    final l2 = f2 + sm;
    final l3 = f2 - sm;

    final testP = l1 * l1 - d * d;
    if (testP <= 0) return null;

    final testU = l2 * l2 - d * d;
    final testT = l3 * l3 - d * d;

    final hasUmbral = testU > 0;
    final hasTotal = testT > 0;

    final double? tm1 = testP > 0 ? math.sqrt(testP) / n : null;
    final tm2 = hasUmbral ? math.sqrt(testU) / n : null;
    final tm3 = hasTotal ? math.sqrt(testT) / n : null;

    // =====================================
    // KONVERSI JD
    // =====================================

    final jdBase = mf.floor(jdE2 + 0.5) - 0.5;
    final mx = jdBase + ((t0 + t) / 24) - dt / 86400;

    double? p1, p4, u1, u2, u3, u4;

    if (tm1 != null) {
      p1 = jdBase + ((t0 + t - tm1) / 24) - dt / 86400;
      p4 = jdBase + ((t0 + t + tm1) / 24) - dt / 86400;
    }

    if (tm2 != null) {
      u1 = jdBase + ((t0 + t - tm2) / 24) - dt / 86400;
      u4 = jdBase + ((t0 + t + tm2) / 24) - dt / 86400;
    }

    if (tm3 != null) {
      u2 = jdBase + ((t0 + t - tm3) / 24) - dt / 86400;
      u3 = jdBase + ((t0 + t + tm3) / 24) - dt / 86400;
    }

    // =====================================
    // DURASI
    // =====================================

    final durP = tm1 != null ? 2 * tm1 : null;
    final durU = tm2 != null ? 2 * tm2 : null;
    final durT = tm3 != null ? 2 * tm3 : null;

    // =====================================
    // MAGNITUDE
    // =====================================

    final magPen = (l1 - d) / (2 * sm);
    final magUmb = hasUmbral ? (l2 - d) / (2 * sm) : null;

    final radPen = l1 - sm;
    final radUmb = hasUmbral ? (l2 - sm) : null;

    String jenis;

    if (hasTotal) {
      jenis = "GERHANA BULAN TOTAL";
    } else if (hasUmbral) {
      jenis = "GERHANA BULAN SEBAGIAN";
    } else {
      jenis = "GERHANA BULAN PENUMBRAL";
    }

    // =====================================
    // DATA EPHEMERIS SAAT PUNCAK
    // =====================================

    double? safe(double? v) {
      if (v == null) return null;
      if (v.isNaN || v.isInfinite) return null;
      return v;
    }

    EclipseEphemerisBody? sunData;
    EclipseEphemerisBody? moonData;

    if (mx.isFinite) {
      final raS = safe(sn.sunGeocentricRightAscension(mx, 0));
      final dcS = safe(sn.sunGeocentricDeclination(mx, 0));
      final sdS = safe(sn.sunGeocentricSemidiameter(mx, 0));
      final hpS = safe(sn.sunEquatorialHorizontalParallax(mx, 0));

      final raM = safe(mo.moonGeocentricRightAscension(mx, 0));
      final dcM = safe(mo.moonGeocentricDeclination(mx, 0));
      final sdM = safe(mo.moonGeocentricSemidiameter(mx, 0));
      final hpM = safe(mo.moonEquatorialHorizontalParallax(mx, 0));

      sunData = EclipseEphemerisBody(
        ra: raS != null ? raS / 15.0 : null, // konversi ke jam
        dec: dcS,
        sd: sdS,
        hp: hpS,
      );

      moonData = EclipseEphemerisBody(
        ra: raM != null ? raM / 15.0 : null, // konversi ke jam
        dec: dcM,
        sd: sdM,
        hp: hpM,
      );
    }

    // =====================================
    // RETURN
    // =====================================

    return LunarEclipseGlobalResult(
      isValid: true,

      p1: p1,
      u1: u1,
      u2: u2,
      mx: mx,
      u3: u3,
      u4: u4,
      p4: p4,

      durasiPenumbral: durP,
      durasiUmbral: durU,
      durasiTotal: durT,
      magnitudePenumbral: magPen,
      magnitudeUmbral: magUmb,
      radiusPenumbral: radPen,
      radiusUmbral: radUmb,

      sun: sunData,
      moon: moonData,

      jenis: jenis,
    );
  }

  //HISAB GERHANA BULAN GLOBAL PER RENTANG TAHUN

  List<LunarEclipseGlobalSummary> lunarEclipseGlobalRangeHijri({
    required int tahunAwalH,
    required int tahunAkhirH,
  }) {
    final List<LunarEclipseGlobalSummary> hasil = [];

    for (int thn = tahunAwalH; thn <= tahunAkhirH; thn++) {
      for (int bln = 1; bln <= 12; bln++) {
        final eclipse = lunarEclipseGlobal(blnH: bln, thnH: thn);

        if (eclipse == null || eclipse.isValid != true) continue;

        hasil.add(
          LunarEclipseGlobalSummary(
            tahunHijri: thn,
            bulanHijri: bln,
            p1: eclipse.p1,
            u1: eclipse.u1,
            u2: eclipse.u2,
            mx: eclipse.mx,
            u3: eclipse.u3,
            u4: eclipse.u4,
            p4: eclipse.p4,

            durasiUmbral: eclipse.durasiUmbral,
            durasiPenumbral: eclipse.durasiPenumbral,

            jenis: eclipse.jenis,
          ),
        );
      }
    }

    return hasil;
  }

  List<LunarEclipseLocalSummary> lunarEclipseLocalRangeHijri({
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
    final List<LunarEclipseLocalSummary> hasil = [];

    for (int thn = tahunAwalH; thn <= tahunAkhirH; thn++) {
      for (int bln = 1; bln <= 12; bln++) {
        final eclipse = lunarEclipseLocal(
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

        final p1 = convert(eclipse.p1);
        final u1 = convert(eclipse.u1);
        final u2 = convert(eclipse.u2);
        final mx = convert(eclipse.mx);
        final u3 = convert(eclipse.u3);
        final u4 = convert(eclipse.u4);
        final p4 = convert(eclipse.p4);

        hasil.add(
          LunarEclipseLocalSummary(
            tahunHijri: thn,
            bulanHijri: bln,
            p1: p1,
            u1: u1,
            u2: u2,
            mx: mx,
            u3: u3,
            u4: u4,
            p4: p4,

            // altitude TIDAK ikut timeScale
            altP1: eclipse.p1,
            altU1: eclipse.u1,
            altU2: eclipse.u2,
            altMx: eclipse.mx,
            altU3: eclipse.u3,
            altU4: eclipse.u4,
            altP4: eclipse.p4,

            durasiUmbral: eclipse.durasiUmbral,
            durasiPenumbral: eclipse.durasiPenumbral,
            jenis: eclipse.jenis,
          ),
        );
      }
    }

    return hasil;
  }
}
