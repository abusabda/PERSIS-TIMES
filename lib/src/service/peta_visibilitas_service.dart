import 'dart:math' as math;
import 'package:persis_times/src/core/math/math_utils.dart';
import '../core/astronomy/dynamical_time.dart';
import '../core/astronomy/moon_function.dart';
import '../core/astronomy/sun_function.dart';
import '../model/awal_bulan/peta_visibilitas_hilal_result.dart';

class PetaVisibilitasService {
  // Objek astronomi dibuat sekali, dipakai ulang
  final MoonFunction _mo = MoonFunction();
  final SunFunction _sn = SunFunction();
  final DynamicalTime _dt = DynamicalTime();
  final MathFunction _mf = MathFunction();

  // ── Pre-hitung JD Ijtimak — panggil ini SEKALI sebelum loop ───
  // Kembalikan (jdIjtimak, deltaT) yang bisa di-cache di luar
  ({double jdIjtimak, double deltaT}) preHitung({
    required int blnH,
    required int thnH,
  }) {
    final double jd1 = _mo.geocentricConjunction(blnH, thnH, 0.0, "Ijtima");
    final double dT = _dt.deltaT(jd1.floorToDouble() + 0.5);
    final double jd2 = _mo.geocentricConjunction(blnH, thnH, dT, "Ijtima");
    return (jdIjtimak: jd2, deltaT: dT);
  }

