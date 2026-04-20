import 'dart:math' as math;
import '../core/math/math_utils.dart';
import '../core/astronomy/dynamical_time.dart';
import '../core/astronomy/julian_day.dart';
import '../core/astronomy/moon_distance.dart';
import '../core/astronomy/moon_function.dart';
import '../core/astronomy/moon_latitude.dart';
import '../core/astronomy/moon_longitude.dart';
import '../core/astronomy/sun_function.dart';
//import 'package:myhisab/service/moon_service.dart';

//final mf = MathFunction();

class Lokasi {
  final double gLat;
  final double gLon;
  final double tmZn;

  Lokasi(this.gLat, this.gLon, this.tmZn);
}

class Lokasi2 {
  final double gLat;
  final double gLon;
  final double tmZn;

  Lokasi2(this.gLat, this.gLon, this.tmZn);
}

final ab = CalendarService();

class CalendarService {
  final julDay = JulianDay();
  final dyTme = DynamicalTime();
  final sn = SunFunction();
  final mf = MathFunction();
  final ml = MoonLongitude();
  final mb = MoonLatitude();
  final md = MoonDistance();
  final mo = MoonFunction();

  // Fungsi Hisab Awal Bulan Hijriah Menurut MABIMS

  double abqMabims(int blnH, int thnH) {
    final lokasi = [
      //A. Empat Titik Paling Barat (Utara-Selatan)
      Lokasi(
        5 + 54 / 60 + 26.32 / 3600,
        95 + 13 / 60 + 1.01 / 3600,
        7,
      ), // 1. Sabang, Banda Aceh

      Lokasi(
        -(5 + 22 / 60 + 28.80 / 3600),
        102 + 13 / 60 + 54.86 / 3600,
        7,
      ), // 2. Enggano, Bengkulu Utara

      Lokasi(
        4 + 47 / 60 + 45.14 / 3600,
        108 + 1 / 60 + 16.46 / 3600,
        7,
      ), // 3. Natuna, Kepulauan Riau

      Lokasi(
        -(7 + 4 / 60 + 26.1 / 3600),
        106 + 31 / 60 + 53.71 / 3600,
        7,
      ), // 4. Cibeas, Jawa Barat
      //B. Poros Tengah (Selatan-Utara)
      Lokasi(
        -(8 + 50 / 60 + 59.7 / 3600),
        115 + 9 / 60 + 41.73 / 3600,
        8,
      ), // 5. Pecatu, Bali

      Lokasi(
        4 + 9 / 60 + 9.62 / 3600,
        117 + 42 / 60 + 3.47 / 3600,
        8,
      ), // 6. Sebatik, Kalimantan Utara
    ];

    final sn = SunFunction();
    final mo = MoonFunction();

    final jdNM = mo.geocentricConjunction(blnH, thnH, 0.0, "Ijtimak");
    final delT = dyTme.deltaT(jdNM);
    final jdNM2 = mo.geocentricConjunction(blnH, thnH, delT, "Ijtimak");

    int irMabims = 2; // Default, akan diganti jika syarat terpenuhi

    for (final loc in lokasi) {
      final jdGS = sn.jdGhurubSyams(jdNM, loc.gLat, loc.gLon, 10.0, loc.tmZn);
      final tHlal00 = mo.moonTopocentricAltitude(
        jdGS,
        delT,
        loc.gLon,
        loc.gLat,
        10.0,
        1010.0,
        10.0,
        "htoc",
      );
      final elong00 = mo.moonSunGeocentricElongation(jdGS, delT);

      if (elong00 >= 6.4 && tHlal00 >= 3) {
        irMabims = 1;
        break;
      }
    }

    final jdAbqMabims =
        ((mf.floor(jdNM2 + 0.5 + 0.0 / 24.0)) - 0.0 / 24.0) + irMabims;

    return jdAbqMabims.ceilToDouble();
  }

