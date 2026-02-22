import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/math/math_utils.dart';
import 'package:myhisab/src/core/astronomy/moon_function.dart';
// import 'package:myhisab/src/core/astronomy/sun_function.dart';
// import 'package:myhisab/src/core/astronomy/dynamical_time.dart';
import 'package:myhisab/src/service/salat_service.dart';
import 'package:myhisab/src/service/qibla_service.dart';
import 'package:myhisab/src/service/calendar_service.dart';
import 'package:myhisab/src/service/lunar_eclipse_service.dart';
import 'package:myhisab/src/service/solar_eclipse_service.dart';
import 'package:myhisab/src/service/moon_service.dart';
import 'package:myhisab/src/service/sun_service.dart';

void main() {
  final ss = SalatService();
  final qs = QiblaService();
  final cs = CalendarService();
  final le = LunarEclipseService();
  final se = SolarEclipseService();
  final jd = JulianDay();
  final mf = MathFunction();
  final mo = MoonFunction();
  // final sn = SunFunction();
  // final dt = DynamicalTime();

  final moonService = MoonService();
  final sunService = SunService();

  final res2 = sunService.calculate(
    tglM: 20,
    blnM: 4,
    thnM: 2023,
    jam: 17,
    menit: 51,
    detik: 27,
    gLon: (106 + 33 / 60.0 + 27.8 / 3600.0),
    gLat: -(7 + 1 / 60.0 + 44.6 / 3600.0),
    elev: 52.685,
    tmZn: 7.0,
    temp: 10.0,
    pres: 1010.0,
  );

  print("======================");
  print("DATA MATAHARI");
  print("======================");

  print("JD                   : ${res2.jd}");
  print("DeltaT               : ${res2.deltaT}");

  print("");
  print("======================");
  print("GEOCENTRIC");
  print("======================");

  print(
    "Longitude True       : ${mf.dddms(res2.geoLongitudeTrue, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Longitude Apparent   : ${mf.dddms(res2.geoLongitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Latitude True        : ${mf.dddms(res2.geoLatitudeTrue, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Latitude Apparent    : ${mf.dddms(res2.geoLatitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("Distance KM          : ${res2.geoDistanceKm}");
  print("Distance AU          : ${res2.geoDistanceAu}");
  print("Distance ER          : ${res2.geoDistanceEr}");

  print("");
  print(
    "Right Ascension      : ${mf.dddms(res2.geoRightAscensionApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Declination          : ${mf.dddms(res2.geoDeclinationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Greenwich HA         : ${mf.dhhms(res2.geoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res2.geoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

  print("");
  print(
    "Azimuth              : ${mf.dddms(res2.geoAzimuthApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude             : ${mf.dddms(res2.geoAltitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Horizontal Parallax  : ${mf.dddms(res2.geoHorizontalParallax, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Semidiameter         : ${mf.dddms(res2.geoSemidiameter, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("======================");
  print("TOPOCENTRIC (APPARENT)");
  print("======================");
  print("");

  print(
    "Longitude            : ${mf.dddms(res2.topoLongitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Latitude             : ${mf.dddms(res2.topoLatitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Right Ascension      : ${mf.dddms(res2.topoRightAscensionApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Declination          : ${mf.dddms(res2.topoDeclinationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Greenwich HA         : ${mf.dhhms(res2.topoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res2.topoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

  print("");
  print(
    "Semidiameter         : ${mf.dddms(res2.topoSemidiameterApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Azimuth              : ${mf.dddms(res2.topoAzimuthApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("----------------------");
  print("Airless Altitude");
  print("----------------------");
  print(
    "Upper  : ${mf.dddms(res2.topoAltitudeUpperAirless, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Center : ${mf.dddms(res2.topoAltitudeCenterAirless, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Lower  : ${mf.dddms(res2.topoAltitudeLowerAirless, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("----------------------");
  print("Apparent Altitude");
  print("----------------------");
  print(
    "Upper  : ${mf.dddms(res2.topoAltitudeUpperApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Center : ${mf.dddms(res2.topoAltitudeCenterApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Lower  : ${mf.dddms(res2.topoAltitudeLowerApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("----------------------");
  print("Observed Altitude");
  print("----------------------");
  print(
    "Upper  : ${mf.dddms(res2.topoAltitudeUpperObserved, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Center : ${mf.dddms(res2.topoAltitudeCenterObserved, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Lower  : ${mf.dddms(res2.topoAltitudeLowerObserved, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");

  print("======================");
  print("DATA BULAN");
  print("======================");

  final res = moonService.calculate(
    tglM: 20,
    blnM: 4,
    thnM: 2023,
    jam: 17,
    menit: 51,
    detik: 27,
    gLon: (106 + 33 / 60.0 + 27.8 / 3600.0),
    gLat: -(7 + 1 / 60.0 + 44.6 / 3600.0),
    elev: 52.685,
    tmZn: 7.0,
    temp: 10.0,
    pres: 1010.0,
  );

  print("JD                   : ${res.jd}");
  print("DeltaT               : ${res.deltaT}");

  print("");
  print("======================");
  print("GEOCENTRIC");
  print("======================");

  print(
    "Longitude True       : ${mf.dddms(res.geoLongitudeTrue, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Longitude Apparent   : ${mf.dddms(res.geoLongitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Latitude True        : ${mf.dddms(res.geoLatitudeTrue, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Latitude Apparent    : ${mf.dddms(res.geoLatitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("Distance KM          : ${res.geoDistanceKm}");
  print("Distance AU          : ${res.geoDistanceAu}");
  print("Distance ER          : ${res.geoDistanceEr}");

  print("");
  print(
    "Right Ascension      : ${mf.dddms(res.geoRightAscensionApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Declination          : ${mf.dddms(res.geoDeclinationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Greenwich HA         : ${mf.dhhms(res.geoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res.geoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

  print("");
  print(
    "Azimuth              : ${mf.dddms(res.geoAzimuthApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude             : ${mf.dddms(res.geoAltitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Horizontal Parallax  : ${mf.dddms(res.geoHorizontalParallax, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Semidiameter         : ${mf.dddms(res.geoSemidiameter, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Phase Angle          : ${mf.dddms(res.geoPhaseAngle, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print("Illuminated Fraction : ${res.geoIlluminatedFraction}");
  print(
    "Bright Limb Angle    : ${mf.dddms(res.geoBrightLimbAngle, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Sun Elongation       : ${mf.dddms(res.geoSunElongation, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("======================");
  print("TOPOCENTRIC (APPARENT)");
  print("======================");
  print("");

  print(
    "Longitude            : ${mf.dddms(res.topoLongitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Latitude             : ${mf.dddms(res.topoLatitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Right Ascension      : ${mf.dddms(res.topoRightAscensionApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Declination          : ${mf.dddms(res.topoDeclinationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Greenwich HA         : ${mf.dhhms(res.topoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res.topoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

  print("");
  print(
    "Semidiameter         : ${mf.dddms(res.topoSemidiameterApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Phase Angle          : ${mf.dddms(res.topoPhaseAngleApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print("Illuminated Fraction : ${res.topoIlluminatedFractionApparent}");
  print(
    "Bright Limb Angle    : ${mf.dddms(res.topoBrightLimbAngleApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Azimuth              : ${mf.dddms(res.topoAzimuthApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("----------------------");
  print("Airless Altitude");
  print("----------------------");
  print(
    "Upper  : ${mf.dddms(res.topoAltitudeUpperAirless, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Center : ${mf.dddms(res.topoAltitudeCenterAirless, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Lower  : ${mf.dddms(res.topoAltitudeLowerAirless, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("----------------------");
  print("Apparent Altitude");
  print("----------------------");
  print(
    "Upper  : ${mf.dddms(res.topoAltitudeUpperApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Center : ${mf.dddms(res.topoAltitudeCenterApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Lower  : ${mf.dddms(res.topoAltitudeLowerApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("----------------------");
  print("Observed Altitude");
  print("----------------------");
  print(
    "Upper  : ${mf.dddms(res.topoAltitudeUpperObserved, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Center : ${mf.dddms(res.topoAltitudeCenterObserved, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Lower  : ${mf.dddms(res.topoAltitudeLowerObserved, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(
    "Topocentric Sun Elongation : ${mf.dddms(res.topoSunElongationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("========================================");
  print("       WAKTU SALAT HARIAN");
  print("========================================");

  final waktuSalatHarian = ss.waktuSalatHarian(
    tglM: 1,
    blnM: 1,
    thnM: 2025,
    gLon: (107 + 36 / 60),
    gLat: -(7 + 5 / 60),
    elev: 0,
    tmZn: 7,
    ihty: 2,
  );

  print(waktuSalatHarian);
  print("");

  print("========================================");
  print("       WAKTU SALAT BULANAN");
  print("========================================");

  final waktuSalatBulanan = ss.waktuSalatBulanan(
    tglM1: 1,
    blnM1: 1,
    thnM1: 2025,
    tglM2: 31,
    blnM2: 1,
    thnM2: 2025,
    gLon: 107 + 37 / 60.0,
    gLat: -(7 + 5 / 60.0),
    elev: 0,
    tmZn: 7,
    ihty: 2,
  );

  print(waktuSalatBulanan);
  print("");

  print("========================================");
  print("             ARAH KIBLAT");
  print("========================================");

  final arahKiblat = qs.arahQiblat(
    tglM: 1,
    blnM: 1,
    thnM: 2025,
    gLon: 107 + 37 / 60.0,
    gLat: -(7 + 5 / 60.0),
    tmZn: 7,
    sdp: 2,
  );

  print(arahKiblat);
  print("");

  print("========================================");
  print("         WAKTU KIBLAT BULANAN");
  print("========================================");

  final waktuKiblatBulanan = qs.waktuKiblatBulanan(
    tglM1: 1,
    blnM1: 1,
    thnM1: 2025,
    tglM2: 31,
    blnM2: 1,
    thnM2: 2025,
    gLon: 107 + 37 / 60.0,
    gLat: -(7 + 5 / 60.0),
    elev: 0,
    tmZn: 7,
  );

  print(waktuKiblatBulanan);
  print("");

  print("========================================");
  print("        RASHDUL KIBLAT TAHUNAN");
  print("========================================");

  final rashdulQiblatTahunan = qs.rashdulQiblatTahunan(
    thnM1: 2025,
    thnM2: 2026,
    tmZn: 7,
  );

  print(rashdulQiblatTahunan);

  print("");

  print("========================================");
  print("        ANTIPODA KIBLAT TAHUNAN");
  print("========================================");

  final antipodaQiblatTahunan = qs.antipodaQiblatTahunan(
    thnM1: 2025,
    thnM2: 2026,
    tmZn: 7,
  );

  print(antipodaQiblatTahunan);
  print("");

  print("========================================");
  print("        HISAB AWAL BULN HIJRIAH");
  print("========================================");

  final namaBulanHijriah = [
    "Al-Muharram",
    "Shafar",
    "Rabiul Awwal",
    "Rabiul Akhir",
    "Jumadal Ula",
    "Jumadal Akhirah",
    "Rajab",
    "Syaban",
    "Ramadhan",
    "Syawwal",
    "Zulqadah",
    "Zulhijjah",
  ];

  //input Bulan dan Tahun Hijri
  final blnH = 10;
  final thnH = 1444;

  final abqSesuaiLokasi = ab.hisabAwalBulanHijriahSesuaiLokasi(
    nmLokasi: "Pelabuhan Ratu",
    blnH: blnH,
    thnH: thnH,
    gLon: (106 + 33 / 60 + 27.8 / 3600),
    gLat: -(7 + 1 / 60 + 44.6 / 3600),
    elev: 52.685,
    tmZn: 7,
    pres: 1010,
    temp: 10,
    sdp: 2,
    tbhHari: 0,
    optKriteria: 1,
  );

  print(abqSesuaiLokasi); // tampilkan semua output sekaligus

  final namaBlnH = namaBulanHijriah[blnH - 1];

  final jdAbqMabims = cs.abqMabims(blnH, thnH);
  print("1 $namaBlnH $thnH H (MABIMS)      : ${jd.jdkm(jdAbqMabims)}");

  final jdAbqWH = cs.abqWujudulHilal(blnH, thnH);
  print("1 $namaBlnH $thnH H (Wujud Hilal) : ${jd.jdkm(jdAbqWH)}");

  final jdAbqTurki = cs.abqTurki(blnH, thnH);
  print("1 $namaBlnH $thnH H (TURKI/KHGT)  : ${jd.jdkm(jdAbqTurki)}");

  //input tanggal, bulan, tahun Masehi

  final tglM = 22;
  final blnM = 4;
  final thnM = 2023;

  final abqMabimsNow = cs.serviceKalenderHijriahMABIMS(tglM, blnM, thnM);
  print("MABIMS                          : $abqMabimsNow");

  final abqWHNow = cs.serviceKalenderHijriahWH(tglM, blnM, thnM);
  print("Wujudu Hilal                    : $abqWHNow");

  final abqTurkiNow = cs.serviceKalenderHijriahTURKI(tglM, blnM, thnM);
  print("Turki/KHGT                      : $abqTurkiNow");

  print(" ");

  // INPUT GERHANA BULAN
  final blnH2 = 11;
  final thnH2 = 1439;
  final gLon2 = 107 + 36 / 60.0 + 0 / 3600.0;
  final gLat2 = -(7 + 5 / 60.0 + 0 / 3600.0);
  final elev2 = 730.0;
  double tmZn2 = 7;

  print("========================================");
  print("        DATA GERHANA BULAN");
  print("========================================");
  print("Bulan Hijriah : $blnH2");
  print("Tahun Hijriah : $thnH2");
  print("");

  // ================================
  // CETAK ELEMEN BESSELIAN
  // ================================
  print("Elemen Besselian:");
  final elements = [
    "x0",
    "x1",
    "x2",
    "x3",
    "x4",
    "y0",
    "y1",
    "y2",
    "y3",
    "y4",
    "d0",
    "d1",
    "d2",
    "d3",
    "d4",
    "f10",
    "f11",
    "f12",
    "f13",
    "f14",
    "f20",
    "f21",
    "f22",
    "f23",
    "f24",
    "Sm0",
    "Sm1",
    "Sm2",
    "Sm3",
    "Sm4",
    "HP0",
    "HP1",
    "HP2",
    "HP3",
    "HP4",
    "DT",
    "T0",
  ];

  for (var e in elements) {
    final val = le.lBesselian(blnH2, thnH2, e);

    String valStr;

    if (val.isNaN) {
      valStr = "-";
    } else {
      // Atur jumlah desimal berdasarkan jenis elemen
      if (e == "T0") {
        // T0 = jam bulat (tanpa desimal)
        valStr = val.toStringAsFixed(0);
      } else if (e == "DT") {
        // DT = DeltaT (2 desimal)
        valStr = val.toStringAsFixed(2);
      } else {
        // Elemen lain = 7 desimal
        valStr = val.toStringAsFixed(7);
      }

      // Tambahkan 1 spasi di depan untuk nilai positif agar sejajar dengan negatif
      if (val > 0) valStr = " $valStr";
    }

    print("${e.padRight(5)} : $valStr");
  }

  print("========================================");

  final lunarEclipse = [
    "JLE",
    "JDP1",
    "JDU1",
    "JDU2",
    "JDMX",
    "JDU3",
    "JDU4",
    "JDP4",
    "DURP",
    "DURU",
    "DURT",
    "MAGP",
    "MAGU",
    "RADP",
    "RADU",
    "RAS",
    "DCS",
    "SDS",
    "HPS",
    "RAM",
    "DCM",
    "SDM",
    "HPM",
  ];

  final Map<String, String> lunarEclipseLabel = {
    "JLE": "Jenis Gerhana",
    "JDP1": "Awal Penumbra (P1)",
    "JDU1": "Awal Umbra (U1)",
    "JDU2": "Awal Total (U2)",
    "JDMX": "Puncak Gerhana (MX)",
    "JDU3": "Akhir Total (U3)",
    "JDU4": "Akhir Umbra(U4)",
    "JDP4": "Akhir Penumbra (P4)",
    "DURP": "Durasi Penumbra",
    "DURU": "Durasi Umbra",
    "DURT": "Durasi Total",
    "MAGP": "Magnitudo Penumbra",
    "MAGU": "Magnitudo Umbra",
    "RADP": "Radius Penumbra",
    "RADU": "Radius Umbra",
    "RAS": "RAs",
    "DCS": "DCs",
    "SDS": "SDs",
    "HPS": "HPs",
    "RAM": "RAm",
    "DCM": "DCm",
    "SDM": "SDm",
    "HPM": "HPm",
  };

  final result = le.lunarEclipse(
    blnH: blnH2,
    thnH: thnH2,
    gLon: gLon2,
    gLat: gLat2,
    elev: elev2,
    tmZn: tmZn2,
  );

  for (final e in lunarEclipse) {
    final val = result[e];
    String text;

    if (val == null || (val is double && val.isNaN) || val == 0.0) {
      text = "-";
    } else {
      switch (e) {
        case "JLE":
          // Jenis gerhana → teks
          text = val.toString();
          break;

        case "JDP1":
          // Tanggal & Jam P1
          final jdVal = val;
          final azmP1 = mo.moonTopocentricAzimuth(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
          );
          final altP1 = mo.moonTopocentricAltitude(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
            1010.0,
            10.0,
            "htoc",
          );
          text =
              "${jd.jdkm(jdVal, tmZn2)} |"
              " jam : ${mf.dhhms(double.parse(jd.jdkm(jdVal, tmZn2, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 0)} | Azm: ${mf.dddms(azmP1, optResult: "DDMMSS", sdp: 0, posNegSign: "")} | Alt: ${mf.dddms(altP1, optResult: "DDMMSS", sdp: 0, posNegSign: "")}";
          break;

        case "JDU1":
          // Tanggal & Jam U1
          final jdVal = val;
          final azmU1 = mo.moonTopocentricAzimuth(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
          );
          final altU1 = mo.moonTopocentricAltitude(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
            1010.0,
            10.0,
            "htoc",
          );
          text =
              "${jd.jdkm(jdVal, tmZn2)} |"
              " jam : ${mf.dhhms(double.parse(jd.jdkm(jdVal, tmZn2, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 0)} | Azm: ${mf.dddms(azmU1, optResult: "DDMMSS", sdp: 0, posNegSign: "")} | Alt: ${mf.dddms(altU1, optResult: "DDMMSS", sdp: 0, posNegSign: "")}";
          break;

        case "JDU2":
          // Tanggal & Jam U2
          final jdVal = val as double;
          final azmU2 = mo.moonTopocentricAzimuth(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
          );
          final altU2 = mo.moonTopocentricAltitude(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
            1010.0,
            10.0,
            "htoc",
          );
          text =
              "${jd.jdkm(jdVal, tmZn2)} |"
              " jam : ${mf.dhhms(double.parse(jd.jdkm(jdVal, tmZn2, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 0)} | Azm: ${mf.dddms(azmU2, optResult: "DDMMSS", sdp: 0, posNegSign: "")} | Alt: ${mf.dddms(altU2, optResult: "DDMMSS", sdp: 0, posNegSign: "")}";
          break;

        case "JDMX":
          // Tanggal & Jam puncak gerhana
          final jdVal = val;
          final azmMX = mo.moonTopocentricAzimuth(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
          );
          final altMX = mo.moonTopocentricAltitude(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
            1010.0,
            10.0,
            "htoc",
          );
          text =
              "${jd.jdkm(jdVal, tmZn2)} |"
              " jam : ${mf.dhhms(double.parse(jd.jdkm(jdVal, tmZn2, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 0)} | Azm: ${mf.dddms(azmMX, optResult: "DDMMSS", sdp: 0, posNegSign: "")} | Alt: ${mf.dddms(altMX, optResult: "DDMMSS", sdp: 0, posNegSign: "")}";
          break;

        case "JDU3":
          // Tanggal & Jam U3
          final jdVal = val as double;
          final azmU3 = mo.moonTopocentricAzimuth(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
          );
          final altU3 = mo.moonTopocentricAltitude(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
            1010.0,
            10.0,
            "htoc",
          );
          text =
              "${jd.jdkm(jdVal, tmZn2)} |"
              " jam : ${mf.dhhms(double.parse(jd.jdkm(jdVal, tmZn2, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 0)} | Azm: ${mf.dddms(azmU3, optResult: "DDMMSS", sdp: 0, posNegSign: "")} | Alt: ${mf.dddms(altU3, optResult: "DDMMSS", sdp: 0, posNegSign: "")}";
          break;

        case "JDU4":
          // Tanggal & Jam U3
          final jdVal = val as double;
          final azmU4 = mo.moonTopocentricAzimuth(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
          );
          final altU4 = mo.moonTopocentricAltitude(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
            1010.0,
            10.0,
            "htoc",
          );
          text =
              "${jd.jdkm(jdVal, tmZn2)} |"
              " jam : ${mf.dhhms(double.parse(jd.jdkm(jdVal, tmZn2, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 0)} | Azm: ${mf.dddms(azmU4, optResult: "DDMMSS", sdp: 0, posNegSign: "")} | Alt: ${mf.dddms(altU4, optResult: "DDMMSS", sdp: 0, posNegSign: "")}";
          break;

        case "JDP4":
          // Tanggal & Jam U1
          final jdVal = val as double;
          final azmP4 = mo.moonTopocentricAzimuth(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
          );
          final altP4 = mo.moonTopocentricAltitude(
            jdVal,
            0,
            gLon2,
            gLat2,
            elev2,
            1010.0,
            10.0,
            "htoc",
          );
          text =
              "${jd.jdkm(jdVal, tmZn2)} |"
              " jam : ${mf.dhhms(double.parse(jd.jdkm(jdVal, tmZn2, "Jam Des")), optResult: "HH:MM:SS", secDecPlaces: 0)} | Azm: ${mf.dddms(azmP4, optResult: "DDMMSS", sdp: 0, posNegSign: "")} | Alt: ${mf.dddms(altP4, optResult: "DDMMSS", sdp: 0, posNegSign: "")}";
          break;

        case "DURP":
          // Durasi Gerhana
          text = mf.dhhms(
            val as double,
            optResult: "HH:MM:SS",
            secDecPlaces: 0,
          );
          break;

        case "DURU":
          // Durasi Total/Cincin
          text = mf.dhhms(val, optResult: "HH:MM:SS", secDecPlaces: 0);
          break;

        case "DURT":
          // Durasi Total/Cincin
          text = mf.dhhms(val, optResult: "HH:MM:SS", secDecPlaces: 0);
          break;

        case "MAGP":
          // Magnitudo
          text = (val as double).toStringAsFixed(3);
          break;

        case "MAGU":
          // Magnitudo
          text = (val as double).toStringAsFixed(3);
          break;

        case "RADP":
          // Radius Penumbra
          text = (val as double).toStringAsFixed(3);
          break;

        case "RADU":
          // Radius Umbra
          text = (val as double).toStringAsFixed(3);
          break;

        case "RAS":
          // R.A → HH:MM:SS
          text = mf.dhhms(
            val / 15 as double,
            optResult: "HHMMSS",
            secDecPlaces: 1,
          );
          break;

        case "DCS":
          // Dec → DD:MM:SS
          text = mf.dddms(val as double, optResult: "DDMMSS", sdp: 1);
          break;

        case "SDS":
          // S.D → DD:MM:SS
          text = mf.dddms(val as double, optResult: "DDMMSS", sdp: 1);
          break;

        case "HPS":
          // H.P → DD:MM:SS
          text = mf.dddms(val as double, optResult: "DDMMSS", sdp: 1);
          break;

        case "RAM":
          // R.A → HH:MM:SS
          text = mf.dhhms(
            val / 15 as double,
            optResult: "HHMMSS",
            secDecPlaces: 1,
          );
          break;
        case "DCM":
          // Dec → DD:MM:SS
          text = mf.dddms(val as double, optResult: "DDMMSS", sdp: 1);
          break;
        case "SDM":
          // S.D → DD:MM:SS
          text = mf.dddms(val as double, optResult: "DDMMSS", sdp: 1);
          break;
        case "HPM":
          // H.P → DD:MM:SS
          text = mf.dddms(val as double, optResult: "DDMMSS", sdp: 1);
          break;

        default:
          text = val.toString();
      }
    }

    // 🔹 Print dengan label panjang
    print("${lunarEclipseLabel[e]!.padRight(25)} : $text");
  }

  print("========================================");

  // INPUT GERHANA MATAHARI LOKAL
  final blnH3 = 5;
  final thnH3 = 1437;
  final gLon3 = (108 + 17 / 60.0 + 50 / 3600.0);
  final gLat3 = -(2 + 51 / 60.0 + 25 / 3600.0);
  final elev3 = 2.0;
  final pres3 = 1010.0;
  final temp3 = 10.0;
  double tmZn3 = 7.0;

  // ========================================
  // DATA GERHANA MATAHARI LOKAL
  // ========================================

  final resSEL = se.solarEclipseLocal(
    blnH: blnH3,
    thnH: thnH3,
    gLon: gLon3,
    gLat: gLat3,
    elev: elev3,
    pres: pres3,
    temp: temp3,
    tmZn: tmZn3,
  );

  print("");

  print("========================================");
  print("     DATA GERHANA MATAHARI LOKAL");
  print("========================================");

  // 🔴 CEK ADA ATAU TIDAK
  if (resSEL["ADA"] == false) {
    print(resSEL["KET"]);
  } else {
    print("Elemen Besselian:");

    final elem = resSEL["ELEMEN"];

    final elements = [
      "DT",
      "T0",

      "x0",
      "x1",
      "x2",
      "x3",
      "x4",
      "y0",
      "y1",
      "y2",
      "y3",
      "y4",
      "d0",
      "d1",
      "d2",
      "d3",
      "d4",
      "mu0",
      "mu1",
      "mu2",
      "mu3",
      "mu4",
      "l10",
      "l11",
      "l12",
      "l13",
      "l14",
      "l20",
      "l21",
      "l22",
      "l23",
      "l24",
      "tanf1",
      "tanf2",
    ];

    for (var e in elements) {
      double? val;

      // ================= AMBIL NILAI =================
      if (e.startsWith("x")) {
        val = elem["x"][int.parse(e.substring(1))];
      } else if (e.startsWith("y")) {
        val = elem["y"][int.parse(e.substring(1))];
      } else if (e.startsWith("d")) {
        val = elem["d"][int.parse(e.substring(1))];
      } else if (e.startsWith("mu")) {
        val = elem["mu"][int.parse(e.substring(2))];
      } else if (e.startsWith("l1")) {
        val = elem["l1"][int.parse(e.substring(2))];
      } else if (e.startsWith("l2")) {
        val = elem["l2"][int.parse(e.substring(2))];
      } else if (e == "tanf1") {
        val = elem["tanf1"];
      } else if (e == "tanf2") {
        val = elem["tanf2"];
      } else if (e == "DT") {
        val = resSEL["DT"];
      } else if (e == "T0") {
        val = resSEL["T0"];
      }

      String valStr;

      if (val == null || val.isNaN) {
        valStr = "-";
      } else {
        if (e == "T0") {
          valStr = val.toStringAsFixed(0);
        } else if (e == "DT") {
          valStr = val.toStringAsFixed(2);
        } else {
          valStr = val.toStringAsFixed(7);
        }

        if (val > 0) valStr = " $valStr";
      }

      print("${e.padRight(6)} : $valStr");
    }

    print("");

    // ================= DATA UTAMA =================
    print("Jenis Gerhana      : ${resSEL["JSE"]}");
    print("Magnitude Gerhana  : ${resSEL["MAG"]}");
    print("Obskurasi          : ${resSEL["OBS"]}");
    print("Durasi Gerhana     : ${resSEL["DURG"]}");
    print("Durasi Total       : ${resSEL["DURT"]}");

    print("");

    print("========================================");
    print("KONTAK GERHANA");
    print("========================================");

    final contact = resSEL["CONTACT"];

    print("Kontak U1");
    print(se.formatKontakGerhanaLokal(contact["U1"], tmZn3));
    print("");

    print("Kontak U2");
    print(se.formatKontakGerhanaLokal(contact["U2"], tmZn3));
    print("");

    print("Puncak Gerhana (MX)");
    print(se.formatKontakGerhanaLokal(contact["MX"], tmZn3));
    print("");

    print("Kontak U3");
    print(se.formatKontakGerhanaLokal(contact["U3"], tmZn3));
    print("");

    print("Kontak U4");
    print(se.formatKontakGerhanaLokal(contact["U4"], tmZn3));
    print("");

    //DATA EPHEMERIS MATAHARI SAAT PUNCAK GERHANA

    print(se.formatEphemerisMX(contact["MX"]));
  }

  // INPUT GERHANA MATAHARI GLOBAL
  final blnH4 = 5;
  final thnH4 = 1437;

  print("========================================");
  print("     DATA GERHANA MATAHARI GLOBAL");
  print("========================================");
  print("Bulan Hijriah : $blnH4");
  print("Tahun Hijriah : $thnH4");
  print("");

  final resSEG = se.solarEclipseGlobal(blnH: blnH4, thnH: thnH4);

  if (resSEG["ADA"] == false) {
    print(resSEG["KET"]);
  } else {
    print("Jenis Gerhana      : ${resSEG["JSE"]}");
    print("Magnitude Gerhana  : ${resSEG["MAG"]}");
    print("Durasi Gerhana     : ${resSEG["DUR"]}");
    print("Lebar Gerhana      : ${resSEG["lbr"]}");

    print("");

    final kontakList = [
      "P1",
      "P2",
      "U1",
      "U2",
      "C1",
      "MX",
      "C2",
      "U3",
      "U4",
      "P3",
      "P4",
    ];

    for (var k in kontakList) {
      print("Kontak $k");
      print(se.formatKontakGerhana(resSEG[k]));
      print("");
    }
  }
}