  // ── Hitung satu titik koordinat ────────────────────────────────
  // [jdIjtimak] & [deltaT]: opsional — jika tidak diisi, dihitung otomatis
  // Untuk loop peta: isi dari hasil preHitung() agar tidak hitung ulang
  PetaVisibilitasHilalResult hitung({
    required int blnH,
    required int thnH,
    required double gLon,
    required double gLat,
    required double tmZn,
    required int tbhHari,
    double? jdIjtimak, // ← parameter opsional
    double? deltaT, // ← parameter opsional
  }) {
    // Gunakan nilai yang dipass, atau hitung sendiri jika null
    final double geojdIjtimak2;
    final double dT;

    if (jdIjtimak != null && deltaT != null) {
      // Pakai nilai yang sudah dihitung di luar → hemat 2 panggilan berat
      geojdIjtimak2 = jdIjtimak;
      dT = deltaT;
    } else {
      // Hitung sendiri (perilaku lama, backward-compatible)
      final double jd1 = _mo.geocentricConjunction(blnH, thnH, 0.0, "Ijtima");
      dT = _dt.deltaT(jd1.floorToDouble() + 0.5);
      geojdIjtimak2 = _mo.geocentricConjunction(blnH, thnH, dT, "Ijtima");
    }

    final double sunsetJD = _sn.jdGhurubSyams(
      geojdIjtimak2 + tbhHari,
      gLat,
      gLon,
      0.0,
      tmZn,
    );

    final double moonGeoAlt = _mo.moonGeocentricAltitude(
      sunsetJD,
      dT,
      gLon,
      gLat,
    );

    final double moonTopoAirlessCenter = _mo.moonTopocentricAltitude(
      sunsetJD,
      dT,
      gLon,
      gLat,
      0.0,
      1010.0,
      10.0,
      "htc",
    );

    final double sunTopoAirlessCenter = _sn.sunTopocentricAltitude(
      sunsetJD,
      dT,
      gLon,
      gLat,
      0.0,
      1010.0,
      10.0,
      "htc",
    );

    final double moonTopoObsCenter = _mo.moonTopocentricAltitude(
      sunsetJD,
      dT,
      gLon,
      gLat,
      0.0,
      1010.0,
      10.0,
      "htoc",
    );

    final double elongGeo = _mo.moonSunGeocentricElongation(sunsetJD, dT);
    final double elongTopo = _mo.moonSunTopocentricElongation(
      sunsetJD,
      dT,
      gLon,
      gLat,
      0.0,
    );

    final double arcv = moonTopoAirlessCenter + sunTopoAirlessCenter.abs();

    final double sd = _mo.moonTopocentricSemidiameter(
      sunsetJD,
      dT,
      gLon,
      gLat,
      0.0,
    );
    final double crescentWidthDeg = sd * (1 - math.cos(_mf.rad(elongTopo)));
    final double crescentWidthArcmin = crescentWidthDeg * 60;

    final double moonHP = _mo.moonEquatorialHorizontalParallax(sunsetJD, dT);

    final double moonAz = _mo.moonTopocentricAzimuth(
      sunsetJD,
      dT,
      gLon,
      gLat,
      0.0,
    );
    final double sunAz = _sn.sunTopocentricAzimuth(
      sunsetJD,
      dT,
      gLon,
      gLat,
      0.0,
    );
    final double daz = (moonAz - sunAz).abs();

    // ── Odeh ──────────────────────────────────────────────────────
    final double qOdeh =
        arcv -
        (-0.1018 * math.pow(crescentWidthArcmin, 3) +
            0.7319 * math.pow(crescentWidthArcmin, 2) -
            6.3226 * crescentWidthArcmin +
            7.1651);

    // ── Yallop ────────────────────────────────────────────────────
    final double wPrime =
        0.27245 *
        moonHP *
        (1 + math.sin(_mf.rad(moonGeoAlt)) * math.sin(_mf.rad(moonHP))) *
        (1 - math.cos(_mf.rad(elongTopo)));

    final double qYallop =
        (arcv -
            (11.8371 -
                6.3226 * wPrime +
                0.7319 * math.pow(wPrime, 2) -
                0.1018 * math.pow(wPrime, 3))) /
        10;

    // ── SAAO ──────────────────────────────────────────────────────
    final double dalt1 = 6.36 - 0.0928 * daz - 0.0048 * math.pow(daz, 2);
    final double dalt2 = 8.257 - 0.0928 * daz - 0.0048 * math.pow(daz, 2);
    final double moonLowerLimb = moonTopoAirlessCenter - sd;

    String saaoStatus;
    if (moonLowerLimb > dalt2)
      saaoStatus = "Terlihat dengan mata telanjang";
    else if (moonLowerLimb >= dalt1)
      saaoStatus = "Mungkin terlihat dengan alat optik";
    else
      saaoStatus = "Tidak terlihat";

    // ── Maunder ───────────────────────────────────────────────────
    final double maunderMin = 11 - (daz / 20) - (math.pow(daz, 2) / 100);
    final bool maunderVisible = arcv > maunderMin;

    // ── Bruin ─────────────────────────────────────────────────────
    final double bruinMin =
        12.4023 -
        9.4878 * crescentWidthDeg +
        3.9512 * math.pow(crescentWidthDeg, 2) -
        0.5632 * math.pow(crescentWidthDeg, 3);
    final bool bruinVisible = arcv > bruinMin;

    // ── IR MABIMS ─────────────────────────────────────────────────
    final bool mabimsVisible = (elongGeo >= 6.4) && (moonTopoObsCenter >= 3.0);

    // ── Turki/KHGT ────────────────────────────────────────────────
    final bool turkiVisible = (elongGeo >= 8.0) && (moonGeoAlt >= 5.0);

    // ── Zona ──────────────────────────────────────────────────────
    String zonaOdeh;
    if (qOdeh >= 5.65)
      zonaOdeh = "A (Mata telanjang)";
    else if (qOdeh >= 2.00)
      zonaOdeh = "B (Alat optik, mungkin mata)";
    else if (qOdeh >= -0.96)
      zonaOdeh = "C (Alat optik saja)";
    else
      zonaOdeh = "D (Tidak terlihat)";

    String zonaYallop;
    if (qYallop > 0.216)
      zonaYallop = "A (Mudah dilihat)";
    else if (qYallop > -0.014)
      zonaYallop = "B (Cuaca cerah)";
    else if (qYallop > -0.160)
      zonaYallop = "C (Perlu alat optik)";
    else if (qYallop > -0.232)
      zonaYallop = "D (Perlu alat optik)";
    else if (qYallop > -0.293)
      zonaYallop = "E (Tidak terlihat)";
    else
      zonaYallop = "F (Di bawah limit Danjon)";

    return PetaVisibilitasHilalResult(
      geojdIjtimak: geojdIjtimak2,
      sunsetJD: sunsetJD,
      elongGeo: elongGeo,
      elongasi: elongTopo,
      arcv: arcv,
      daz: daz,
      crescentWidth: crescentWidthArcmin,
      moonAltitude: moonTopoAirlessCenter,
      moonTopoAltitudeObsCenter: moonTopoObsCenter,
      moonGeoAltitude: moonGeoAlt,
      moonLowerLimbAltitude: moonLowerLimb,
      qOdeh: qOdeh,
      zonaOdeh: zonaOdeh,
      wPrime: wPrime,
      qYallop: qYallop,
      zonaYallop: zonaYallop,
      dalt1: dalt1,
      dalt2: dalt2,
      saaoStatus: saaoStatus,
      maunderMinimum: maunderMin,
      maunderVisible: maunderVisible,
      bruinMinimum: bruinMin,
      bruinVisible: bruinVisible,
      mabimsVisible: mabimsVisible,
      mabimsStatus: mabimsVisible
          ? "Terlihat (Memenuhi kriteria MABIMS)"
          : "Tidak terlihat (Tidak memenuhi kriteria MABIMS)",
      turkiVisible: turkiVisible,
      turkiStatus: turkiVisible
          ? "Terlihat (Memenuhi kriteria Turki/KHGT)"
          : "Tidak terlihat (Tidak memenuhi kriteria Turki/KHGT)",
    );
  }
}