  // Fungsi Hisab Awal Bulan Hijriah Menurut Wujudul Hilal
  double abqWujudulHilal(int blnH, int thnH) {
    double gLon = 110 + 21 / 60;
    double gLat = -(7 + 48 / 60);
    double tmZn = 7;
    double elev = 30;

    final jdNM = mo.geocentricConjunction(blnH, thnH, 0.0, "Ijtimak");
    final delT = dyTme.deltaT(jdNM);
    final jdNM2 = mo.geocentricConjunction(blnH, thnH, delT, "Ijtimak");

    final jdGS = sn.jdGhurubSyams(jdNM2, gLat, gLon, elev, tmZn);
    final tHlal00 = mo.moonTopocentricAltitude(
      jdGS,
      delT,
      gLon,
      gLat,
      10.0,
      1010.0,
      10.0,
      "htou",
    );

    int wh = 2;

    if (tHlal00 > 0 && jdNM2 < jdGS) {
      wh = 1;
    }

    final jdAbqWH = ((mf.floor(jdNM2 + 0.5 + 0.0 / 24.0)) - 0.0 / 24.0) + wh;

    return jdAbqWH.ceilToDouble();
  }

  // Fungsi Hisab Awal Bulan Hijriah Menurut IR TURKI/KHGT

  double abqTurki(int blnH, int thnH) {
    final lokasi = [
      Lokasi2(65, -166.7, -9),
      Lokasi2(54.47, -164.91, -9),
      Lokasi2(60, -139.6304, -9),
      Lokasi2(55.9182, -133.8442, -8),
      Lokasi2(50, -127.45, -8),
      Lokasi2(47, -124.21, -8),
      Lokasi2(34, -118.92, -8),
      Lokasi2(33, -117.33, -8),
      Lokasi2(20, -105.5555, -6),
      Lokasi2(14, -91.557, -6),
      Lokasi2(13, -87.62, -6),
      Lokasi2(9, -83.65, -6),
      Lokasi2(7.25, -80.9333, -5),
      Lokasi2(7, -77.692, -5),
      Lokasi2(3, -77.674, -5),
      Lokasi2(0, -80.1, -5),
      Lokasi2(-3, -79.83, -5),
      Lokasi2(-8, -79.235, -5),
      Lokasi2(-16, -74.0254, -4),
      Lokasi2(-24, -70.5235, -4),
      Lokasi2(-32, -71.5397, -4),
      Lokasi2(-40, -73.726, -4),
      Lokasi2(-44, -73.2683, -3),
      Lokasi2(-49, -75.6755, -3),
      Lokasi2(-55.9385, -67.2877, -3),
    ];

    // ── 1. Ijtimak ──────────────────────────────────────────────────────────
    final jdNM = mo.geocentricConjunction(blnH, thnH, 0.0, "Ijtimak"); // UT
    final dT = dyTme.deltaT(jdNM);
    final jdNM2 = mo.geocentricConjunction(
      blnH,
      thnH,
      dT,
      "Ijtimak",
    ); // UT + ΔT

    // ── 2. Batas 00 UT (dihitung dari jdNM2, sesuai VB) ─────────────────────
    // VB: jd0UT        = Math.Floor(jdNM2 + 0.5) - 0.5
    //     jd0UTNextDay = jd0UT + 1
    final jd0UTNextDay = (jdNM2 + 0.5).floorToDouble() - 0.5 + 1.0;

    // ── 3. Loop lokasi ───────────────────────────────────────────────────────
    int irTurki = 2;
    bool isBefore00UT = false;
    bool isAfter00UT = false;

    for (final loc in lokasi) {
      // VB: JDGhurubSyams3 → parameter ke-4 = 0 (mdl), ke-5 = TmZn
      final jdGS = sn.jdGhurubSyams(jdNM, loc.gLat, loc.gLon, 0, loc.tmZn);
      final tHlal = mo.moonGeocentricAltitude(jdGS, dT, loc.gLon, loc.gLat);
      final elong = mo.moonSunGeocentricElongation(jdGS, dT);

      if (elong >= 8 && tHlal >= 5) {
        if (jdGS < jd0UTNextDay) {
          // ✅ Kondisi terpenuhi sebelum 00 UT → langsung keluar
          isBefore00UT = true;
          irTurki = 1;
          break;
        } else {
          // Kondisi terpenuhi setelah 00 UT → catat, lanjut loop
          isAfter00UT = true;
        }
      }
    }

    // ── 4. Fallback: cek fajar New Zealand ──────────────────────────────────
    // Hanya dijalankan jika tidak ada lokasi yang memenuhi sebelum 00 UT
    // tetapi ada yang memenuhi setelah 00 UT  (sesuai VB)
    if (!isBefore00UT && isAfter00UT) {
      // Perkiraan fajar di New Zealand
      // VB: JDFP = Math.Floor(jdNM2 + 0.5) - 0.5 + 17/24
      final jdFP = (jdNM2 + 0.5).floorToDouble() - 0.5 + 17.0 / 24.0;

      const lonNZ = 174 + 48 / 60.0; //  174.8°
      const latNZ = -(41 + 19 / 60.0); // -41.317°
      const tzNZ = 12.0;

      final kwd = (lonNZ - (tzNZ * 15)) / 15.0;

      final dek = sn.sunGeocentricDeclination(jdFP, 0);
      final eqt = sn.equationOfTime(jdFP, 0);

      // Ambil nilai hmF dari settings (VB: My.Settings.tbTgSubhVal, default -18)
      const hmF = -18.0;

      final hAm = mf.deg(
        math.acos(
          (math.sin(mf.rad(hmF)) -
                  math.sin(mf.rad(latNZ)) * math.sin(mf.rad(dek))) /
              (math.cos(mf.rad(latNZ)) * math.cos(mf.rad(dek))),
        ),
      );

      final awf = 12.0 - eqt - hAm / 15.0 - kwd;

      // VB: AWFUTC = ModFDiv((AWF - 12), 24)  →  Dart: mod(awf - 12, 24)
      final awfUTC = mf.mod(awf - 12.0, 24.0);

      // VB: JDFUTC = Math.Floor(jdNM2 + 0.5) - 0.5 + AWFUTC / 24
      final jdFUTC = (jdNM2 + 0.5).floorToDouble() - 0.5 + awfUTC / 24.0;

      // VB: If jdNM2 < JDFUTC → IRTurki = 1, Else → IRTurki = 2
      irTurki = (jdNM2 < jdFUTC) ? 1 : 2;
    }

    // ── 5. ABQ final ─────────────────────────────────────────────────────────
    // VB: abq = (Math.Floor(jdNM2 + 0.5 + 0.0/24.0) - 0.0/24.0) + IRTurki
    //         = Math.Floor(jdNM2 + 0.5) + IRTurki
    final abq = (jdNM2 + 0.5).floorToDouble() + irTurki.toDouble();

    return abq;
  }

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

