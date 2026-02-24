import 'dart:math';
import '../astronomy/julian_day.dart';
import '../math/math_utils.dart';
import '../astronomy/dynamical_time.dart';
import '../astronomy/sun_function.dart';

import 'package:myhisab/src/model/salat_status.dart';
import 'package:myhisab/src/model/salat_value.dart';

class WaktuSalat {
  final julianDay = JulianDay();
  final mf = MathFunction();
  final dt = DynamicalTime();
  final sn = SunFunction();

  // ==========================
  // ZUHUR
  // ==========================
  SalatValue zuhur(int tglM, int blnM, int thnM, double gLon, double tmZn) {
    double zhr = 12.0;

    for (int i = 1; i <= 3; i++) {
      final jd = julianDay.kmjd(tglM, blnM, thnM, zhr, tmZn);
      final jde = jd + (dt.deltaT(jd) / 86400);
      final eoT = sn.equationOfTime(jde, 0.0);
      final kwd = (gLon - (tmZn * 15.0)) / 15.0;

      zhr = 12 - eoT - kwd;
    }

    return SalatValue(time: zhr, status: SalatStatus.normal);
  }

  // ==========================
  // ASAR
  // ==========================
  SalatValue asar(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double tmZn,
  ) {
    double asr = 15.0;

    for (int i = 1; i <= 3; i++) {
      final jd = julianDay.kmjd(tglM, blnM, thnM, asr, tmZn);
      final jde = jd + (dt.deltaT(jd) / 86400);
      final eoT = sn.equationOfTime(jde, 0.0);
      final dec = sn.sunGeocentricDeclination(jde, 0.0);
      final kwd = (gLon - (tmZn * 15.0)) / 15.0;

      final zm = (gLat - dec).abs();
      final hm = mf.deg(atan(1 / (tan(mf.rad(zm)) + 1)));

      final cost = -tan(mf.rad(gLat)) * tan(mf.rad(dec));

      final costm =
          cost + sin(mf.rad(hm)) / cos(mf.rad(gLat)) / cos(mf.rad(dec));

      if (cost < -1) {
        return const SalatValue(time: null, status: SalatStatus.up);
      }

      if (cost > 1) {
        return const SalatValue(time: null, status: SalatStatus.down);
      }

      final tm = mf.deg(acos(costm));
      asr = (12 - eoT) + tm / 15.0 - kwd;
    }

    return SalatValue(time: asr, status: SalatStatus.normal);
  }

  // ==========================
  // MAGRIB
  // ==========================
  SalatValue magrib(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double elev,
    double tmZn,
  ) {
    double mgr = 18.0;

    for (int i = 1; i <= 3; i++) {
      final jd = julianDay.kmjd(tglM, blnM, thnM, mgr, tmZn);
      final jde = jd + (dt.deltaT(jd) / 86400.0);
      final eoT = sn.equationOfTime(jde, 0.0);
      final dec = sn.sunGeocentricDeclination(jde, 0.0);
      final sd = sn.sunGeocentricSemidiameter(jde, 0.0);
      final kwd = (gLon - (tmZn * 15.0)) / 15.0;

      final dip = 1.76 / 60.0 * sqrt(elev);
      final hm = -(sd + 34.5 / 60.0 + dip);

      final costm =
          -tan(mf.rad(gLat)) * tan(mf.rad(dec)) +
          sin(mf.rad(hm)) / cos(mf.rad(gLat)) / cos(mf.rad(dec));

      if (costm < -1) {
        return const SalatValue(time: null, status: SalatStatus.up);
      }

      if (costm > 1) {
        return const SalatValue(time: null, status: SalatStatus.down);
      }

      final tm = mf.deg(acos(costm));
      mgr = 12 - eoT + tm / 15.0 - kwd;
    }

    return SalatValue(time: mgr, status: SalatStatus.normal);
  }

  // ==========================
  // ISYA
  // ==========================
  SalatValue isya(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double tmZn,
  ) {
    double isy = 19.0;

    for (int i = 1; i <= 3; i++) {
      final jd = julianDay.kmjd(tglM, blnM, thnM, isy, tmZn);
      final jde = jd + (dt.deltaT(jd) / 86400.0);
      final eoT = sn.equationOfTime(jde, 0.0);
      final dec = sn.sunGeocentricDeclination(jde, 0.0);
      final kwd = (gLon - (tmZn * 15.0)) / 15.0;

      const hm = -18.0;

      final costm =
          -tan(mf.rad(gLat)) * tan(mf.rad(dec)) +
          sin(mf.rad(hm)) / cos(mf.rad(gLat)) / cos(mf.rad(dec));

      if (costm < -1) {
        return const SalatValue(time: null, status: SalatStatus.bright);
      }

      if (costm > 1) {
        return const SalatValue(time: null, status: SalatStatus.dark);
      }

      final tm = mf.deg(acos(costm));
      isy = 12 - eoT + tm / 15.0 - kwd;
    }

    return SalatValue(time: isy, status: SalatStatus.normal);
  }

