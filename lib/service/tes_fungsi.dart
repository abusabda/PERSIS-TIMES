import 'package:myhisab/core/dynamical_time.dart';
import 'package:myhisab/core/julian_day.dart';
import 'package:myhisab/core/math_utils.dart';
import 'package:myhisab/core/moon_function.dart';
import 'package:myhisab/core/sun_function.dart';
//import 'package:myhisab/core/math_utils.dart';
import 'package:myhisab/service/calendar_service.dart';
import 'package:myhisab/service/lunar_eclipse_service.dart';
import 'package:myhisab/service/qibla_service.dart';
import 'package:myhisab/service/salat_service.dart';
import 'package:myhisab/service/solar_eclipse_service.dart';

void main() {
  final ss = SalatService();
  final qs = QiblaService();
  final cs = CalendarService();
  final le = LunarEclipseService();
  final se = SolarEclipseService();
  final jd = JulianDay();
  final mf = MathFunction();
  final mo = MoonFunction();
  final sn = SunFunction();
  final dt = DynamicalTime();

  // ================= INPUT =================
  int tglM4 = 1;
  int blnM4 = 4;
  int thnM4 = 2025;
  double jamDes = 0.0;
  double timeZone = 0.0;
  int sdp = 0;

  // ================= PROSES =================
  double jdVal = jd.kmjd(tglM4, blnM4, thnM4, jamDes, timeZone);
  double deltaT = 0.0;

  print("====================================================");
  print("DATA MATAHARI");
  print("====================================================");

  print("Julian Day                 : ${mf.roundTo(jdVal, place: 4)}");
  print(
    "Delta T                    : ${mf.roundTo(dt.deltaT(jdVal), place: 2)}",
  );
  print(
    "Apparent Longitude         : ${mf.dddms(sn.sunGeocentricLongitude(jdVal, deltaT, "Appa"), optResult: "DDDMMSS", sdp: sdp)}",
  );
  print(
    "Apparent Latitude          : ${mf.dddms(sn.sunGeocentricLatitude(jdVal, deltaT), optResult: "SS", sdp: 2)}",
  );
  print(
    "Apparent Right Ascension   : ${mf.dddms(sn.sunGeocentricRightAscension(jdVal, deltaT), optResult: "", sdp: sdp)}",
  );
  print(
    "Apparent Declination       : ${mf.dddms(sn.sunGeocentricDeclination(jdVal, deltaT), optResult: "", sdp: sdp)}",
  );
  print(
    "Horizontal Parallax        : ${mf.dddms(sn.sunEquatorialHorizontalParallax(jdVal, deltaT), optResult: "SS", sdp: 2)}",
  );
  print(
    "Semidiameter               : ${mf.dddms(sn.sunGeocentricSemidiameter(jdVal, deltaT), optResult: "MMSS", sdp: 2)}",
  );
  print(
    "Equation of Time           : ${mf.dhhms(sn.equationOfTime(jdVal, deltaT), optResult: "MMSS", secDecPlaces: sdp, posNegSign: "+-")}",
  );
  print(
    "Distance                   : ${mf.roundTo(sn.sunGeocentricDistance(jdVal, deltaT, "AU"), place: 8)}",
  );
  print(
    "GHA                        : ${mf.dddms(sn.sunGeocentricGreenwichHourAngle(jdVal, deltaT), optResult: "", sdp: sdp)}",
  );

  print(" ");
  print("====================================================");
  print("DATA BULAN");
  print("====================================================");

  print("Julian Day                 : ${mf.roundTo(jdVal, place: 4)}");
  print(
    "Delta T                    : ${mf.roundTo(dt.deltaT(jdVal), place: 2)}",
  );
  print(
    "Apparent Longitude         : ${mf.dddms(ml.moonGeocentricLongitude(jdVal, deltaT, "Appa"), optResult: "", sdp: sdp)}",
  );
  print(
    "Apparent Latitude          : ${mf.dddms(mb.moonGeocentricLatitude(jdVal, deltaT), optResult: "", sdp: 0)}",
  );
  print(
    "Apparent Right Ascension   : ${mf.dddms(mo.moonGeocentricRightAscension(jdVal, deltaT), optResult: "", sdp: sdp)}",
  );
  print(
    "Apparent Declination       : ${mf.dddms(mo.moonGeocentricDeclination(jdVal, deltaT), optResult: "", sdp: sdp)}",
  );
  print(
    "Horizontal Parallax        : ${mf.dddms(mo.moonEquatorialHorizontalParallax(jdVal, deltaT), optResult: "", sdp: 0)}",
  );
  print(
    "Semidiameter               : ${mf.dddms(mo.moonGeocentricSemidiameter(jdVal, deltaT), optResult: "MMSS", sdp: 2)}",
  );
  print(
    "Angle Bright Limb          : ${mf.dddms(mo.moonGeocentricBrightLimbAngle(jdVal, deltaT), optResult: "", sdp: sdp)}",
  );
  print(
    "Fraction Illumination      : ${mf.roundTo(mo.moonGeocentricDiskIlluminatedFraction(jdVal, deltaT) / 100.0, place: 10)}",
  );
  print(
    "GHA                        : ${mf.dddms(mo.moonGeocentricGreenwichHourAngle(jdVal, deltaT), optResult: "", sdp: sdp)}",
  );

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
  final blnH = 11;
  final thnH = 1439;

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

  final tglM = 18;
  final blnM = 2;
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
  final blnH4 = 6;
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
    print("Kontak P1 : ${se.formatKontakGerhana(resSEG["P1"])}");
    print("Kontak P2 : ${se.formatKontakGerhana(resSEG["P2"])}");
    print("Kontak U1 : ${se.formatKontakGerhana(resSEG["U1"])}");
    print("Kontak U2 : ${se.formatKontakGerhana(resSEG["U2"])}");
    print("Kontak C1 : ${se.formatKontakGerhana(resSEG["C1"])}");
    print("Puncak MX : ${se.formatKontakGerhana(resSEG["MX"])}");
    print("Kontak C2 : ${se.formatKontakGerhana(resSEG["C2"])}");
    print("Kontak U3 : ${se.formatKontakGerhana(resSEG["U3"])}");
    print("Kontak U4 : ${se.formatKontakGerhana(resSEG["U4"])}");
    print("Kontak P3 : ${se.formatKontakGerhana(resSEG["P3"])}");
    print("Kontak P4 : ${se.formatKontakGerhana(resSEG["P4"])}");
  }
}
