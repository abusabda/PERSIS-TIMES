import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/qibla/arah_kiblat.dart';
import 'package:myhisab/src/model/qibla_result.dart';
import 'package:myhisab/src/model/qibla_daily_result.dart';
import 'package:myhisab/src/model/qibla_yearly_result.dart';

class QiblaService {
  final ArahKiblat _aq = ArahKiblat();
  final JulianDay _jd = JulianDay();

  // =========================================================
  // MAIN QIBLA
  // =========================================================

  QiblaResult getQibla({
    required int tglM,
    required int blnM,
    required int thnM,
    required double gLon,
    required double gLat,
    required double tmZn,
  }) {
    return QiblaResult(
      arahSpherical: _aq.arahQiblatSpherical(gLon, gLat),
      arahEllipsoid: _aq.arahQiblaWithEllipsoidCorrection(gLon, gLat),
      arahVincenty: _aq.arahQiblaVincenty(gLon, gLat, 'PtoQ'),
      jarakSphericalKm: _aq.jarakQiblatSpherical(gLon, gLat),
      jarakEllipsoidKm: _aq.jarakQiblatEllipsoid(gLon, gLat),
      jarakVincentyKm: _aq.arahQiblaVincenty(gLon, gLat, 'Dist') / 1000.0,

      bayangan1: _aq.bayanganQiblatHarian(
        gLon,
        gLat,
        tglM,
        blnM,
        thnM,
        tmZn,
        "spherical",
        1,
      ),
      bayangan2: _aq.bayanganQiblatHarian(
        gLon,
        gLat,
        tglM,
        blnM,
        thnM,
        tmZn,
        "spherical",
        2,
      ),
      rashdul1: _aq.rashdulQiblat(thnM, tmZn, 1),
      rashdul2: _aq.rashdulQiblat(thnM, tmZn, 2),
      antipoda1: _aq.antipodaKabah(thnM, tmZn, 1),
      antipoda2: _aq.antipodaKabah(thnM, tmZn, 2),
    );
  }

  // =========================================================
  // DAILY SHADOW
  // =========================================================

  QiblaDailyResult getDailyShadow({
    required int tglM1,
    required int blnM1,
    required int thnM1,
    required int tglM2,
    required int blnM2,
    required int thnM2,
    required double gLon,
    required double gLat,
    required double tmZn,
  }) {
    final jd1 = _jd.kmjd(tglM1, blnM1, thnM1, 0, 0);
    final jd2 = _jd.kmjd(tglM2, blnM2, thnM2, 0, 0);

    final diff = (jd2 - jd1) + 1;
    var jdh = jd1 - 1;

    final List<QiblaDailyShadow> result = [];

    for (int i = 1; i <= diff.toInt(); i++) {
      jdh += 1;

      final tglM = int.parse(_jd.jdkm(jdh, tmZn, "TglM").toString());
      final blnM = int.parse(_jd.jdkm(jdh, tmZn, "BlnM").toString());
      final thnM = int.parse(_jd.jdkm(jdh, tmZn, "ThnM").toString());
      final tglFull = _jd.jdkm(jdh, tmZn);

      result.add(
        QiblaDailyShadow(
          tanggal: tglFull,
          bayangan1: _aq.bayanganQiblatHarian(
            gLon,
            gLat,
            tglM,
            blnM,
            thnM,
            tmZn,
            "spherical",
            1,
          ),
          bayangan2: _aq.bayanganQiblatHarian(
            gLon,
            gLat,
            tglM,
            blnM,
            thnM,
            tmZn,
            "spherical",
            2,
          ),
        ),
      );
    }

    return QiblaDailyResult(data: result);
  }

  // =========================================================
  // RASHDUL QIBLAT TAHUNAN
  // =========================================================

  QiblaYearlyResult getRashdulTahunan({
    required int thnM1,
    required int thnM2,
    required double tmZn,
  }) {
    final List<QiblaYearlyEvent> result = [];

    for (int thn = thnM1; thn <= thnM2; thn++) {
      result.add(
        QiblaYearlyEvent(
          tahun: thn,
          event1: _aq.rashdulQiblat(thn, tmZn, 1),
          event2: _aq.rashdulQiblat(thn, tmZn, 2),
        ),
      );
    }

    return QiblaYearlyResult(data: result);
  }

  // =========================================================
  // ANTIPODA TAHUNAN
  // =========================================================

  QiblaYearlyResult getAntipodaTahunan({
    required int thnM1,
    required int thnM2,
    required double tmZn,
  }) {
    final List<QiblaYearlyEvent> result = [];

    for (int thn = thnM1; thn <= thnM2; thn++) {
      result.add(
        QiblaYearlyEvent(
          tahun: thn,
          event1: _aq.antipodaKabah(thn, tmZn, 1),
          event2: _aq.antipodaKabah(thn, tmZn, 2),
        ),
      );
    }

    return QiblaYearlyResult(data: result);
  }
}
