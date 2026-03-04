import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/math/math_utils.dart';
import 'package:myhisab/src/core/astronomy/moon_function.dart';
import 'package:myhisab/src/model/salat/salat_status.dart';
import 'package:myhisab/src/model/salat/salat_value.dart';
import 'package:myhisab/src/service/salat_service.dart';
import 'package:myhisab/src/service/calendar_service.dart';
import 'package:myhisab/src/service/lunar_eclipse_service.dart';
import 'package:myhisab/src/service/solar_eclipse_service.dart';
import 'package:myhisab/src/service/moon_service.dart';
import 'package:myhisab/src/service/sun_service.dart';
import 'package:myhisab/src/service/qibla_service.dart';
import 'package:myhisab/src/service/hisab_awal_bulan_service.dart';
import '../model/solar_eclipse/solar_eclipse_local_result.dart';
import '../model/solar_eclipse/solar_eclipse_global_result.dart';

void main() {
  final cs = CalendarService();
  final le = LunarEclipseService();
  final se = SolarEclipseService();
  final jd = JulianDay();
  final mf = MathFunction();
  final mo = MoonFunction();
  final moonService = MoonService();
  final sunService = SunService();

  print("======================");
  print("DATA MATAHARI");
  print("======================");

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

  print("JD                   : ${res2.jd}");
  print("DeltaT               : ${res2.deltaT}");

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

  print("Distance KM          : ${res2.geoDistanceKm}");
  print("Distance AU          : ${res2.geoDistanceAu}");
  print("Distance ER          : ${res2.geoDistanceEr}");

  print(
    "Right Ascension      : ${mf.dddms(res2.geoRightAscensionApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Declination          : ${mf.dddms(res2.geoDeclinationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Greenwich HA         : ${mf.dhhms(res2.geoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res2.geoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

  print(
    "Azimuth              : ${mf.dddms(res2.geoAzimuthApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude             : ${mf.dddms(res2.geoAltitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

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

  print(
    "Greenwich HA         : ${mf.dhhms(res2.topoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res2.topoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

  print(
    "Semidiameter         : ${mf.dddms(res2.topoSemidiameterApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

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

  print("Distance KM          : ${res.geoDistanceKm}");
  print("Distance AU          : ${res.geoDistanceAu}");
  print("Distance ER          : ${res.geoDistanceEr}");

  print(
    "Right Ascension      : ${mf.dddms(res.geoRightAscensionApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Declination          : ${mf.dddms(res.geoDeclinationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Greenwich HA         : ${mf.dhhms(res.geoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res.geoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

  print(
    "Azimuth              : ${mf.dddms(res.geoAzimuthApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude             : ${mf.dddms(res.geoAltitudeApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Horizontal Parallax  : ${mf.dddms(res.geoHorizontalParallax, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Semidiameter         : ${mf.dddms(res.geoSemidiameter, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Phase Angle          : ${mf.dddms(res.geoPhaseAngle, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print("Illuminated Fraction : ${res.geoIlluminatedFraction}");
  print(
    "Bright Limb Angle    : ${mf.dddms(res.geoBrightLimbAngle, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Sun-Moon Elongation  : ${mf.dddms(res.geoSunElongation, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print("======================");
  print("TOPOCENTRIC (APPARENT)");
  print("======================");

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

  print(
    "Greenwich HA         : ${mf.dhhms(res.topoGreenwichHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );
  print(
    "Local HA             : ${mf.dhhms(res.topoLocalHourAngleApparent / 15, optResult: "HHMMSS", posNegSign: "", secDecPlaces: 2)}",
  );

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
    "Sun-Moon Elongation : ${mf.dddms(res.topoSunElongationApparent, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");

  print("========================================");
  print("       WAKTU SALAT HARIAN");
  print("========================================");

  final ss = SalatService();

  final result4 = ss.waktuSalatHarian(
    tglM: 24,
    blnM: 2,
    thnM: 2026,
    gLon: (107 + 36 / 60),
    gLat: -(7 + 5 / 60),
    elev: 0,
    tmZn: 7,
    ihty: 2,
  );

  void printSalat(String nama, SalatValue value) {
    if (value.isNormal) {
      print(
        "${nama.padRight(12)} : ${mf.dhhm(value.time!, optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
      );
    } else {
      print("${nama.padRight(12)} : ${value.status.label}");
    }
  }

  printSalat("Subuh", result4.subuh);
  printSalat("Syuruq", result4.syuruk);
  printSalat("Duha", result4.duha);
  printSalat("Zuhur", result4.zuhur);
  printSalat("Asar", result4.asar);
  printSalat("Magrib", result4.magrib);
  printSalat("Isya", result4.isya);
  printSalat("Nisfu Lail", result4.nisfuLail);

  print("");

  //Waktu salat untuk rentang tanggal
  print("========================================");
  print("       WAKTU SALAT BULANAN");
  print("========================================");

  final jadwal = ss.getSalatRange(
    tglAwal: 24,
    blnAwal: 2,
    thnAwal: 2026,
    tglAkhir: 3,
    blnAkhir: 3,
    thnAkhir: 2026,
    gLon: 107.6,
    gLat: -7.08,
    elev: 0,
    tmZn: 7,
    ihty: 2,
  );

  for (final item in jadwal) {
    // ignore: unnecessary_string_interpolations
    print("${jd.jdkm(item["jd"], 0, "")}");

    print(
      "Subuh       : ${mf.dhhm(item["subuh"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "Syuruk      : ${mf.dhhm(item["syuruk"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "Duha        : ${mf.dhhm(item["duha"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "Zuhur       : ${mf.dhhm(item["zuhur"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "Asar        : ${mf.dhhm(item["asar"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "Magrib      : ${mf.dhhm(item["magrib"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "Isya        : ${mf.dhhm(item["isya"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "Nisfu Lail  : ${mf.dhhm(item["nisfuLail"], optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
    );

    print("----------------------------------");
  }

  print("========================================");
  print("       ARAH KIBLAT");
  print("========================================");

  final qiblaService = QiblaService();

  final res3 = qiblaService.getQibla(
    tglM: 23,
    blnM: 2,
    thnM: 2026,
    gLon: 107.6576575,
    gLat: -6.9754746,
    tmZn: 7.0,
    azQiblat: "spherical", // "spherical", "ellipsoid", atau "vincenty"
  );

  print(
    "Arah Spherical   : ${mf.dddms(res3.arahSpherical, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Arah Ellipsoid   : ${mf.dddms(res3.arahEllipsoid, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Arah Vincenty    : ${mf.dddms(res3.arahVincenty, optResult: "DDDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("Jarak Spherical  : ${res3.jarakSphericalKm} KM");
  print("Jarak Ellipsoid  : ${res3.jarakEllipsoidKm} KM");
  print("Jarak Vincenty   : ${res3.jarakVincentyKm} KM");

  print(
    "BQ1              : ${mf.dhhms(res3.bayangan1, optResult: "HH:MM:SS", posNegSign: "", secDecPlaces: 0)}",
  );
  print(
    "BQ2              : ${mf.dhhms(res3.bayangan2, optResult: "HH:MM:SS", posNegSign: "", secDecPlaces: 0)}",
  );

  print("");
  print("=== RASHDUL QIBLAT ===");
  print("Rashdul Qiblat Pertama");
  print("Tgl        : ${jd.jdkm(res3.rashdul1.jd, 0, "")}");
  print(
    "Jam        : ${mf.dhhm(res3.rashdul1.jamDes, optResult: "HH:MM:SS", posNegSign: "", minDecPlaces: 0)}",
  );
  print(
    "Tinggi     : ${mf.dddms(res3.rashdul1.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );
  print(
    "Deklinasi  : ${mf.dddms(res3.rashdul1.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );

  print("");
  print("Rashdul Qibllat Kedua");
  print("tgl        : ${jd.jdkm(res3.rashdul2.jd, 0, "")}");
  print(
    "Jam        : ${mf.dhhm(res3.rashdul2.jamDes, optResult: "HH:MM:SS", posNegSign: "", minDecPlaces: 0)}",
  );
  print(
    "Tinggi     : ${mf.dddms(res3.rashdul2.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );
  print(
    "Deklinasi  : ${mf.dddms(res3.rashdul2.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );

  print("");
  print("=== ANTIPODA QIBLAT ===");
  print("Antipoda Qiblat Pertama");
  print("Tgl       : ${jd.jdkm(res3.antipoda1.jd, 0, "")}");
  print(
    "Jam       : ${mf.dhhm(res3.antipoda1.jamDes, optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
  );
  print(
    "Tinggi    : ${mf.dddms(res3.antipoda1.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );
  print(
    "Deklinasi : ${mf.dddms(res3.antipoda1.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );

  print("");
  print("Antipoda Qiblat Kedua");
  print("Tgl       : ${jd.jdkm(res3.antipoda2.jd, 0, "")}");
  print(
    "Jam       : ${mf.dhhm(res3.antipoda2.jamDes, optResult: "HH:MM", posNegSign: "", minDecPlaces: 0)}",
  );
  print(
    "Tinggi    : ${mf.dddms(res3.antipoda2.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );
  print(
    "Deklinasi : ${mf.dddms(res3.antipoda2.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
  );

  print("");

  //Bayangan kiblat harian untuk rentang tanggal

  print("=== BAYANGAN KIBLAT HARIAN ===");
  final hasil = qiblaService.getQiblaRange(
    tglAwal: 20,
    blnAwal: 2,
    thnAwal: 2026,
    tglAkhir: 25,
    blnAkhir: 2,
    thnAkhir: 2026,
    gLon: 107.6576575,
    gLat: -6.9754746,
    tmZn: 7,
    azQiblat: "spherical", // "spherical", "ellipsoid", atau "vincenty"
  );

  for (var data in hasil) {
    print("TGL : ${jd.jdkm(data["jd"], 0, "")}");
    print(
      "BQ1 : ${mf.dhhms(data["bayangan1"], optResult: "HH:MM:SS", posNegSign: "", secDecPlaces: 0)}",
    );
    print(
      "BQ2 : ${mf.dhhms(data["bayangan2"], optResult: "HH:MM:SS", posNegSign: "", secDecPlaces: 0)}",
    );
    print("------------------------");
  }

  // Rashdul Qiblat untuk rentang tahun
  print("=== RASHDUL QIBLAT ===");
  final hasil2 = qiblaService.getRashdulRange(
    tahunAwal: 2026,
    tahunAkhir: 2030,
    tmZn: 7,
  );

  for (var item in hasil2) {
    print("========== Tahun ${item["tahun"]} ==========");

    final r1 = item["rashdul1"];
    final r2 = item["rashdul2"];

    print("RQ 1 Tgl       : ${jd.jdkm(r1.jd, 0, "")}");
    print(
      "RQ 1 Jam       : ${mf.dhhm(r1.jamDes, optResult: "HH:MM:SS", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "RQ 1 Tinggi    : ${mf.dddms(r1.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print(
      "RQ 1 Deklinasi : ${mf.dddms(r1.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print("");

    print("RQ 2 Tgl       : ${jd.jdkm(r2.jd, 0, "")}");
    print(
      "RQ 2 Jam       : ${mf.dhhm(r2.jamDes, optResult: "HH:MM:SS", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "RQ 2 Tinggi    : ${mf.dddms(r2.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print(
      "RQ 2 Deklinasi : ${mf.dddms(r2.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print("\n");
  }

  // Rashdul Qiblat untuk rentang tahun
  print("=== ANTIPODA QIBLAT ===");
  final hasil3 = qiblaService.getAntipodaRange(
    tahunAwal: 2026,
    tahunAkhir: 2030,
    tmZn: 7,
  );

  for (var item in hasil3) {
    print("========== Tahun ${item["tahun"]} ==========");

    final r1 = item["antipoda1"];
    final r2 = item["antipoda2"];

    print("AQ 1 Tgl       : ${jd.jdkm(r1.jd, 0, "")}");
    print(
      "AQ 1 Jam       : ${mf.dhhm(r1.jamDes, optResult: "HH:MM:SS", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "AQ 1 Tinggi    : ${mf.dddms(r1.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print(
      "AQ 1 Deklinasi : ${mf.dddms(r1.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print("");

    print("AQ 2 Tgl       : ${jd.jdkm(r2.jd, 0, "")}");
    print(
      "AQ 2 Jam       : ${mf.dhhm(r2.jamDes, optResult: "HH:MM:SS", posNegSign: "", minDecPlaces: 0)}",
    );
    print(
      "AQ 2 Tinggi    : ${mf.dddms(r2.tinggi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print(
      "AQ 2 Deklinasi : ${mf.dddms(r2.deklinasi, optResult: "DDDMMSS", sdp: 0, posNegSign: "+-")}",
    );
    print("\n");
  }

  print("========================================");
  print("        HISAB AWAL BULAN HIJRIAH");
  print("========================================");
  final String loc = "Pelabuhan Ratu";
  final int blnH = 10;
  final int thnH = 1447;
  final double gLon = (106 + 33 / 60 + 27.8 / 3600);
  final double gLat = -(7 + 1 / 60 + 44.6 / 3600);
  final double tmZn = 7;
  final double elev = 52.685;
  final double pres = 1010;
  final double temp = 10;
  final int tbhHari = 0;
  final int optKriteria = 1; // 1. imkan rukyat 2. Wujudul Hilal

  final service = HisabAwalBulanService();

  final rs = service.hitung(
    blnH: blnH,
    thnH: thnH,
    gLon: gLon,
    gLat: gLat,
    tmZn: tmZn,
    elev: elev,
    pres: pres,
    temp: temp,
    tbhHari: tbhHari,
    optKriteria: optKriteria,
  );

  print("Lokasi                     : $loc");
  print(
    "Bujur                      : ${mf.dddms(gLon, optResult: "BBBT", sdp: 0, posNegSign: "+-")}",
  );
  print(
    "Lintang                    : ${mf.dddms(gLat, optResult: "LULS", sdp: 0, posNegSign: "+-")}",
  );
  print("Time Zone                  : $tmZn");
  print("Elevasi                    : $elev");
  print("");
  print(
    "Ijtimak Geosentris         : "
    "${jd.jdkm(rs.geojdIjtimak, tmZn, "")} | "
    "${mf.dhhms(double.parse(jd.jdkm(rs.geojdIjtimak, tmZn, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );
  print(
    "Ijtimak Toposentris        : "
    "${jd.jdkm(rs.topojdIjtimak, tmZn, "")} | "
    "${mf.dhhms(double.parse(jd.jdkm(rs.topojdIjtimak, tmZn, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );
  print(
    "Ghurub Matahari            : ${mf.dhhms(double.parse(jd.jdkm(rs.sunsetJD, tmZn, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );
  print(
    "Ghurub Bulan               : "
    "${rs.moonsetJD == null ? "Tidak terbenam" : mf.dhhms(double.parse(jd.jdkm(rs.moonsetJD!, tmZn, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );
  print(
    "Imkan Rukyat MABIMS        : ${rs.imkanMabimsStatus == 1 ? "Visible" : "Not Visible"}",
  );
  print(
    "Imkan Rukyat Turki         : ${rs.imkanTurkiStatus == 1 ? "Visible" : "Not Visible"}",
  );
  print(
    "wujudul Hilal              : ${rs.wujudHilalStatus == 1 ? "Wujud" : "Tidak Wujud"}",
  );
  //print("JD Awal Bulan              : ${jd.jdkm(rs.hilal.awalBulanJD)}");

  print("");
  print(".......Data Matahari Geosentris.......");
  print(
    "True Longitude             : ${mf.dddms(rs.sunGeo.longitudeTrue, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "True Latitude              : ${mf.dddms(rs.sunGeo.latitudeTrue, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Longitude         : ${mf.dddms(rs.sunGeo.longitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Latitude          : ${mf.dddms(rs.sunGeo.latitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Apparent Right Ascensioan  : ${mf.dddms(rs.sunGeo.rightAscension, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Declination       : ${mf.dddms(rs.sunGeo.declination, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Greenwich Sideral Time     : ${mf.dddms(rs.sunGeo.greenwichApparentSiderealTime, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Local Sidereal Time        : ${mf.dddms(rs.sunGeo.localApparentSiderealTime, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Greenwich Hour Angle       : ${mf.dddms(rs.sunGeo.greenwichHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Local Hour Angle           : ${mf.dddms(rs.sunGeo.localHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Azimuth                    : ${mf.dddms(rs.sunGeo.azimuth, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude                   : ${mf.dddms(rs.sunGeo.altitude, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(".......Data Matahari Toposentris.......");
  print(
    "Apparent Longitude         : ${mf.dddms(rs.sunTopo.longitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Latitude          : ${mf.dddms(rs.sunTopo.latitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Apparent Right Ascension   : ${mf.dddms(rs.sunTopo.rightAscension, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Declination       : ${mf.dddms(rs.sunTopo.declination, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Greenwich Hour Angle       : ${mf.dddms(rs.sunTopo.greenwichHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Local Hour Angle           : ${mf.dddms(rs.sunTopo.localHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Azimuth                    : ${mf.dddms(rs.sunTopo.azimuth, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Altitude Airless Upper     : ${mf.dddms(rs.sunTopo.altitudeAirlessUpper, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Airless Center    : ${mf.dddms(rs.sunTopo.altitudeAirlessCenter, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Airless Lower     : ${mf.dddms(rs.sunTopo.altitudeAirlessLower, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Altitude Apparent Upper    : ${mf.dddms(rs.sunTopo.altitudeApparentUpper, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Apparent Center   : ${mf.dddms(rs.sunTopo.altitudeApparentCenter, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Apparent Lower    : ${mf.dddms(rs.sunTopo.altitudeApparentLower, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Altitude Observered Upper  : ${mf.dddms(rs.sunTopo.altitudeObserveredUpper, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Observered Center : ${mf.dddms(rs.sunTopo.altitudeObserveredCenter, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Observered Lower  : ${mf.dddms(rs.sunTopo.altitudeObserveredLower, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(".......Data Bulan Geosentris.......");
  print(
    "True Longitude             : ${mf.dddms(rs.moonGeo.longitudeTrue, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "True Latitude              : ${mf.dddms(rs.moonGeo.latitudeTrue, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Longitude         : ${mf.dddms(rs.moonGeo.longitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Latitude          : ${mf.dddms(rs.moonGeo.latitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Apparent Right Ascension   : ${mf.dddms(rs.moonGeo.rightAscension, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Declination       : ${mf.dddms(rs.moonGeo.declination, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Greenwich Hour Angle       : ${mf.dddms(rs.moonGeo.greenwichHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Local Hour Angle           : ${mf.dddms(rs.moonGeo.localHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Azimuth                    : ${mf.dddms(rs.moonGeo.azimuth, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude                   : ${mf.dddms(rs.moonGeo.altitude, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Illumination Fraction      : ${mf.dddms(rs.moonGeo.diskIlluminationFraction, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Phase Angle                : ${mf.dddms(rs.moonGeo.phaseAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Bright Limb Angle          : ${mf.dddms(rs.moonGeo.brightLimbAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Moon-Sun Elongation        : ${mf.dddms(rs.hilal.elongationGeo, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Crescent Width             : ${mf.dddms(rs.hilal.crescentWidthGeo, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Relative Altitude          : ${mf.dddms(rs.hilal.relativeAltitudeGeo, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(".......Data Bulan Toposentris.......");
  print(
    "Apparent Longitude         : ${mf.dddms(rs.moonTopo.longitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Latitude          : ${mf.dddms(rs.moonTopo.latitudeApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Apparent Right Ascension   : ${mf.dddms(rs.moonTopo.rightAscension, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Apparent Declination       : ${mf.dddms(rs.moonTopo.declination, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Greenwich Hour Angle       : ${mf.dddms(rs.moonTopo.greenwichHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Local Hour Angle           : ${mf.dddms(rs.moonTopo.localHourAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Azimuth                    : ${mf.dddms(rs.moonTopo.azimuth, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Altitude Airless Upper     : ${mf.dddms(rs.moonTopo.altitudeAirlessUpper, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Airless Center    : ${mf.dddms(rs.moonTopo.altitudeAirlessCenter, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Airless Lower     : ${mf.dddms(rs.moonTopo.altitudeAirlessLower, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Altitude Apparent Upper    : ${mf.dddms(rs.moonTopo.altitudeApparentUpper, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Apparent Center   : ${mf.dddms(rs.moonTopo.altitudeApparentCenter, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Apparent Lower    : ${mf.dddms(rs.moonTopo.altitudeApparentLower, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Altitude Observered Upper  : ${mf.dddms(rs.moonTopo.altitudeObservedUpper, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Observered Center : ${mf.dddms(rs.moonTopo.altitudeObservedCenter, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Altitude Observered Lower  : ${mf.dddms(rs.moonTopo.altitudeObservedLower, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Illumination Fraction      : ${mf.dddms(rs.moonTopo.diskIlluminationFraction, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Phase Angle                : ${mf.dddms(rs.moonTopo.phaseAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Bright Limb Angle          : ${mf.dddms(rs.moonTopo.brightLimbAngle, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print(
    "Moon-Sun Elongation        : ${mf.dddms(rs.hilal.elongationTopo, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Crescent Width             : ${mf.dddms(rs.hilal.crescentWidthTopo, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "Relative Altitude          : ${mf.dddms(rs.hilal.relativeAltitudeTopo, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
  );

  print("");
  print(".......Data-data lainnya.......");
  print("Range-q Odeh               : ${rs.hilal.qOdeh}");
  print(
    "Best Time                  : ${mf.dhhms(double.parse(jd.jdkm(rs.hilal.bestTime, tmZn, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );

  print("");

  // print("========================================");
  // print("        HISAB AWAL BULN HIJRIAH");
  // print("========================================");

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

  // //input Bulan dan Tahun Hijri
  // final blnH = 10;
  // final thnH = 1447;

  // final abqSesuaiLokasi = ab.hisabAwalBulanHijriahSesuaiLokasi(
  //   nmLokasi: "Pelabuhan Ratu",
  //   blnH: blnH,
  //   thnH: thnH,
  //   gLon: (106 + 33 / 60 + 27.8 / 3600),
  //   gLat: -(7 + 1 / 60 + 44.6 / 3600),
  //   elev: 52.685,
  //   tmZn: 7,
  //   pres: 1010,
  //   temp: 10,
  //   sdp: 2,
  //   tbhHari: 0,
  //   optKriteria: 2,
  // );

  //Konversi Hijri ke Masehi

  print(".......KESIMPULAN.......");

  final namaBlnH = namaBulanHijriah[blnH - 1];

  final jdAbqMabims = cs.abqMabims(blnH, thnH);
  print("1 $namaBlnH $thnH H (MABIMS)       : ${jd.jdkm(jdAbqMabims)}");

  final jdAbqWH = cs.abqWujudulHilal(blnH, thnH);
  print("1 $namaBlnH $thnH H (Wujud Hilal)  : ${jd.jdkm(jdAbqWH)}");

  final jdAbqTurki = cs.abqTurki(blnH, thnH);
  print("1 $namaBlnH $thnH H (TURKI/KHGT)   : ${jd.jdkm(jdAbqTurki)}");

  print("");

  //Konversi Masehi ke Hijri Hakiki

  final tglM = 21;
  final blnM = 3;
  final thnM = 2026;

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

  print("========================================");
  print("     DATA GERHANA MATAHARI LOKAL");
  print("========================================");
  print("");

  if (resSEL == null || !resSEL.ada) {
    print("Tidak ada gerhana di lokasi ini.");
  } else {
    final b = resSEL.besselian;

    print("========================================");
    print("ELEMEN BESSELIAN");
    print("========================================");

    void printList(String label, List<double>? list) {
      if (list == null || list.isEmpty) return;

      for (int i = 0; i < list.length; i++) {
        print("  $label$i : ${list[i]}");
      }
      print("");
    }

    // tampilkan jde, deltaT, t0 (hanya jika tidak null)
    if (b.jde != null) print("JDE     : ${b.jde}");
    if (b.deltaT != null) print("Delta T : ${b.deltaT}");
    if (b.t0 != null) print("T0      : ${b.t0}");
    print("");

    printList("x", b.x);
    printList("y", b.y);
    printList("d", b.d);
    printList("mu", b.mu);
    printList("l1", b.l1);
    printList("l2", b.l2);

    if (b.tanf1 != null) print("tanf1 : ${b.tanf1}");
    if (b.tanf2 != null) print("tanf2 : ${b.tanf2}");
    print("");

    print("----------------------------------");

    if (resSEL.jenis != null) {
      print("Jenis Gerhana  : ${resSEL.jenis}");
    }
    if (resSEL.magnitude != null) {
      print("Magnitude      : ${resSEL.magnitude}");
    }
    if (resSEL.obscuration != null) {
      print("Obskurasi      : ${resSEL.obscuration}");
    }
    if (resSEL.durasiGerhana != null) {
      print("Durasi Umbra   : ${resSEL.durasiGerhana}");
    }
    if (resSEL.durasiTotalitas != null) {
      print("Durasi Total   : ${resSEL.durasiTotalitas}");
    }
    print("");

    // helper kontak lokal
    void printContact(String label, EclipseContact? c) {
      if (c == null) return;

      if (c.jd == null && c.azimuth == null && c.altitude == null) {
        return;
      }

      print(label);

      if (c.jd != null) print("  JD   : ${c.jd}");
      if (c.azimuth != null) print("  Azm  : ${c.azimuth}");
      if (c.altitude != null) print("  Alt  : ${c.altitude}");

      print("");
    }

    print("KONTAK GERHANA");
    print("----------------------------------------");

    printContact("U1 (Kontak Awal Umbra)", resSEL.u1);
    printContact("U2 (Totalitas Mulai)", resSEL.u2);
    printContact("MX (Puncak Gerhana)", resSEL.mx);
    printContact("U3 (Totalitas Akhir)", resSEL.u3);
    printContact("U4 (Kontak Akhir Umbra)", resSEL.u4);

    print("========================================");
    print("DATA MATAHARI & BULAN SAAT PUNCAK");
    print("========================================");

    final eph = resSEL.ephemerisMaximum;

    if (eph != null) {
      if (eph.sun != null) {
        if (eph.sun!.ra != null) print("MATAHARI");
        if (eph.sun!.ra != null) print("  RA  : ${eph.sun!.ra}");
        if (eph.sun!.dec != null) print("  DEC : ${eph.sun!.dec}");
        if (eph.sun!.sd != null) print("  SD  : ${eph.sun!.sd}");
        if (eph.sun!.hp != null) print("  HP  : ${eph.sun!.hp}");
        print("");
      }

      if (eph.moon != null) {
        if (eph.moon!.ra != null) print("BULAN");
        if (eph.moon!.ra != null) print("  RA  : ${eph.moon!.ra}");
        if (eph.moon!.dec != null) print("  DEC : ${eph.moon!.dec}");
        if (eph.moon!.sd != null) print("  SD  : ${eph.moon!.sd}");
        if (eph.moon!.hp != null) print("  HP  : ${eph.moon!.hp}");
      }
    }
  }

  print("========================================");
  print("     DATA GERHANA MATAHARI GLOBAL");
  print("========================================");
  print("");

  // INPUT GERHANA MATAHARI GLOBAL
  final blnH4 = 11;
  final thnH4 = 1439;

  final resSEG = se.solarEclipseGlobal(blnH: blnH4, thnH: thnH4);

  print("Bulan Hijriah : $blnH4");
  print("Tahun Hijriah : $thnH4");
  print("");

  if (resSEG == null || !resSEG.ada) {
    print("Tidak ada gerhana");
  } else {
    final bs = resSEG.besselian;

    print("========================================");
    print("ELEMEN BESSELIAN");
    print("========================================");

    void printList2(String label, List<double>? list) {
      if (list == null) {
        print("$label : -");
        return;
      }

      for (int i = 0; i < list.length; i++) {
        print("  $label$i : ${list[i]}");
      }
    }

    // tampilkan jde, deltaT, t0
    print("JDE     : ${bs.jde}");
    print("Delta T : ${bs.deltaT}");
    print("T0      : ${bs.t0}");
    print("");

    printList2("x", bs.x);
    print("");
    printList2("y", bs.y);
    print("");
    printList2("d", bs.d);
    print("");
    printList2("mu", bs.mu);
    print("");
    printList2("l1", bs.l1);
    print("");
    printList2("l2", bs.l2);
    print("");

    print("tanf1 : ${bs.tanf1}");
    print("tanf2 : ${bs.tanf2}");
    print("");

    print("----------------------------------");

    if (resSEG.jenis != null) {
      print("Jenis Gerhana    : ${resSEG.jenis}");
    }
    if (resSEG.magnitude != null) {
      print("Magnitude        : ${resSEG.magnitude}");
    }
    if (resSEG.lebar != null) {
      print("Lebar            : ${resSEG.lebar}");
    }
    if (resSEG.durasiGerhana != null) {
      print("Durasi Gerhana   : ${resSEG.durasiGerhana}");
    }
    if (resSEG.durasiTotalitas != null) {
      print("Durasi Totalitas : ${resSEG.durasiTotalitas}");
    }
    print("");

    // helper untuk kontak gerhana
    void printContactGlobal(String label, EclipseContactGlobal? c) {
      if (c == null) return;

      if (c.jd == null &&
          c.jd2 == null &&
          c.longitude == null &&
          c.latitude == null &&
          c.azimuth == null &&
          c.altitude == null) {
        return;
      }

      print(label);

      if (c.jd != null) print("  JDTD : ${c.jd}");
      if (c.jd2 != null) print("  JDUT : ${c.jd2}");
      if (c.longitude != null) print("  lon  : ${c.longitude}");
      if (c.latitude != null) print("  lat  : ${c.latitude}");
      if (c.azimuth != null) print("  Azm  : ${c.azimuth}");
      if (c.altitude != null) print("  Alt  : ${c.altitude}");

      print("");
    }

    print("KONTAK GERHANA");
    print("----------------------------------------");

    printContactGlobal("P1 (Kontak Awal Umbra)", resSEG.p1);
    printContactGlobal("U1 (Kontak Awal Umbra)", resSEG.u1);
    printContactGlobal("C1 (Kontak Awal Umbra)", resSEG.c1);
    printContactGlobal("U2 (Totalitas Mulai)", resSEG.u2);
    printContactGlobal("P2 (Kontak Awal Umbra)", resSEG.p2);
    printContactGlobal("MX (Puncak Gerhana)", resSEG.mx);
    printContactGlobal("P3 (Kontak Awal Umbra)", resSEG.p3);
    printContactGlobal("U3 (Totalitas Akhir)", resSEG.u3);
    printContactGlobal("C2 (Kontak Awal Umbra)", resSEG.c2);
    printContactGlobal("U4 (Kontak Akhir Umbra)", resSEG.u4);
    printContactGlobal("P4 (Kontak Awal Umbra)", resSEG.p4);

    print("========================================");
    print("DATA MATAHARI & BULAN SAAT PUNCAK");
    print("========================================");

    final eph2 = resSEG.ephemerisMaximum;

    if (eph2 != null) {
      print("MATAHARI");
      print("  RA  : ${eph2.sun?.ra}");
      print("  DEC : ${eph2.sun?.dec}");
      print("  SD  : ${eph2.sun?.sd}");
      print("  HP  : ${eph2.sun?.hp}");
      print("");

      print("BULAN");
      print("  RA  : ${eph2.moon?.ra}");
      print("  DEC : ${eph2.moon?.dec}");
      print("  SD  : ${eph2.moon?.sd}");
      print("  HP  : ${eph2.moon?.hp}");
    }
  }

  print("");

  print("=============================================");
  print("DATA GERHANA MATAHARI LOKAL PER RENTANG TAHUN");
  print("=============================================");

  //GERHANA PER RENTANG TAHUN
  final thnAwwalHijri = 1440;
  final thnAkhirHijri = 1450;
  final gLon6 = (108 + 17 / 60.0 + 50 / 3600.0);
  final gLat6 = -(2 + 51 / 60.0 + 25 / 3600.0);
  final elev6 = 2.0;
  final pres6 = 1010.0;
  final temp6 = 10.0;
  double tmZn6 = 7.0;

  final selRange = se.solarEclipseLocalRangeHijri(
    tahunAwalH: thnAwwalHijri,
    tahunAkhirH: thnAkhirHijri,
    gLon: gLon6,
    gLat: gLat6,
    elev: elev6,
    pres: pres6,
    temp: temp6,
    tmZn: tmZn6,
    timeScale: TimeScale.jdTD,
  );

  for (final e in selRange) {
    print("=================================");
    print("Tahun H   : ${e.tahunHijri}");
    print("Bulan H   : ${e.bulanHijri}");

    List<double?> altitudes = [e.altU1, e.altU2, e.altMax, e.altU3, e.altU4];
    bool terlihat = altitudes.any((alt) => alt != null && alt > 0);

    if (!terlihat) {
      print("Gerhana tidak terlihat di lokasi");
      continue;
    }

    print("Jenis     : ${e.jenis}");
    print("U1        : ${e.u1}");
    print("Max       : ${e.max}");
    print("U4        : ${e.u4}");
    print("Durasi    : ${e.durasi}");
  }

  print("");
  print("==============================================");
  print("DATA GERHANA MATAHARI GLOBAL PER RENTANG TAHUN");
  print("==============================================");

  //GERHANA PER RENTANG TAHUN
  final thnAwwalHijri2 = 1440;
  final thnAkhirHijri2 = 1450;

  final segRange = se.solarEclipseGlobalRangeHijri(
    tahunAwalH: thnAwwalHijri2,
    tahunAkhirH: thnAkhirHijri2,
    timeScale: TimeScale.jdUT,
  );

  for (final e in segRange) {
    print("=================================");
    print("Tahun H  : ${e.tahunHijri}");
    print("Bulan H  : ${e.bulanHijri}");
    print("Jenis    : ${e.jenis}");
    print("P1       : ${e.p1}");
    print("Max      : ${e.max}");
    print("P4       : ${e.p4}");
    print("Durasi   : ${e.durasi}");
  }
}