  String serviceKalenderHijriahMABIMS(int tglM, int blnM, int thnM) {
    final jd = julDay.kmjd(tglM, blnM, thnM);
    final cjdnM = (jd + 0.5).floorToDouble();
    final jd2 = jd.ceilToDouble();

    final thnH = int.parse(
      julDay
          .cjdnKH(cjdnM.toInt(), hCalE: 2, hCalL: 2, optResult: "THNH")
          .toString(),
    );

    // Kumpulkan semua ABQ
    final abqList = <double>[];
    abqList.add(ab.abqMabims(12, thnH - 1)); // Zulhijjah tahun sebelumnya
    for (var blnH = 1; blnH <= 12; blnH++) {
      abqList.add(ab.abqMabims(blnH, thnH));
    }
    abqList.add(ab.abqMabims(1, thnH + 1)); // Muharram tahun berikutnya

    // Loop hari dari tiap ABQ ke ABQ berikutnya
    for (var i = 0; i < abqList.length - 1; i++) {
      final jdStart = abqList[i].toInt();
      final jdEnd = abqList[i + 1].toInt();

      final blnH = (i == 0)
          ? 12
          : (i == 13)
          ? 12
          : i;
      final thnHij = (i == 0)
          ? thnH - 1
          : (i >= 1 && i <= 12)
          ? thnH
          : thnH + 1;

      final namaBlnH = namaBulanHijriah[blnH - 1];

      var nomorUrut = 1;
      for (var jdHari = jdStart; jdHari < jdEnd; jdHari++) {
        if (jdHari == jd2.toInt()) {
          return "${julDay.jdkm(jdHari.toDouble())} M | $nomorUrut $namaBlnH $thnHij H";
        }
        nomorUrut++;
      }
    }

    return "Tidak ditemukan";
  }

