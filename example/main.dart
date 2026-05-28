import 'package:persis_times/persis_times.dart';

// import '../model/solar_eclipse/solar_eclipse_local_result.dart';
// import '../model/solar_eclipse/solar_eclipse_global_result.dart';
// import '../model/lunar_eclipse/lunar_eclipse_global_range_result.dart';
// import '../model/lunar_eclipse/lunar_eclipse_local_range_result.dart';

void main() {
  final cs = CalendarService();
  final le = LunarEclipseService();
  final se = SolarEclipseService();
  final jd = JulianDay();
  final mf = MathFunction();
  final moonService = MoonService();
  final sunService = SunService();

  print("======================");
  print("DATA MATAHARI");
  print("======================");

  final res2 = sunService.calculate(
    tglM: 19,
    blnM: 5,
    thnM: 2026,
    jam: 6,
    menit: 32,
    detik: 5,
    gLon: (107 + 31 / 60.0 + 2.73 / 3600.0),
    gLat: -(6 + 58 / 60.0 + 15.83 / 3600.0),
    elev: 738,
    tmZn: 7.0,
    temp: 10.0,
    pres: 1010.0,
    deltaTOverride:
        0.0, //default kalau tanpa deltaToverride maka otomatis menggunakan rumus deltaT
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
    "Declination          : ${mf.dddms(res2.geoDeclinationApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
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
    "Semidiameter         : ${mf.dddms(res2.geoSemidiameter, optResult: "MMSS", sdp: 2, posNegSign: "+-")}",
  );
  print(
    "equation of Time     : ${mf.dhhms(res2.equationOfTime, optResult: "MMSS", secDecPlaces: 0, posNegSign: "+-")}",
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
    "Declination          : ${mf.dddms(res2.topoDeclinationApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
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
    tglM: 3,
    blnM: 3,
    thnM: 2026,
    jam: 6,
    menit: 32,
    detik: 5,
    gLon: (107 + 31 / 60.0 + 2.73 / 3600.0),
    gLat: -(6 + 58 / 60.0 + 15.83 / 3600.0),
    elev: 738.0,
    tmZn: 7.0,
    temp: 10.0,
    pres: 1010.0,
    deltaTOverride:
        0.0, //default kalau tanpa deltaToverride maka otomatis menggunakan rumus deltaT
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
    "Declination          : ${mf.dddms(res.geoDeclinationApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
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
    "Declination          : ${mf.dddms(res.topoDeclinationApparent, optResult: "DDMMSS", sdp: 2, posNegSign: "+-")}",
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

  //terbit-transit-terbenam Bulan
  final tmZn5 = 7.0;
  print(
    "Bulan Terbit       : "
    "${res.jdMoonRise == null ? "-" : mf.dhhms(double.parse(jd.jdkm(res.jdMoonRise!, tmZn5, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );

  print(
    "Bulan Transit      : "
    "${res.jdMoonTransit == null ? "-" : mf.dhhms(double.parse(jd.jdkm(res.jdMoonTransit!, tmZn5, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );

  print(
    "Bulan Terbenam     : "
    "${res.jdMoonSet == null ? "-" : mf.dhhms(double.parse(jd.jdkm(res.jdMoonSet!, tmZn5, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  );

  print("");

  print("========================================");
  print("       WAKTU SALAT HARIAN");
  print("========================================");

  final ss = SalatService();

  final result4 = ss.waktuSalatHarian(
    tglM: 19,
    blnM: 4,
    thnM: 2026,
    gLon: (107 + 31 / 60 + 2.80 / 3600),
    gLat: -(6 + 58 / 60 + 15.84 / 3600),
    elev: 0,
    tmZn: 7,
    prayerMethod:
        PrayerMethod.persatuanIslam, // opsi tinggi matahari subuh dan isya
    ihtySubuh: 2,
    ihtySyuruk: -2,
    ihtyZuhur: 2,
    ihtyAsar: 2,
    ihtyMagrib: 2,
    ihtyIsya: 2,
  );

  void printSalat(String nama, SalatValue value) {
    if (value.isNormal) {
      print(
        //"${nama.padRight(12)} : ${value.time!}",
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

  //penjelasan
  // DAFTAR METODE PREDEFINED
  // ------------------------
  // Format: 'Nama Organisasi', hm Subuh = X°, hm Isya = Y°

  // 1. PrayerMethod.persatuanIslam
  //    hm Subuh = -20°, hm Isya = -18°

  // 2. PrayerMethod.kemenagRI
  //    hm Subuh = -20°, hm Isya = -18°

  // 3. PrayerMethod.nahdlatulUlama
  //    hm Subuh = -20°, hm Isya = -18°

  // 4. PrayerMethod.muhammadiyah
  //    hm Subuh = -18°, hm Isya = -18°

  // 5. PrayerMethod.egyptianGeneralAuthority
  //    hm Subuh = -19.5°, hm Isya = -17.5°

  // 6. PrayerMethod.islamicSocietyNorthAmerica
  //    hm Subuh = -18°, hm Isya = -18°

  // 7. PrayerMethod.muslimWorldLeague
  //    hm Subuh = -18°, hm Isya = -17°

  // 8. PrayerMethod.universityIslamicScienceKarachi
  //    hm Subuh = -18°, hm Isya = -18°

  // 9. PrayerMethod.custom(nama, hmSubuh, hmIsya)
  //    Untuk nilai custom yang bisa diinput oleh user

  // CONTOH PENGGUNAAN
  // -----------------

  // 1. Menggunakan Metode Predefined:
  //    final result = salatService.waktuSalatHarian(
  //      tglM: 19, blnM: 4, thnM: 2026,
  //      gLon: 107.517, gLat: -6.971,
  //      elev: 0, tmZn: 7,
  //      prayerMethod: PrayerMethod.persatuanIslam,
  //    );
  // 2. Menggunakan Metode Custom:
  //    final customMethod = PrayerMethod.custom(
  //      'Kriteria Masjid Raya',
  //      hmSubuh: -21.0,
  //      hmIsya: -19.0,
  //    );
  //    final result = salatService.waktuSalatHarian(
  //      // ... parameter lainnya ...
  //      prayerMethod: customMethod,
  //    );

  // 3. Lookup dari String:
  //    final selected = PrayerMethod.fromName('Muslim World League');
  //    if (selected != null) {
  //      final result = salatService.waktuSalatHarian(
  //        // ... parameter lainnya ...
  //        prayerMethod: selected,
  //      );
  //    }

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
    prayerMethod:
        PrayerMethod.persatuanIslam, // opsi tinggi matahari subuh dan isya
    ihtySubuh: 2,
    ihtySyuruk: -2,
    ihtyZuhur: 2,
    ihtyAsar: 2,
    ihtyMagrib: 2,
    ihtyIsya: 2,
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

    print("Hari           : ${jd.jdkm(r1.jd, 0, "NMHRM")}");
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

    print("Hari           : ${jd.jdkm(r2.jd, 0, "NMHRM")}");
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

  // Antipoda Qiblat untuk rentang tahun
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

  // RASHDUL QIBLAT DENGAN BULAN
  print("RASHDUL QIBLAT DENGAN BULAN");
  final arah = qiblaService.getRashdulBulanRange(
    tahunAwal: 2025,
    tahunAkhir: 2026,
    tmZn: 7,
  );

  for (var yearly in arah.data) {
    print("Tahun : ${yearly.tahun}");

    int no = 1;
    for (var e in yearly.events) {
      print("Event      : $no");
      print("JD         : ${jd.jdkm(e.jd, 7, "")}");
      print("Jam Des    : ${mf.dhhms(e.jamDes)}");
      print("Tinggi     : ${mf.dddms(e.tinggi)}");
      print("Deklinasi  : ${mf.dddms(e.deklinasi)}");
      print("---------------------------");
      no++;
    }

    print(""); // spasi antar tahun
  }

  print("========================================");
  print("        HISAB AWAL BULAN HIJRIAH");
  print("========================================");
  final String loc = "Banda Aceh";
  final int blnH = 3;
  final int thnH = 1448;
  final double gLon = (95 + 19 / 60 + 1.92 / 3600);
  final double gLat = (5 + 33 / 60 + 12.96 / 3600);
  final double tmZn = 7;
  final double elev = 20;
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
  print("deltaT                     : ${rs.deltaT}");
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

  print("Illumination Fraction      : ${rs.moonGeo.diskIlluminationFraction}");

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

  print("Illumination Fraction      : ${rs.moonTopo.diskIlluminationFraction}");

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

  // if (rs.hilal.bestTime != null) {
  //   print(
  //     "Best Time                  : ${mf.dhhms(double.parse(jd.jdkm(rs.hilal.bestTime!, 0, "JAMDES")), optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
  //   );
  // } else {
  //   "Best Time                  : - ";
  // }

  if (rs.hilal.bestTime != null) {
    print(
      "Best Time                  : ${mf.dhhms(rs.hilal.bestTime!, optResult: "HH:MM:SS", secDecPlaces: 0, posNegSign: "")}",
    );
  } else {
    "Best Time                  : - ";
  }

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

  final jdAbqUmmulQura = cs.abqUmmulQura(blnH, thnH);
  print("1 $namaBlnH $thnH H (Ummul Qura)   : ${jd.jdkm(jdAbqUmmulQura)}");

  print("");

  //Konversi Masehi ke Hijri Hakiki

  final tglM = 14;
  final blnM = 8;
  final thnM = 2026;

  final abqMabimsNow = cs.serviceKalenderHijriahMABIMS(tglM, blnM, thnM);
  print("MABIMS                          : $abqMabimsNow");

  final abqWHNow = cs.serviceKalenderHijriahWH(tglM, blnM, thnM);
  print("Wujudu Hilal                    : $abqWHNow");

  final abqTurkiNow = cs.serviceKalenderHijriahTURKI(tglM, blnM, thnM);
  print("Turki/KHGT                      : $abqTurkiNow");

  final abqUQNow = cs.serviceKalenderHijriahUQ(tglM, blnM, thnM);
  print("Ummul Qura                      : $abqUQNow");

  print(" ");

  // INPUT GERHANA BULAN
  final int blnH2 = 9;
  final int thnH2 = 1447;
  final double gLon2 = 107 + 36 / 60.0 + 22 / 3600.0;
  final double gLat2 = -(6 + 55 / 60.0 + 18 / 3600.0);
  final double elev2 = 10.0;
  final double pres2 = 1010;
  final double temp2 = 10;
  double tmZn2 = 7;

  // ========================================
  // DATA GERHANA BULAN LOKAL
  // ========================================

  final resLEL = le.lunarEclipseLocal(
    blnH: blnH2,
    thnH: thnH2,
    gLon: gLon2,
    gLat: gLat2,
    elev: elev2,
    pres: pres2,
    temp: temp2,
    tmZn: tmZn2,
  );

  print("========================================");
  print("     DATA GERHANA BULAN LOKAL");
  print("========================================");
  print("");

  // ================= PRINT BESSELIAN =================
  final bessel = le.lBesselian(blnH2, thnH2);
  if (bessel != null && bessel.isValid) {
    print("========================================");
    print("           DATA BESSELIAN");
    print("========================================");
    print("JDE     : ${bessel.jde.toStringAsFixed(5)}");
    print("Delta T : ${bessel.deltaT.toStringAsFixed(2)}");
    print("T0      : ${bessel.t0}");

    //print("x     : ${bessel.x[0].toStringAsFixed(5)}"); contoh ambil per nilai
    print("");

    void printList(String label, List<double> list) {
      for (int i = 0; i < list.length; i++) {
        print("  $label$i : ${list[i].toStringAsFixed(5).padLeft(10)}");
      }
      print("");
    }

    printList("x", bessel.x);
    printList("y", bessel.y);
    printList("f1", bessel.f1);
    printList("f2", bessel.f2);
    printList("sm", bessel.sm);
    printList("mu", bessel.mu);
    printList("hp", bessel.hp);
    printList("dm", bessel.dm);
    printList("d", bessel.d);
  }

  if (resLEL == null || !resLEL.isValid) {
    print("Tidak ada gerhana di lokasi ini.");
  } else {
    // =====================================
    // KONTAK GERHANA
    // =====================================

    void printContact(String label, double? jd, double? azm, double? alt) {
      if (jd == null && azm == null && alt == null) return;
      print(label);
      if (jd != null) print("  JD   : $jd");
      if (azm != null) print("  Azm  : $azm");
      if (alt != null) print("  Alt  : $alt");
      print("");
    }

    print("KONTAK GERHANA");
    print("----------------------------------------");
    printContact("Penumbral Awal (P1)", resLEL.p1, resLEL.azmP1, resLEL.altP1);
    printContact("Umbra Awal (U1)", resLEL.u1, resLEL.azmU1, resLEL.altU1);
    printContact("Totalitas Mulai (U2)", resLEL.u2, resLEL.azmU2, resLEL.altU2);
    printContact("Puncak Gerhana (MX)", resLEL.mx, resLEL.azmMx, resLEL.altMx);
    printContact("Totalitas Akhir (U3)", resLEL.u3, resLEL.azmU3, resLEL.altU3);
    printContact("Umbra Akhir (U4)", resLEL.u4, resLEL.azmU4, resLEL.altU4);
    printContact("Penumbral Akhir (P4)", resLEL.p4, resLEL.azmP4, resLEL.altP4);

    // =====================================
    // INFORMASI GERHANA
    // =====================================
    print("----------------------------------------");

    print("Jenis Gerhana       : ${resLEL.jenis}");
    print("Magnitude Umbra     : ${resLEL.magnitudeUmbral ?? '-'}");
    print("Magnitude Penumbral : ${resLEL.magnitudePenumbral ?? '-'}");
    print("Durasi Umbra        : ${resLEL.durasiUmbral ?? '-'}");
    print("Durasi Total        : ${resLEL.durasiTotal ?? '-'}");
    print("Durasi Penumbral    : ${resLEL.durasiPenumbral ?? '-'}");

    // =====================================
    // DATA BULAN & MATAHARI SAAT PUNCAK
    // =====================================
    print("");
    print("========================================");
    print("DATA BULAN & MATAHARI SAAT PUNCAK");
    print("========================================");

    if (resLEL.sun != null) {
      print("MATAHARI");
      if (resLEL.sun!.ra != null) print("  RA  : ${resLEL.sun!.ra}");
      if (resLEL.sun!.dec != null) print("  DEC : ${resLEL.sun!.dec}");
      if (resLEL.sun!.sd != null) print("  SD  : ${resLEL.sun!.sd}");
      if (resLEL.sun!.hp != null) print("  HP  : ${resLEL.sun!.hp}");
      print("");
    }

    if (resLEL.moon != null) {
      print("BULAN");
      if (resLEL.moon!.ra != null) print("  RA  : ${resLEL.moon!.ra}");
      if (resLEL.moon!.dec != null) print("  DEC : ${resLEL.moon!.dec}");
      if (resLEL.moon!.sd != null) print("  SD  : ${resLEL.moon!.sd}");
      if (resLEL.moon!.hp != null) print("  HP  : ${resLEL.moon!.hp}");
    }
  }

  print("==========================================");
  print("DATA GERHANA BULAN LOKAL PER RENTANG TAHUN");
  print("==========================================");

  // GERHANA BULAN LOKAL PER RENTANG TAHUN
  final thnAwwalHijri2 = 1440;
  final thnAkhirHijri2 = 1441;
  final gLon7 = (107 + 36 / 60.0 + 22 / 3600.0);
  final gLat7 = -(6 + 55 / 60.0 + 18 / 3600.0);
  final elev7 = 10.0;
  final pres7 = 1010.0;
  final temp7 = 10.0;
  double tmZn7 = 7.0;

  final selRange2 = le.lunarEclipseLocalRangeHijri(
    tahunAwalH: thnAwwalHijri2,
    tahunAkhirH: thnAkhirHijri2,
    gLon: gLon7,
    gLat: gLat7,
    elev: elev7,
    pres: pres7,
    temp: temp7,
    tmZn: tmZn7,
    timeScale: TimeScale.jdTD,
  );

  for (final e in selRange2) {
    print("=================================");
    print("Tahun H           : ${e.tahunHijri}");
    print("Bulan H           : ${e.bulanHijri}");
    print("Jenis            : ${e.jenis}");
    print("ΔT               : ${e.deltaT?.toStringAsFixed(2) ?? '-'} s");
    print("");

    // ✅ Cek visibilitas gerhana
    List<double?> altitudes = [
      e.altP1,
      e.altU1,
      e.altU2,
      e.altMx,
      e.altU3,
      e.altU4,
      e.altP4,
    ];
    bool terlihat = altitudes.any((alt) => alt != null && alt > 0);

    if (!terlihat) {
      print("❌ Gerhana tidak terlihat di lokasi");
      print("========================================");
      continue;
    }

    // =====================================
    // KONTAK GERHANA (Format Tanggal & Waktu)
    // =====================================
    print("📅 KONTAK GERHANA");

    // Helper untuk format JD → tanggal + jam
    void printContact(String label, double? jdValue) {
      if (jdValue == null) {
        print("$label : -");
        return;
      }
      final tanggal = jd.jdkm(jdValue, tmZn7, 'THNMHYNS');
      final jamDes = jd.jdkm(jdValue, tmZn7, 'JAMDES');
      final jam = mf.dhhms(
        double.parse(jamDes),
        optResult: 'HH:MM:SS',
        secDecPlaces: 0,
      );
      print("$label :");
      print("  🗓️  $tanggal");
      print("  🕐  $jam");
    }

    printContact("P₁ (Penumbral Awal)", e.p1);
    printContact("U₁ (Umbra Awal)", e.u1);
    printContact("U₂ (Totalitas Mulai)", e.u2);
    printContact("MX (Puncak Gerhana)", e.mx);
    printContact("U₃ (Totalitas Akhir)", e.u3);
    printContact("U₄ (Umbra Akhir)", e.u4);
    printContact("P₄ (Penumbral Akhir)", e.p4);
    print("");

    // =====================================
    // ALTITUDE & AZIMUTH
    // =====================================
    print("📐 ALTITUDE & AZIMUTH");
    print(
      "P₁  Alt/Azm : ${e.altP1 != null ? '${e.altP1!.toStringAsFixed(2)}°' : '-'} / ${e.azmP1 != null ? '${e.azmP1!.toStringAsFixed(2)}°' : '-'}",
    );
    print(
      "U₁  Alt/Azm : ${e.altU1 != null ? '${e.altU1!.toStringAsFixed(2)}°' : '-'} / ${e.azmU1 != null ? '${e.azmU1!.toStringAsFixed(2)}°' : '-'}",
    );
    print(
      "U₂  Alt/Azm : ${e.altU2 != null ? '${e.altU2!.toStringAsFixed(2)}°' : '-'} / ${e.azmU2 != null ? '${e.azmU2!.toStringAsFixed(2)}°' : '-'}",
    );
    print(
      "MX  Alt/Azm : ${e.altMx != null ? '${e.altMx!.toStringAsFixed(2)}°' : '-'} / ${e.azmMx != null ? '${e.azmMx!.toStringAsFixed(2)}°' : '-'}",
    );
    print(
      "U₃  Alt/Azm : ${e.altU3 != null ? '${e.altU3!.toStringAsFixed(2)}°' : '-'} / ${e.azmU3 != null ? '${e.azmU3!.toStringAsFixed(2)}°' : '-'}",
    );
    print(
      "U₄  Alt/Azm : ${e.altU4 != null ? '${e.altU4!.toStringAsFixed(2)}°' : '-'} / ${e.azmU4 != null ? '${e.azmU4!.toStringAsFixed(2)}°' : '-'}",
    );
    print(
      "P₄  Alt/Azm : ${e.altP4 != null ? '${e.altP4!.toStringAsFixed(2)}°' : '-'} / ${e.azmP4 != null ? '${e.azmP4!.toStringAsFixed(2)}°' : '-'}",
    );
    print("");

    // =====================================
    // PARAMETER GERHANA
    // =====================================
    print("📊 PARAMETER GERHANA");
    print(
      "Magnitude Umbra     : ${e.magnitudeUmbral?.toStringAsFixed(4) ?? '-'}",
    );
    print(
      "Magnitude Penumbra  : ${e.magnitudePenumbral?.toStringAsFixed(4) ?? '-'}",
    );
    print(
      "Radius Umbra        : ${e.radiusUmbral?.toStringAsFixed(4) ?? '-'}°",
    );
    print(
      "Radius Penumbra     : ${e.radiusPenumbral?.toStringAsFixed(4) ?? '-'}°",
    );
    print(
      "Durasi Penumbra     : ${e.durasiPenumbral != null ? mf.dhhms(e.durasiPenumbral!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print(
      "Durasi Umbra        : ${e.durasiUmbral != null ? mf.dhhms(e.durasiUmbral!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print(
      "Durasi Totalitas    : ${e.durasiTotal != null ? mf.dhhms(e.durasiTotal!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print("");

    // =====================================
    // DATA BESSELIAN (Jika tersedia)
    // =====================================
    if (e.besselian != null && e.besselian!.isValid) {
      print("📐 DATA BESSELIAN");
      print("----------------------------------------");

      print("JDE     : ${e.besselian!.jde.toStringAsFixed(5)}");
      print("Delta T : ${e.besselian!.deltaT.toStringAsFixed(2)} s");
      print("T0      : ${e.besselian!.t0.toStringAsFixed(2)} jam");
      print("");

      // Helper untuk print list koefisien
      void printList(String label, List<double>? list) {
        if (list == null) return;
        for (int i = 0; i < list.length; i++) {
          final sub = i == 0
              ? '₀'
              : i == 1
              ? '₁'
              : i == 2
              ? '₂'
              : i == 3
              ? '₃'
              : '₄';
          print("  $label$sub : ${list[i].toStringAsFixed(5).padLeft(10)}");
        }
        print("");
      }

      printList("x", e.besselian!.x); // Koordinat x
      printList("y", e.besselian!.y); // Koordinat y
      printList("f₁", e.besselian!.f1); // Radius penumbra
      printList("f₂", e.besselian!.f2); // Radius umbra
      printList("δ", e.besselian!.sm); // Semi-diameter bayangan
      printList("μ", e.besselian!.mu); // Hour angle Greenwich
      printList("HP", e.besselian!.hp); // Horizontal parallax Bulan
      printList("d", e.besselian!.d); // Declination Matahari
      printList("δₘ", e.besselian!.dm); // Declination Bulan

      print("----------------------------------------");
      print("");
    }

    // =====================================
    // DATA MATAHARI SAAT PUNCAK (Format DMS/HMS)
    // =====================================
    print("🌞 DATA MATAHARI SAAT PUNCAK");
    if (e.sunData != null) {
      final raSun = e.sunData!.ra != null
          ? mf.dhhms(e.sunData!.ra! / 15, optResult: 'HHMMSS', secDecPlaces: 2)
          : '-';

      final decSun = e.sunData!.dec != null
          ? mf.dddms(e.sunData!.dec!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final sdSun = e.sunData!.sd != null
          ? mf.dddms(e.sunData!.sd!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final hpSun = e.sunData!.hp != null
          ? mf.dddms(e.sunData!.hp!, optResult: 'DDMMSS', sdp: 2)
          : '-';

      print("  RA (HMS)  : $raSun");
      print("  Dec (DMS) : $decSun");
      print("  SD (DMS)  : $sdSun");
      print("  HP (DMS)  : $hpSun");
    } else {
      print("  Data tidak tersedia");
    }
    print("");

    // =====================================
    // DATA BULAN SAAT PUNCAK (Format DMS/HMS)
    // =====================================
    print("🌙 DATA BULAN SAAT PUNCAK");
    if (e.moonData != null) {
      final raMoon = e.moonData!.ra != null
          ? mf.dhhms(e.moonData!.ra! / 15, optResult: 'HHMMSS', secDecPlaces: 2)
          : '-';

      final decMoon = e.moonData!.dec != null
          ? mf.dddms(e.moonData!.dec!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final sdMoon = e.moonData!.sd != null
          ? mf.dddms(e.moonData!.sd!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final hpMoon = e.moonData!.hp != null
          ? mf.dddms(e.moonData!.hp!, optResult: 'DDMMSS', sdp: 2)
          : '-';

      print("  RA (HMS)  : $raMoon");
      print("  Dec (DMS) : $decMoon");
      print("  SD (DMS)  : $sdMoon");
      print("  HP (DMS)  : $hpMoon");
    } else {
      print("  Data tidak tersedia");
    }

    print("========================================");
  }

  // INPUT GERHANA BULAN GLOBAL
  final int blnH5 = 9;
  final int thnH5 = 1447;

  // ========================================
  // DATA GERHANA BULAN GLOBAL
  // ========================================

  final resLEG = le.lunarEclipseGlobal(blnH: blnH5, thnH: thnH5);

  print("========================================");
  print("     DATA GERHANA BULAN GLOBAL");
  print("========================================");
  print("");

  // ================= PRINT BESSELIAN =================
  final bessel2 = resLEG?.besselian;

  if (bessel2 != null && bessel2.isValid) {
    print("========================================");
    print("           DATA BESSELIAN");
    print("========================================");

    // ✅ Hapus '?.' karena jde, deltaT, t0 adalah non-nullable (double)
    print("JDE     : ${bessel2.jde.toStringAsFixed(5)}");
    print("Delta T : ${bessel2.deltaT.toStringAsFixed(2)} s");
    print("T0      : ${bessel2.t0.toStringAsFixed(2)} jam");
    print("");

    // ✅ Helper function untuk print list
    void printList(String label, List<double>? list) {
      if (list == null) return;
      for (int i = 0; i < list.length; i++) {
        print("  $label$i : ${list[i].toStringAsFixed(5).padLeft(10)}");
      }
      print("");
    }

    // ✅ Print semua koefisien Besselian
    printList("x", bessel2.x);
    printList("y", bessel2.y);
    printList("f₁", bessel2.f1);
    printList("f₂", bessel2.f2);
    printList("δ", bessel2.sm); // sm = semi-diameter bayangan
    printList("μ", bessel2.mu); // mu = hour angle
    printList("HP", bessel2.hp); // hp = horizontal parallax
    printList("d", bessel2.d); // d = declination
    printList("δₘ", bessel2.dm); // dm = declination moon
  }

  if (resLEG == null || !resLEG.isValid) {
    print("❌ Tidak ada gerhana pada bulan/tahun ini.");
  } else {
    // =====================================
    // KONTAK GERHANA (Format JD + Waktu)
    // =====================================
    print("📅 KONTAK GERHANA");
    print("----------------------------------------");

    void printContact(String label, double? jdValue) {
      // ✅ Ganti nama parameter
      if (jdValue == null) {
        print("$label : -");
        return;
      }

      // Format: JD + Tanggal + Jam
      final tanggal = jd.jdkm(jdValue, 7.0, 'THNMHYNS');
      final jamDes = jd.jdkm(jdValue, 7.0, 'JAMDES');
      final jam = mf.dhhms(
        double.parse(jamDes),
        optResult: 'HH:MM:SS',
        secDecPlaces: 0,
      );

      print("$label :");
      //print("  JD  : ${jdValue.toStringAsFixed(5)}");
      print("  🗓️  $tanggal");
      print("  🕐  $jam");
      print("");
    }

    printContact("P₁ (Penumbral Awal)", resLEG.p1);
    printContact("U₁ (Umbra Awal)", resLEG.u1);
    printContact("U₂ (Totalitas Mulai)", resLEG.u2);
    printContact("MX (Puncak Gerhana)", resLEG.mx);
    printContact("U₃ (Totalitas Akhir)", resLEG.u3);
    printContact("U₄ (Umbra Akhir)", resLEG.u4);
    printContact("P₄ (Penumbral Akhir)", resLEG.p4);

    // =====================================
    // INFORMASI GERHANA (Parameter)
    // =====================================
    print("----------------------------------------");
    print("📊 PARAMETER GERHANA");
    print("Jenis Gerhana       : ${resLEG.jenis}");

    // Magnitude (4 desimal)
    print(
      "Magnitude Umbra     : ${resLEG.magnitudeUmbral?.toStringAsFixed(4) ?? '-'}",
    );
    print(
      "Magnitude Penumbra  : ${resLEG.magnitudePenumbral?.toStringAsFixed(4) ?? '-'}",
    );

    // Radius (4 desimal + °)
    print(
      "Radius Umbra        : ${resLEG.radiusUmbral?.toStringAsFixed(4) ?? '-'}°",
    );
    print(
      "Radius Penumbra     : ${resLEG.radiusPenumbral?.toStringAsFixed(4) ?? '-'}°",
    );

    // ✅ Durasi dalam format HH:MM:SS
    print(
      "Durasi Penumbra     : ${resLEG.durasiPenumbral != null ? mf.dhhms(resLEG.durasiPenumbral!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print(
      "Durasi Umbra        : ${resLEG.durasiUmbral != null ? mf.dhhms(resLEG.durasiUmbral!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print(
      "Durasi Totalitas    : ${resLEG.durasiTotal != null ? mf.dhhms(resLEG.durasiTotal!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print("");

    // =====================================
    // DATA MATAHARI & BULAN SAAT PUNCAK (Format DMS/HMS)
    // =====================================
    print("========================================");
    print("🌞🌙 DATA EPHEMERIS SAAT PUNCAK");
    print("========================================");

    // 🌞 Matahari
    print("MATAHARI");
    if (resLEG.sun != null) {
      // RA dalam jam → HMS
      final raSun = resLEG.sun!.ra != null
          ? mf.dhhms(resLEG.sun!.ra! / 15, optResult: 'HHMMSS', secDecPlaces: 2)
          : '-';
      // Dec/SD/HP dalam derajat → DMS
      final decSun = resLEG.sun!.dec != null
          ? mf.dddms(resLEG.sun!.dec!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final sdSun = resLEG.sun!.sd != null
          ? mf.dddms(resLEG.sun!.sd!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final hpSun = resLEG.sun!.hp != null
          ? mf.dddms(resLEG.sun!.hp!, optResult: 'DDMMSS', sdp: 2)
          : '-';

      print("  RA (HMS)  : $raSun");
      print("  Dec (DMS) : $decSun");
      print("  SD (DMS)  : $sdSun");
      print("  HP (DMS)  : $hpSun");
    } else {
      print("  Data tidak tersedia");
    }
    print("");

    // 🌙 Bulan
    print("BULAN");
    if (resLEG.moon != null) {
      // RA dalam jam → HMS
      final raMoon = resLEG.moon!.ra != null
          ? mf.dhhms(
              resLEG.moon!.ra! / 15,
              optResult: 'HHMMSS',
              secDecPlaces: 2,
            )
          : '-';
      // Dec/SD/HP dalam derajat → DMS
      final decMoon = resLEG.moon!.dec != null
          ? mf.dddms(resLEG.moon!.dec!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final sdMoon = resLEG.moon!.sd != null
          ? mf.dddms(resLEG.moon!.sd!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final hpMoon = resLEG.moon!.hp != null
          ? mf.dddms(resLEG.moon!.hp!, optResult: 'DDMMSS', sdp: 2)
          : '-';

      print("  RA (HMS)  : $raMoon");
      print("  Dec (DMS) : $decMoon");
      print("  SD (DMS)  : $sdMoon");
      print("  HP (DMS)  : $hpMoon");
    } else {
      print("  Data tidak tersedia");
    }
  }

  print("========================================");

  print("");
  print("==============================================");
  print("DATA GERHANA BULAN GLOBAL PER RENTANG TAHUN");
  print("==============================================");

  // GERHANA BULAN GLOBAL PER RENTANG TAHUN
  final thnAwwalHijri3 = 1440;
  final thnAkhirHijri3 = 1441;

  final segRange2 = le.lunarEclipseGlobalRangeHijri(
    tahunAwalH: thnAwwalHijri3,
    tahunAkhirH: thnAkhirHijri3,
  );

  for (final e in segRange2) {
    print("=================================");
    print("Tahun H          : ${e.tahunHijri}");
    print("Bulan H          : ${e.bulanHijri}");
    print("Jenis            : ${e.jenis}");
    print("");

    // =====================================
    // KONTAK GERHANA (Format Tanggal & Waktu)
    // =====================================
    print("📅 KONTAK GERHANA");

    // Helper function untuk format JD menjadi tanggal + waktu
    void printContact(String label, double? jdValue) {
      if (jdValue == null) {
        print("$label : -");
        return;
      }

      final tanggal = jd.jdkm(jdValue, 0.0, 'THNMHYNS');

      final jamDes = jd.jdkm(jdValue, 0.0, 'JAMDES');
      final jam = mf.dhhms(
        double.parse(jamDes),
        optResult: 'HH:MM:SS',
        secDecPlaces: 0,
      );

      print("$label :");
      print("  🗓️  $tanggal");
      print("  🕐  $jam");
    }

    printContact("P1 (Penumbral Awal)", e.p1);
    printContact("U1 (Umbra Awal)", e.u1);
    printContact("U2 (Totalitas Mulai)", e.u2);
    printContact("MX (Puncak Gerhana)", e.mx);
    printContact("U3 (Totalitas Akhir)", e.u3);
    printContact("U4 (Umbra Akhir)", e.u4);
    printContact("P4 (Penumbral Akhir)", e.p4);
    print("");

    // =====================================
    // DURASI (Format HH:MM:SS)
    // =====================================
    print("⏱️  DURASI");
    print(
      "Durasi Penumbra  : ${e.durasiPenumbral != null ? mf.dhhms(e.durasiPenumbral!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print(
      "Durasi Umbra     : ${e.durasiUmbral != null ? mf.dhhms(e.durasiUmbral!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print(
      "Durasi Totalitas : ${e.durasiTotal != null ? mf.dhhms(e.durasiTotal!, optResult: 'HH:MM:SS', secDecPlaces: 0) : '-'}",
    );
    print("");

    // =====================================
    // DATA BESSELIAN (Jika tersedia)
    // =====================================
    if (e.besselian != null && e.besselian!.isValid) {
      print("📐 DATA BESSELIAN");
      print("----------------------------------------");

      // Header: JDE, Delta T, T0
      print("JDE     : ${e.besselian!.jde.toStringAsFixed(5)}");
      print("Delta T : ${e.besselian!.deltaT.toStringAsFixed(2)} s");
      print("T0      : ${e.besselian!.t0.toStringAsFixed(2)} jam");
      print("");

      // ✅ Helper function untuk print list koefisien
      void printList(String label, List<double>? list) {
        if (list == null) return;
        for (int i = 0; i < list.length; i++) {
          // Format: label₀ :    0.02000 (rata kanan 10 karakter)
          print(
            "  $label${i == 0
                ? '₀'
                : i == 1
                ? '₁'
                : i == 2
                ? '₂'
                : i == 3
                ? '₃'
                : '₄'} : ${list[i].toStringAsFixed(5).padLeft(10)}",
          );
        }
        print("");
      }

      // ✅ Print semua koefisien Besselian
      printList("x", e.besselian!.x); // Koordinat x bayangan
      printList("y", e.besselian!.y); // Koordinat y bayangan
      printList("f₁", e.besselian!.f1); // Radius penumbra
      printList("f₂", e.besselian!.f2); // Radius umbra
      printList("δ", e.besselian!.sm); // Semi-diameter bayangan
      printList("μ", e.besselian!.mu); // Hour angle Greenwich
      printList("HP", e.besselian!.hp); // Horizontal parallax Bulan
      printList("d", e.besselian!.d); // Declination Matahari
      printList("δₘ", e.besselian!.dm); // Declination Bulan

      print("----------------------------------------");
    }

    // =====================================
    // DATA MATAHARI & BULAN SAAT PUNCAK
    // =====================================
    print("🌞🌙 DATA EPHEMERIS SAAT PUNCAK");

    // Matahari
    print("MATAHARI");
    if (e.sun != null) {
      final raSun = e.sun!.ra != null
          ? mf.dhhms(e.sun!.ra! / 15, optResult: 'HH:MM:SS', secDecPlaces: 2)
          : '-';
      final decSun = e.sun!.dec != null
          ? mf.dddms(e.sun!.dec!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final sdSun = e.sun!.sd != null
          ? mf.dddms(e.sun!.sd!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final hpSun = e.sun!.hp != null
          ? mf.dddms(e.sun!.hp!, optResult: 'DDMMSS', sdp: 2)
          : '-';

      print("  RA (HMS)  : $raSun");
      print("  Dec (DMS) : $decSun");
      print("  SD (DMS)  : $sdSun");
      print("  HP (DMS)  : $hpSun");
    } else {
      print("  Data tidak tersedia");
    }

    print("");

    // Bulan
    print("BULAN");
    if (e.moon != null) {
      final raMoon = e.moon!.ra != null
          ? mf.dhhms(e.moon!.ra! / 15, optResult: 'HH:MM:SS', secDecPlaces: 2)
          : '-';
      final decMoon = e.moon!.dec != null
          ? mf.dddms(e.moon!.dec!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final sdMoon = e.moon!.sd != null
          ? mf.dddms(e.moon!.sd!, optResult: 'DDMMSS', sdp: 2)
          : '-';
      final hpMoon = e.moon!.hp != null
          ? mf.dddms(e.moon!.hp!, optResult: 'DDMMSS', sdp: 2)
          : '-';

      print("  RA (HMS)  : $raMoon");
      print("  Dec (DMS) : $decMoon");
      print("  SD (DMS)  : $sdMoon");
      print("  HP (DMS)  : $hpMoon");
    } else {
      print("  Data tidak tersedia");
    }

    print("========================================");
  }

  print("");

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
        print("  $label$i : ${list[i].toStringAsFixed(5).padRight(12)}");
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

    print("KONTAK GERHANA");
    print("---------------------------------");

    // U1
    print("U1 (Kontak Awal Umbra)");
    print("   JD  : ${resSEL.u1 ?? '-'}");
    print("   Azm : ${resSEL.azmU1 ?? '-'}");
    print("   Alt : ${resSEL.altU1 ?? '-'}");
    print("");

    // U2
    print("U2 (Totalitas Mulai)");
    print("   JD  : ${resSEL.u2 ?? '-'}");
    print("   Azm : ${resSEL.azmU2 ?? '-'}");
    print("   Alt : ${resSEL.altU2 ?? '-'}");
    print("");

    // MX
    print("MX (Puncak Gerhana)");
    print("   JD  : ${resSEL.mx ?? '-'}");
    print("   Azm : ${resSEL.azmMx ?? '-'}");
    print("   Alt : ${resSEL.altMx ?? '-'}");
    print("");

    // U3
    print("U3 (Totalitas Akhir)");
    print("   JD  : ${resSEL.u3 ?? '-'}");
    print("   Azm : ${resSEL.azmU3 ?? '-'}");
    print("   Alt : ${resSEL.altU3 ?? '-'}");
    print("");

    // U4
    print("U4 (Kontak Akhir Umbra)");
    print("   JD  : ${resSEL.u4 ?? '-'}");
    print("   Azm : ${resSEL.azmU4 ?? '-'}");
    print("   Alt : ${resSEL.altU4 ?? '-'}");
    print("");
  }

  print("========================================");
  print("     DATA GERHANA MATAHARI GLOBAL");
  print("========================================");
  print("");

  // INPUT GERHANA MATAHARI GLOBAL
  final blnH4 = 5;
  final thnH4 = 1437;

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
        print("  $label$i : ${list[i].toStringAsFixed(5).padRight(10)}");
      }
    }

    // tampilkan jde, deltaT, t0
    print("JDE     : ${bs?.jde ?? '-'}");
    print("Delta T : ${bs?.deltaT ?? '-'}");
    print("T0      : ${bs?.t0 ?? '-'}");
    print("");

    printList2("x", bs?.x);
    print("");
    printList2("y", bs?.y);
    print("");
    printList2("d", bs?.d);
    print("");
    printList2("mu", bs?.mu);
    print("");
    printList2("l1", bs?.l1);
    print("");
    printList2("l2", bs?.l2);
    print("");

    print("tanf1 : ${bs?.tanf1 ?? '-'}");
    print("tanf2 : ${bs?.tanf2 ?? '-'}");
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
    if (resSEG.durasiTotalitas != null) {
      print("Durasi Totalitas : ${resSEG.durasiTotalitas}");
    }
    print("");

    // ✅ HELPER BARU: Print kontak dengan struktur flat
    void printContactFlat(
      String label, {
      double? td,
      double? ut,
      double? lon,
      double? lat,
      double? azm,
      double? alt,
    }) {
      // Skip jika semua null
      if (td == null &&
          ut == null &&
          lon == null &&
          lat == null &&
          azm == null &&
          alt == null) {
        return;
      }

      print(label);
      if (td != null) print("  JDTD : $td");
      if (ut != null) print("  JDUT : $ut");
      if (lon != null) print("  lon  : $lon");
      if (lat != null) print("  lat  : $lat");
      if (azm != null) print("  Azm  : $azm");
      if (alt != null) print("  Alt  : $alt");
      print("");
    }

    print("KONTAK GERHANA");
    print("----------------------------------------");

    printContactFlat(
      "P1 (Penumbral First External)",
      td: resSEG.p1,
      ut: resSEG.p1UT,
      lon: resSEG.lonP1,
      lat: resSEG.latP1,
      azm: resSEG.azmP1,
      alt: resSEG.altP1,
    );
    printContactFlat(
      "U1 (Umbral First External)",
      td: resSEG.u1,
      ut: resSEG.u1UT,
      lon: resSEG.lonU1,
      lat: resSEG.latU1,
      azm: resSEG.azmU1,
      alt: resSEG.altU1,
    );
    printContactFlat(
      "C1 (Central First)",
      td: resSEG.c1,
      ut: resSEG.c1UT,
      lon: resSEG.lonC1,
      lat: resSEG.latC1,
      azm: resSEG.azmC1,
      alt: resSEG.altC1,
    );
    printContactFlat(
      "U2 (Umbral First Internal)",
      td: resSEG.u2,
      ut: resSEG.u2UT,
      lon: resSEG.lonU2,
      lat: resSEG.latU2,
      azm: resSEG.azmU2,
      alt: resSEG.altU2,
    );
    printContactFlat(
      "P2 (Penumbral First Internal)",
      td: resSEG.p2,
      ut: resSEG.p2UT,
      lon: resSEG.lonP2,
      lat: resSEG.latP2,
      azm: resSEG.azmP2,
      alt: resSEG.altP2,
    );
    printContactFlat(
      "MX (Puncak Gerhana)",
      td: resSEG.mx,
      ut: resSEG.mxUT,
      lon: resSEG.lonMx,
      lat: resSEG.latMx,
      azm: resSEG.azmMx,
      alt: resSEG.altMx,
    );
    printContactFlat(
      "P3 (Penumbral Last Internal)",
      td: resSEG.p3,
      ut: resSEG.p3UT,
      lon: resSEG.lonP3,
      lat: resSEG.latP3,
      azm: resSEG.azmP3,
      alt: resSEG.altP3,
    );
    printContactFlat(
      "U3 (Umbral Last Internal)",
      td: resSEG.u3,
      ut: resSEG.u3UT,
      lon: resSEG.lonU3,
      lat: resSEG.latU3,
      azm: resSEG.azmU3,
      alt: resSEG.altU3,
    );
    printContactFlat(
      "C2 (Central Last)",
      td: resSEG.c2,
      ut: resSEG.c2UT,
      lon: resSEG.lonC2,
      lat: resSEG.latC2,
      azm: resSEG.azmC2,
      alt: resSEG.altC2,
    );
    printContactFlat(
      "U4 (Umbral Last External)",
      td: resSEG.u4,
      ut: resSEG.u4UT,
      lon: resSEG.lonU4,
      lat: resSEG.latU4,
      azm: resSEG.azmU4,
      alt: resSEG.altU4,
    );
    printContactFlat(
      "P4 (Penumbral Last External)",
      td: resSEG.p4,
      ut: resSEG.p4UT,
      lon: resSEG.lonP4,
      lat: resSEG.latP4,
      azm: resSEG.azmP4,
      alt: resSEG.altP4,
    );

    print("========================================");
    print("DATA MATAHARI & BULAN SAAT PUNCAK");
    print("========================================");

    // ✅ Ephemeris diakses langsung (sudah dipisah)
    print("MATAHARI");
    print("  RA  : ${resSEG.sunEphemeris?.ra ?? '-'}");
    print("  DEC : ${resSEG.sunEphemeris?.dec ?? '-'}");
    print("  SD  : ${resSEG.sunEphemeris?.sd ?? '-'}");
    print("  HP  : ${resSEG.sunEphemeris?.hp ?? '-'}");
    print("");

    print("BULAN");
    print("  RA  : ${resSEG.moonEphemeris?.ra ?? '-'}");
    print("  DEC : ${resSEG.moonEphemeris?.dec ?? '-'}");
    print("  SD  : ${resSEG.moonEphemeris?.sd ?? '-'}");
    print("  HP  : ${resSEG.moonEphemeris?.hp ?? '-'}");
  }

  print("");

  print("=============================================");
  print("DATA GERHANA MATAHARI LOKAL PER RENTANG TAHUN");
  print("=============================================");

  final thnAwwalHijri = 1437;
  final thnAkhirHijri = 1438;
  final gLon6 = (108 + 17 / 60.0 + 50 / 3600.0);
  final gLat6 = -(2 + 51 / 60.0 + 25 / 3600.0);
  final elev6 = 2.0;
  final pres6 = 1010.0;
  final temp6 = 10.0;
  double tmZn6 = 7.0;

  for (int thn = thnAwwalHijri; thn <= thnAkhirHijri; thn++) {
    for (int bln = 1; bln <= 12; bln++) {
      final e = se.solarEclipseLocal(
        blnH: bln,
        thnH: thn,
        gLon: gLon6,
        gLat: gLat6,
        elev: elev6,
        pres: pres6,
        temp: temp6,
        tmZn: tmZn6,
      );

      if (e == null || e.ada != true) continue;

      print("=================================");
      print("Tahun H          : $thn");
      print("Bulan H          : $bln");

      // Cek visibility: minimal satu altitude > 0
      bool terlihat = [
        e.altU1,
        e.altU2,
        e.altMx,
        e.altU3,
        e.altU4,
      ].any((alt) => alt != null && alt > 0);

      if (!terlihat) {
        print("Gerhana tidak terlihat di lokasi");
        print("");
        continue;
      }

      print("Jenis            : ${e.jenis}");

      // Hitung deltaT dalam hari untuk konversi TD -> UT
      final deltaT = e.deltaT ?? 0;
      final deltaTDays = deltaT / 86400.0;

      // ─── WAKTU DALAM TD ──────────────────────────
      print("\n--- WAKTU DALAM TD ---");
      print("U1 : ${e.u1 ?? '-'}");
      print("U2 : ${e.u2 ?? '-'}");
      print("MX : ${e.mx ?? '-'}");
      print("U3 : ${e.u3 ?? '-'}");
      print("U4 : ${e.u4 ?? '-'}");

      // ─── WAKTU DALAM UT ─────────────────────────
      print("\n--- WAKTU DALAM UT ---");
      print("U1 : ${e.u1 != null ? e.u1! - deltaTDays : '-'}");
      print("U2 : ${e.u2 != null ? e.u2! - deltaTDays : '-'}");
      print("MX : ${e.mx != null ? e.mx! - deltaTDays : '-'}");
      print("U3 : ${e.u3 != null ? e.u3! - deltaTDays : '-'}");
      print("U4 : ${e.u4 != null ? e.u4! - deltaTDays : '-'}");

      // ─── ALTITUDE ────────────────────────────────
      print("\n--- ALTITUDE ---");
      print("U1 : ${e.altU1 ?? '-'}");
      print("U2 : ${e.altU2 ?? '-'}");
      print("MX : ${e.altMx ?? '-'}");
      print("U3 : ${e.altU3 ?? '-'}");
      print("U4 : ${e.altU4 ?? '-'}");

      // ─── AZIMUTH ─────────────────────────────────
      print("\n--- AZIMUTH ---");
      print("U1 : ${e.azmU1 ?? '-'}");
      print("U2 : ${e.azmU2 ?? '-'}");
      print("MX : ${e.azmMx ?? '-'}");
      print("U3 : ${e.azmU3 ?? '-'}");
      print("U4 : ${e.azmU4 ?? '-'}");

      // ── PARAMETER GERHANA ──────────────────────
      print("\n--- PARAMETER GERHANA ---");
      print("Magnitude        : ${e.magnitude ?? '-'}");
      print("Obscuration      : ${e.obscuration ?? '-'}");
      print("Durasi Total     : ${e.durasiTotalitas ?? '-'}");
      print("Durasi Gerhana   : ${e.durasiGerhana ?? '-'}");

      // ─── EPHEMERIS PUNCAK ───────────────────────
      print("\n--- EPHEMERIS MATAHARI ---");
      print("RA  : ${e.ephemerisMaximum?.sun?.ra ?? '-'}");
      print("Dec : ${e.ephemerisMaximum?.sun?.dec ?? '-'}");
      print("SD  : ${e.ephemerisMaximum?.sun?.sd ?? '-'}");
      print("HP  : ${e.ephemerisMaximum?.sun?.hp ?? '-'}");

      print("\n--- EPHEMERIS BULAN ---");
      print("RA  : ${e.ephemerisMaximum?.moon?.ra ?? '-'}");
      print("Dec : ${e.ephemerisMaximum?.moon?.dec ?? '-'}");
      print("SD  : ${e.ephemerisMaximum?.moon?.sd ?? '-'}");
      print("HP  : ${e.ephemerisMaximum?.moon?.hp ?? '-'}");

      // ─── BESSELIAN ELEMENTS ──────────
      print("\n--- BESSELIAN ELEMENTS ---");
      final b = e.besselian;
      print("JDE     : ${b.jde ?? '-'}");
      print("DeltaT  : ${b.deltaT ?? '-'}");
      print("t0      : ${b.t0 ?? '-'}");
      print("isValid : ${b.isValid}");

      if (b.x != null) {
        print("x:");
        for (int i = 0; i < b.x!.length; i++) {
          print("   [$i] = ${b.x![i]}");
        }
      }
      if (b.y != null) {
        print("y:");
        for (int i = 0; i < b.y!.length; i++) {
          print("   [$i] = ${b.y![i]}");
        }
      }
      if (b.d != null) {
        print("d:");
        for (int i = 0; i < b.d!.length; i++) {
          print("   [$i] = ${b.d![i]}");
        }
      }
      if (b.mu != null) {
        print("mu:");
        for (int i = 0; i < b.mu!.length; i++) {
          print("   [$i] = ${b.mu![i]}");
        }
      }
      if (b.l1 != null) {
        print("l1:");
        for (int i = 0; i < b.l1!.length; i++) {
          print("   [$i] = ${b.l1![i]}");
        }
      }
      if (b.l2 != null) {
        print("l2:");
        for (int i = 0; i < b.l2!.length; i++) {
          print("   [$i] = ${b.l2![i]}");
        }
      }
      print("tanf1: ${b.tanf1 ?? '-'}");
      print("tanf2: ${b.tanf2 ?? '-'}");

      print(""); // Spasi antar gerhana
    }
  }

  print("==============================================");
  print("SELESAI");
  print("==============================================");

  print("");

  print("==============================================");
  print("DATA GERHANA MATAHARI GLOBAL PER RENTANG TAHUN");
  print("==============================================");

  final thnAwwalHijri4 = 1437;
  final thnAkhirHijri4 = 1438;

  for (int thn = thnAwwalHijri4; thn <= thnAkhirHijri4; thn++) {
    for (int bln = 1; bln <= 12; bln++) {
      final e = se.solarEclipseGlobal(blnH: bln, thnH: thn);
      if (e == null || e.ada != true) continue;

      print("=================================");
      print("Tahun H  : $thn");
      print("Bulan H  : $bln");
      print("Jenis    : ${e.jenis}");

      // ─── WAKTU DALAM TD ──────────────────────────
      print("\n--- WAKTU DALAM TD ---");
      print("P1 : ${e.p1 ?? '-'}");
      print("U1 : ${e.u1 ?? '-'}");
      print("C1 : ${e.c1 ?? '-'}");
      print("U2 : ${e.u2 ?? '-'}");
      print("P2 : ${e.p2 ?? '-'}");
      print("MX : ${e.mx ?? '-'}");
      print("P3 : ${e.p3 ?? '-'}");
      print("U3 : ${e.u3 ?? '-'}");
      print("C2 : ${e.c2 ?? '-'}");
      print("U4 : ${e.u4 ?? '-'}");
      print("P4 : ${e.p4 ?? '-'}");

      // ─── WAKTU DALAM UT ─────────────────────────
      print("\n--- WAKTU DALAM UT ---");
      print("P1 : ${e.p1UT ?? '-'}");
      print("U1 : ${e.u1UT ?? '-'}");
      print("C1 : ${e.c1UT ?? '-'}");
      print("U2 : ${e.u2UT ?? '-'}");
      print("P2 : ${e.p2UT ?? '-'}");
      print("MX : ${e.mxUT ?? '-'}");
      print("P3 : ${e.p3UT ?? '-'}");
      print("U3 : ${e.u3UT ?? '-'}");
      print("C2 : ${e.c2UT ?? '-'}");
      print("U4 : ${e.u4UT ?? '-'}");
      print("P4 : ${e.p4UT ?? '-'}");

      // ─── LONGITUDE & LATITUDE ──────────────────
      print("\n--- LONGITUDE & LATITUDE ---");
      print("P1 : Lon ${e.lonP1 ?? '-'}, Lat ${e.latP1 ?? '-'}");
      print("U1 : Lon ${e.lonU1 ?? '-'}, Lat ${e.latU1 ?? '-'}");
      print("C1 : Lon ${e.lonC1 ?? '-'}, Lat ${e.latC1 ?? '-'}");
      print("U2 : Lon ${e.lonU2 ?? '-'}, Lat ${e.latU2 ?? '-'}");
      print("P2 : Lon ${e.lonP2 ?? '-'}, Lat ${e.latP2 ?? '-'}");
      print("MX : Lon ${e.lonMx ?? '-'}, Lat ${e.latMx ?? '-'}");
      print("P3 : Lon ${e.lonP3 ?? '-'}, Lat ${e.latP3 ?? '-'}");
      print("U3 : Lon ${e.lonU3 ?? '-'}, Lat ${e.latU3 ?? '-'}");
      print("C2 : Lon ${e.lonC2 ?? '-'}, Lat ${e.latC2 ?? '-'}");
      print("U4 : Lon ${e.lonU4 ?? '-'}, Lat ${e.latU4 ?? '-'}");
      print("P4 : Lon ${e.lonP4 ?? '-'}, Lat ${e.latP4 ?? '-'}");

      // ─── AZIMUTH & ALTITUDE ────────────────────
      print("\n--- AZIMUTH & ALTITUDE ---");
      print("P1 : Azm ${e.azmP1 ?? '-'}, Alt ${e.altP1 ?? '-'}");
      print("U1 : Azm ${e.azmU1 ?? '-'}, Alt ${e.altU1 ?? '-'}");
      print("C1 : Azm ${e.azmC1 ?? '-'}, Alt ${e.altC1 ?? '-'}");
      print("U2 : Azm ${e.azmU2 ?? '-'}, Alt ${e.altU2 ?? '-'}");
      print("P2 : Azm ${e.azmP2 ?? '-'}, Alt ${e.altP2 ?? '-'}");
      print("MX : Azm ${e.azmMx ?? '-'}, Alt ${e.altMx ?? '-'}");
      print("P3 : Azm ${e.azmP3 ?? '-'}, Alt ${e.altP3 ?? '-'}");
      print("U3 : Azm ${e.azmU3 ?? '-'}, Alt ${e.altU3 ?? '-'}");
      print("C2 : Azm ${e.azmC2 ?? '-'}, Alt ${e.altC2 ?? '-'}");
      print("U4 : Azm ${e.azmU4 ?? '-'}, Alt ${e.altU4 ?? '-'}");
      print("P4 : Azm ${e.azmP4 ?? '-'}, Alt ${e.altP4 ?? '-'}");

      // ─── PARAMETER GERHANA ─────────────────────
      print("\n--- PARAMETER ---");
      print("Magnitude        : ${e.magnitude ?? '-'}");
      print("Durasi Totalitas : ${e.durasiTotalitas ?? '-'}");
      print("Lebar Jalur      : ${e.lebar ?? '-'}");

      // ─── EPHEMERIS MATAHARI ────────────────────
      print("\n--- EPHEMERIS MATAHARI ---");
      print("RA  : ${e.sunEphemeris?.ra ?? '-'}");
      print("Dec : ${e.sunEphemeris?.dec ?? '-'}");
      print("SD  : ${e.sunEphemeris?.sd ?? '-'}");
      print("HP  : ${e.sunEphemeris?.hp ?? '-'}");

      // ─── EPHEMERIS BULAN ───────────────────────
      print("\n--- EPHEMERIS BULAN ---");
      print("RA  : ${e.moonEphemeris?.ra ?? '-'}");
      print("Dec : ${e.moonEphemeris?.dec ?? '-'}");
      print("SD  : ${e.moonEphemeris?.sd ?? '-'}");
      print("HP  : ${e.moonEphemeris?.hp ?? '-'}");

      // ─── BESSELIAN ELEMENTS ────────────────────
      print("\n--- BESSELIAN ELEMENTS ---");
      final b = e.besselian;
      if (b != null) {
        print("JDE     : ${b.jde ?? '-'}");
        print("DeltaT  : ${b.deltaT ?? '-'}");
        print("t0      : ${b.t0 ?? '-'}");
        print("isValid : ${b.isValid}");

        // Print array vertikal
        if (b.x != null) {
          print("x:");
          for (int i = 0; i < b.x!.length; i++) {
            print("   [$i] = ${b.x![i]}");
          }
        }
        if (b.y != null) {
          print("y:");
          for (int i = 0; i < b.y!.length; i++) {
            print("   [$i] = ${b.y![i]}");
          }
        }
        if (b.d != null) {
          print("d:");
          for (int i = 0; i < b.d!.length; i++) {
            print("   [$i] = ${b.d![i]}");
          }
        }
        if (b.mu != null) {
          print("mu:");
          for (int i = 0; i < b.mu!.length; i++) {
            print("   [$i] = ${b.mu![i]}");
          }
        }
        if (b.l1 != null) {
          print("l1:");
          for (int i = 0; i < b.l1!.length; i++) {
            print("   [$i] = ${b.l1![i]}");
          }
        }
        if (b.l2 != null) {
          print("l2:");
          for (int i = 0; i < b.l2!.length; i++) {
            print("   [$i] = ${b.l2![i]}");
          }
        }
        print("tanf1: ${b.tanf1 ?? '-'}");
        print("tanf2: ${b.tanf2 ?? '-'}");
      } else {
        print("Besselian: tidak tersedia");
      }

      print(""); // Spasi antar gerhana
    }
  }

  print("==============================================");
  print("SELESAI");
  print("==============================================");
}
