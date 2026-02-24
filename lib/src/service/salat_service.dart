import 'package:myhisab/src/model/salat_daily_result.dart';
import 'package:myhisab/src/core/prayer/waktu_salat.dart';
import 'package:myhisab/src/model/salat_status.dart';
import 'package:myhisab/src/model/salat_value.dart';
import 'package:myhisab/src/core/astronomy/julian_day.dart';

class SalatService {
  final JulianDay _jd = JulianDay();
  SalatDailyResult waktuSalatHarian({
    required int tglM,
    required int blnM,
    required int thnM,
    required double gLon,
    required double gLat,
    required double elev,
    required double tmZn,
    required int ihty,
  }) {
    final ws = WaktuSalat();

    SalatValue applyIhtiyath(SalatValue value, int iht) {
      if (value.status != SalatStatus.normal) {
        return value; // kalau up/down/bright/dark → jangan diubah
      }

      final newTime = ws.ihtiyathShalat(value.time!, iht);

      return SalatValue(time: newTime, status: SalatStatus.normal);
    }

    final subuh = applyIhtiyath(
      ws.subuh(tglM, blnM, thnM, gLon, gLat, tmZn),
      ihty,
    );

    final syuruk = applyIhtiyath(
      ws.syuruk(tglM, blnM, thnM, gLon, gLat, elev, tmZn),
      -2,
    );

    final duha = applyIhtiyath(
      ws.duha(tglM, blnM, thnM, gLon, gLat, elev, tmZn),
      -ihty,
    );

    final zuhur = applyIhtiyath(ws.zuhur(tglM, blnM, thnM, gLon, tmZn), ihty);

    final asar = applyIhtiyath(
      ws.asar(tglM, blnM, thnM, gLon, gLat, tmZn),
      ihty,
    );

    final magrib = applyIhtiyath(
      ws.magrib(tglM, blnM, thnM, gLon, gLat, elev, tmZn),
      ihty,
    );

    final isya = applyIhtiyath(
      ws.isya(tglM, blnM, thnM, gLon, gLat, tmZn),
      ihty,
    );

    final nisfu = applyIhtiyath(
      ws.nisfuLail(tglM, blnM, thnM, gLon, gLat, elev, tmZn),
      ihty,
    );

    return SalatDailyResult(
      subuh: subuh,
      syuruk: syuruk,
      duha: duha,
      zuhur: zuhur,
      asar: asar,
      magrib: magrib,
      isya: isya,
      nisfuLail: nisfu,
    );
  }

  List<Map<String, dynamic>> getSalatRange({
    required int tglAwal,
    required int blnAwal,
    required int thnAwal,
    required int tglAkhir,
    required int blnAkhir,
    required int thnAkhir,
    required double gLon,
    required double gLat,
    required double elev,
    required double tmZn,
    required int ihty,
  }) {
    final List<Map<String, dynamic>> results = [];

    final jdStart = _jd.kmjd(tglAwal, blnAwal, thnAwal, 12.0, tmZn);
    final jdEnd = _jd.kmjd(tglAkhir, blnAkhir, thnAkhir, 12.0, tmZn);

    for (double jd = jdStart; jd <= jdEnd; jd += 1.0) {
      final int tgl = int.parse(_jd.jdkm(jd, tmZn, "TGL"));
      final int bln = int.parse(_jd.jdkm(jd, tmZn, "BLN"));
      final int thn = int.parse(_jd.jdkm(jd, tmZn, "THN"));

      final daily = waktuSalatHarian(
        tglM: tgl,
        blnM: bln,
        thnM: thn,
        gLon: gLon,
        gLat: gLat,
        elev: elev,
        tmZn: tmZn,
        ihty: ihty,
      );

      results.add({
        "jd": jd,
        "subuh": daily.subuh.isNormal
            ? daily.subuh.time
            : daily.subuh.status.name,
        "syuruk": daily.syuruk.isNormal
            ? daily.syuruk.time
            : daily.syuruk.status.name,
        "duha": daily.duha.isNormal ? daily.duha.time : daily.duha.status.name,
        "zuhur": daily.zuhur.isNormal
            ? daily.zuhur.time
            : daily.zuhur.status.name,
        "asar": daily.asar.isNormal ? daily.asar.time : daily.asar.status.name,
        "magrib": daily.magrib.isNormal
            ? daily.magrib.time
            : daily.magrib.status.name,
        "isya": daily.isya.isNormal ? daily.isya.time : daily.isya.status.name,
        "nisfuLail": daily.nisfuLail.isNormal
            ? daily.nisfuLail.time
            : daily.nisfuLail.status.name,
      });
    }

    return results;
  }
}