  String serviceKalenderHijriahWH(int tglM, int blnM, int thnM) {
    final jd = julDay.kmjd(tglM, blnM, thnM);
    final cjdnM = (jd + 0.5).floorToDouble();
    final jd2 = jd.ceilToDouble();

    final thnH = int.parse(
      julDay
          .cjdnKH(cjdnM.toInt(), hCalE: 2, hCalL: 2, optResult: "THNH")
          .toString(),
    );

    // Kumpulkan semua ABQ
    final abqList = <double>[];
    abqList.add(ab.abqWujudulHilal(12, thnH - 1)); // Zulhijjah tahun sebelumnya
    for (var blnH = 1; blnH <= 12; blnH++) {
      abqList.add(ab.abqWujudulHilal(blnH, thnH));
    }
    abqList.add(ab.abqWujudulHilal(1, thnH + 1)); // Muharram tahun berikutnya

    // Loop hari dari tiap ABQ ke ABQ berikutnya
    for (var i = 0; i < abqList.length - 1; i++) {
      final jdStart = abqList[i].toInt();
      final jdEnd = abqList[i + 1].toInt();

      final blnH = (i == 0)
          ? 12
          : (i == 13)
          ? 12
          : i;
      final thnHij = (i == 0)
          ? thnH - 1
          : (i >= 1 && i <= 12)
          ? thnH
          : thnH + 1;

      final namaBlnH = namaBulanHijriah[blnH - 1];

      var nomorUrut = 1;
      for (var jdHari = jdStart; jdHari < jdEnd; jdHari++) {
        if (jdHari == jd2.toInt()) {
          return "${julDay.jdkm(jdHari.toDouble())} M | $nomorUrut $namaBlnH $thnHij H";
        }
        nomorUrut++;
      }
    }

    return "Tidak ditemukan";
  }

  String serviceKalenderHijriahTURKI(int tglM, int blnM, int thnM) {
    final jd = julDay.kmjd(tglM, blnM, thnM);
    final cjdnM = (jd + 0.5).floorToDouble();
    final jd2 = jd.ceilToDouble();

    final thnH = int.parse(
      julDay
          .cjdnKH(cjdnM.toInt(), hCalE: 2, hCalL: 2, optResult: "THNH")
          .toString(),
    );

    // Kumpulkan semua ABQ
    final abqList = <double>[];
    abqList.add(ab.abqTurki(12, thnH - 1)); // Zulhijjah tahun sebelumnya
    for (var blnH = 1; blnH <= 12; blnH++) {
      abqList.add(ab.abqTurki(blnH, thnH));
    }
    abqList.add(ab.abqTurki(1, thnH + 1)); // Muharram tahun berikutnya

    // Loop hari dari tiap ABQ ke ABQ berikutnya
    for (var i = 0; i < abqList.length - 1; i++) {
      final jdStart = abqList[i].toInt();
      final jdEnd = abqList[i + 1].toInt();

      final blnH = (i == 0)
          ? 12
          : (i == 13)
          ? 12
          : i;
      final thnHij = (i == 0)
          ? thnH - 1
          : (i >= 1 && i <= 12)
          ? thnH
          : thnH + 1;

      final namaBlnH = namaBulanHijriah[blnH - 1];

      var nomorUrut = 1;
      for (var jdHari = jdStart; jdHari < jdEnd; jdHari++) {
        if (jdHari == jd2.toInt()) {
          return "${julDay.jdkm(jdHari.toDouble())} M | $nomorUrut $namaBlnH $thnHij H";
        }
        nomorUrut++;
      }
    }

    return "Tidak ditemukan";
  }
}
