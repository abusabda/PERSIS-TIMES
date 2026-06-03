import 'dart:math' as math;
import 'package:persis_times/src/core/math/math_utils.dart';
import '../core/astronomy/dynamical_time.dart';
import '../core/astronomy/moon_function.dart';
import '../core/astronomy/sun_function.dart';
import '../model/awal_bulan/peta_visibilitas_hilal_result.dart';

class PetaVisibilitasService {
  PetaVisibilitasHilalResult hitung({
    required int blnH,
    required int thnH,
    required double gLon,
    required double gLat,
    required double tmZn,
    required int tbhHari,
  }) {
    final mo = MoonFunction();
    final sn = SunFunction();
    final dt = DynamicalTime();
    final mf = MathFunction();

    // 1. Hitung JD Ijtimak Geosentris awal
    final double geojdIjtimak = mo.geocentricConjunction(
      blnH,
      thnH,
      0.0,
      "Ijtima",
    );

    // 2. Hitung Delta T
    final double deltaT = dt.deltaT(geojdIjtimak.floorToDouble() + 0.5);

    // 3. Hitung JD Ijtimak Geosentris yang sudah dikoreksi Delta T
    final double geojdIjtimak2 = mo.geocentricConjunction(
      blnH,
      thnH,
      deltaT,
      "Ijtima",
    );

    final double sunsetJD = sn.jdGhurubSyams(
      geojdIjtimak2 + tbhHari,
      gLat,
      gLon,
      0.0,
      tmZn,
    );

    // Hitung parameter-parameter astronomi
    final double moonGeocentricAltitude = mo.moonGeocentricAltitude(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
    );

    final double moonTopocentricAltitudeAirlessCenter = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          0.0,
          1010.0,
          10.0,
          "htc",
        );