  // ==========================
  // SUBUH
  // ==========================
  SalatValue subuh(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double tmZn,
  ) {
    double sbh = 4.0;

    for (int i = 1; i <= 3; i++) {
      final jd = julianDay.kmjd(tglM, blnM, thnM, sbh, tmZn);
      final jde = jd + (dt.deltaT(jd) / 86400.0);
      final eoT = sn.equationOfTime(jde, 0.0);
      final dec = sn.sunGeocentricDeclination(jde, 0.0);
      final kwd = (gLon - (tmZn * 15.0)) / 15.0;

      const hm = -20.0;

      final costm =
          -tan(mf.rad(gLat)) * tan(mf.rad(dec)) +
          sin(mf.rad(hm)) / cos(mf.rad(gLat)) / cos(mf.rad(dec));

      if (costm < -1) {
        return const SalatValue(time: null, status: SalatStatus.bright);
      }

      if (costm > 1) {
        return const SalatValue(time: null, status: SalatStatus.dark);
      }

      final tm = mf.deg(acos(costm));
      sbh = 12 - eoT - tm / 15.0 - kwd;
    }

    return SalatValue(time: sbh, status: SalatStatus.normal);
  }

  SalatValue syuruk(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double elev,
    double tmZn,
  ) {
    double syk = 6.0;

    for (int i = 1; i <= 3; i++) {
      final jd = julianDay.kmjd(tglM, blnM, thnM, syk, tmZn);
      final jde = jd + (dt.deltaT(jd) / 86400.0);
      final eoT = sn.equationOfTime(jde, 0.0);
      final dec = sn.sunGeocentricDeclination(jde, 0.0);
      final sd = sn.sunGeocentricSemidiameter(jde, 0.0);
      final kwd = (gLon - (tmZn * 15.0)) / 15.0;

      final dip = 1.76 / 60.0 * sqrt(elev);
      final hm = -(sd + 34.5 / 60.0 + dip);

      final costm =
          -tan(mf.rad(gLat)) * tan(mf.rad(dec)) +
          sin(mf.rad(hm)) / cos(mf.rad(gLat)) / cos(mf.rad(dec));

      if (costm < -1) {
        return const SalatValue(time: null, status: SalatStatus.up);
      }

      if (costm > 1) {
        return const SalatValue(time: null, status: SalatStatus.down);
      }

      final tm = mf.deg(acos(costm));
      syk = 12 - eoT - tm / 15.0 - kwd;
    }

    return SalatValue(time: syk, status: SalatStatus.normal);
  }

  SalatValue duha(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double elev,
    double tmZn,
  ) {
    final wSyk = syuruk(tglM, blnM, thnM, gLon, gLat, elev, tmZn);

    if (!wSyk.isNormal) {
      return const SalatValue(time: null, status: SalatStatus.invalid);
    }

    final duh = wSyk.time! + 15 / 60.0;

    return SalatValue(time: duh, status: SalatStatus.normal);
  }

  SalatValue nisfuLail(
    int tglM,
    int blnM,
    int thnM,
    double gLon,
    double gLat,
    double elev,
    double tmZn,
  ) {
    final wMgb = magrib(tglM, blnM, thnM, gLon, gLat, elev, tmZn);
    final wSbh = subuh(tglM, blnM, thnM, gLon, gLat, tmZn);

    if (!wMgb.isNormal || !wSbh.isNormal) {
      return const SalatValue(time: null, status: SalatStatus.invalid);
    }

    final intr = (mf.mod(wSbh.time! - wMgb.time!, 24.0)) / 2.0;
    final nisf = wMgb.time! + intr;

    return SalatValue(time: nisf, status: SalatStatus.normal);
  }

  double ihtiyathShalat(double jamDesWs, int ihtiyath) {
    double uDHrs = jamDesWs;
    double uHrs = jamDesWs.floorToDouble();
    double uDMin = (uDHrs - uHrs) * 60.0;
    double uMin = uDMin.floorToDouble() + ihtiyath;

    if (uMin == 60.0) {
      uMin = 0.0;
      uHrs = uHrs + 1.0;
    }

    double iht = uHrs + uMin / 60;
    return iht;
  }
}