    final double sunTopocentricAltitudeAirlessCenter = sn
        .sunTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          0.0,
          1010.0,
          10.0,
          "htc",
        );

    final double moonTopocentricAltitudeObserveredCenter = mo
        .moonTopocentricAltitude(
          sunsetJD,
          deltaT,
          gLon,
          gLat,
          0.0,
          1010.0,
          10.0,
          "htoc",
        );

    // Elongasi Geosentris
    final double elongGeo = mo.moonSunGeocentricElongation(sunsetJD, deltaT);

    // Elongasi topocentric (ARCL)
    final double elongTopo = mo.moonSunTopocentricElongation(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      0.0,
    );

    // Beda tinggi bulan-matahari (ARCV)
    final double arcv =
        moonTopocentricAltitudeAirlessCenter +
        sunTopocentricAltitudeAirlessCenter.abs();

    // Lebar sabit (crescent width) dalam derajat
    final double crescentWidthTopoDeg =
        mo.moonTopocentricSemidiameter(sunsetJD, deltaT, gLon, gLat, 0.0) *
        (1 - math.cos(mf.rad(elongTopo)));

    // Lebar sabit dalam menit busur
    final double crescentWidthTopoArcmin = crescentWidthTopoDeg * 60;

    // Horizontal parallax bulan
    final double moonEquatorialHorizontalParallax = mo
        .moonEquatorialHorizontalParallax(sunsetJD, deltaT);

    // Beda azimuth bulan-matahari (DAZ)
    final double moonAzimuth = mo.moonTopocentricAzimuth(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      0.0,
    );
    final double sunAzimuth = sn.sunTopocentricAzimuth(
      sunsetJD,
      deltaT,
      gLon,
      gLat,
      0.0,
    );
    final double daz = (moonAzimuth - sunAzimuth).abs();

    // ==========================================
    // 1. KRITERIA ODEH (2006)
    // ==========================================
    // V = ARCV - (-0.1018W³ + 0.7319W² - 6.3226W + 7.1651)
    final double qOdeh =
        arcv -
        (-0.1018 * math.pow(crescentWidthTopoArcmin, 3) +
            0.7319 * math.pow(crescentWidthTopoArcmin, 2) -
            6.3226 * crescentWidthTopoArcmin +
            7.1651);

    // ==========================================
    // 2. KRITERIA YALLOP (1997)
    // ==========================================
    // W' = 0.27245π(1 + sin h sin π)(1 - cos ARCL)
    // q = (ARCV - (11.8371 - 6.3226W' + 0.7319W'² - 0.1018W'³))/10

    final double h = moonGeocentricAltitude;
    final double pi = moonEquatorialHorizontalParallax;
    final double arcl = elongTopo;

    final double wPrime =
        0.27245 *
        pi *
        (1 + math.sin(mf.rad(h)) * math.sin(mf.rad(pi))) *
        (1 - math.cos(mf.rad(arcl)));

    final double qYallop =
        (arcv -
            (11.8371 -
                6.3226 * wPrime +
                0.7319 * math.pow(wPrime, 2) -
                0.1018 * math.pow(wPrime, 3))) /
        10;

    // ==========================================
    // 3. KRITERIA SAAO (2001)
    // ==========================================
    // DALT1 = 6.36 - 0.0928DAZ - 0.0048DAZ²
    // DALT2 = 8.257 - 0.0928DAZ - 0.0048DAZ²

    final double dalt1 = 6.36 - 0.0928 * daz - 0.0048 * math.pow(daz, 2);
    final double dalt2 = 8.257 - 0.0928 * daz - 0.0048 * math.pow(daz, 2);

    // Altitude piringan bawah bulan
    final double moonLowerLimbAltitude =
        moonTopocentricAltitudeAirlessCenter -
        mo.moonTopocentricSemidiameter(sunsetJD, deltaT, gLon, gLat, 0.0);

    // Status visibilitas SAAO
    String saaoStatus;
    if (moonLowerLimbAltitude > dalt2) {
      saaoStatus = "Terlihat dengan mata telanjang";
    } else if (moonLowerLimbAltitude >= dalt1) {
      saaoStatus = "Mungkin terlihat dengan alat optik";
    } else {
      saaoStatus = "Tidak terlihat";
    }

    // ==========================================
    // 4. KRITERIA MAUNDER (1911)
    // ==========================================
    // ARCV > 11 - (DAZ/20) - (DAZ²/100)

    final double maunderMin = 11 - (daz / 20) - (math.pow(daz, 2) / 100);
    final bool maunderVisible = arcv > maunderMin;

    // ==========================================
    // 5. KRITERIA BRUIN (1977)
    // ==========================================
    // ARCV > 12.4023 - 9.4878W + 3.9512W² - 0.5632W³
    // W dalam derajat

    final double bruinMin =
        12.4023 -
        9.4878 * crescentWidthTopoDeg +
        3.9512 * math.pow(crescentWidthTopoDeg, 2) -
        0.5632 * math.pow(crescentWidthTopoDeg, 3);
    final bool bruinVisible = arcv > bruinMin;

    // ==========================================
    // 6. KRITERIA IR MABIMS (2021)
    // ==========================================
    // Syarat:
    // - Elongasi Geosentris (elongGeo) >= 6.4 derajat
    // - Tinggi Bulan Toposentris (htoc) >= 3 derajat
    // Jika kedua syarat terpenuhi -> visible, jika tidak -> tidak visible

    final bool mabimsVisible =
        (elongGeo >= 6.4) && (moonTopocentricAltitudeObserveredCenter >= 3.0);

    String mabimsStatus;
    if (mabimsVisible) {
      mabimsStatus = "Terlihat (Memenuhi kriteria MABIMS)";
    } else {
      mabimsStatus = "Tidak terlihat (Tidak memenuhi kriteria MABIMS)";
    }

    // ==========================================
    // 7. KRITERIA TURKI / KHGT
    // ==========================================
    // Syarat:
    // - Elongasi Geosentris (elongGeo) >= 8 derajat
    // - Tinggi Bulan Geosentris (moonGeocentricAltitude) >= 5 derajat
    // Jika kedua syarat terpenuhi -> visible, jika tidak -> tidak visible

    final bool turkiVisible =
        (elongGeo >= 8.0) && (moonGeocentricAltitude >= 5.0);

    String turkiStatus;
    if (turkiVisible) {
      turkiStatus = "Terlihat (Memenuhi kriteria Turki/KHGT)";
    } else {
      turkiStatus = "Tidak terlihat (Tidak memenuhi kriteria Turki/KHGT)";
    }

    // ==========================================
    // TENTUKAN ZONA VISIBILITAS
    // ==========================================

    // Zona Odeh
    String zonaOdeh;
    if (qOdeh >= 5.65) {
      zonaOdeh = "A (Mata telanjang)";
    } else if (qOdeh >= 2) {
      zonaOdeh = "B (Alat optik, mungkin mata)";
    } else if (qOdeh >= -0.96) {
      zonaOdeh = "C (Alat optik saja)";
    } else {
      zonaOdeh = "D (Tidak terlihat)";
    }

    // Zona Yallop
    String zonaYallop;
    if (qYallop > 0.216) {
      zonaYallop = "A (Mudah dilihat)";
    } else if (qYallop > -0.014) {
      zonaYallop = "B (Cuaca cerah)";
    } else if (qYallop > -0.16) {
      zonaYallop = "C (Perlu alat optik)";
    } else if (qYallop > -0.232) {
      zonaYallop = "D (Perlu alat optik)";
    } else if (qYallop > -0.293) {
      zonaYallop = "E (Tidak terlihat)";
    } else {
      zonaYallop = "F (Di bawah limit Danjon)";
    }

    return PetaVisibilitasHilalResult(
      geojdIjtimak: geojdIjtimak2,
      sunsetJD: sunsetJD,

      // Parameter dasar
      elongGeo: elongGeo,
      elongasi: elongTopo,
      arcv: arcv,
      daz: daz,
      crescentWidth: crescentWidthTopoArcmin,
      moonAltitude: moonTopocentricAltitudeAirlessCenter,
      moonTopoAltitudeObsCenter: moonTopocentricAltitudeObserveredCenter,
      moonGeoAltitude: moonGeocentricAltitude,
      moonLowerLimbAltitude: moonLowerLimbAltitude,

      // Kriteria Odeh
      qOdeh: qOdeh,
      zonaOdeh: zonaOdeh,

      // Kriteria Yallop
      wPrime: wPrime,
      qYallop: qYallop,
      zonaYallop: zonaYallop,

      // Kriteria SAAO
      dalt1: dalt1,
      dalt2: dalt2,
      saaoStatus: saaoStatus,

      // Kriteria Maunder
      maunderMinimum: maunderMin,
      maunderVisible: maunderVisible,

      // Kriteria Bruin
      bruinMinimum: bruinMin,
      bruinVisible: bruinVisible,

      // Kriteria IR MABIMS
      mabimsVisible: mabimsVisible,
      mabimsStatus: mabimsStatus,

      // Kriteria Turki/KHGT
      turkiVisible: turkiVisible,
      turkiStatus: turkiStatus,
    );
  }
}
