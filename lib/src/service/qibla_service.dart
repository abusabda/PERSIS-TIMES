import 'package:myhisab/src/core/qibla/arah_kiblat.dart';
import 'package:myhisab/src/model/qibla_result.dart';
import 'package:myhisab/src/core/astronomy/julian_day.dart';

class QiblaService {
  final ArahKiblat _aq = ArahKiblat();
  final JulianDay _jd = JulianDay();

  QiblaResult getQibla({
    required int tglM,
    required int blnM,
    required int thnM,
    required double gLon,
    required double gLat,
    required double tmZn,
    String azQiblat = "spherical",
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
        azQiblat,
        1,
      ),

      bayangan2: _aq.bayanganQiblatHarian(
        gLon,
        gLat,
        tglM,
        blnM,
        thnM,
        tmZn,
        azQiblat,
        2,
      ),

      rashdul1: _aq.rashdulQiblat(thnM, tmZn, 1),
      rashdul2: _aq.rashdulQiblat(thnM, tmZn, 2),
      antipoda1: _aq.antipodaKabah(thnM, tmZn, 1),
      antipoda2: _aq.antipodaKabah(thnM, tmZn, 2),
    );
  }

  List<Map<String, dynamic>> getQiblaRange({
    required int tglAwal,
    required int blnAwal,
    required int thnAwal,
    required int tglAkhir,
    required int blnAkhir,
    required int thnAkhir,
    required double gLon,
    required double gLat,
    required double tmZn,
    String azQiblat = "spherical",
  }) {
    final List<Map<String, dynamic>> results = [];

    final jdStart = _jd.kmjd(tglAwal, blnAwal, thnAwal, 12.0, tmZn);
    final jdEnd = _jd.kmjd(tglAkhir, blnAkhir, thnAkhir, 12.0, tmZn);

    for (double jd = jdStart; jd <= jdEnd; jd += 1.0) {
      final int tgl = int.parse(_jd.jdkm(jd, tmZn, "TGL"));
      final int bln = int.parse(_jd.jdkm(jd, tmZn, "BLN"));
      final int thn = int.parse(_jd.jdkm(jd, tmZn, "THN"));

      // final String hari = _jd.jdkm(jd, tmZn, "HARI");
      // final String bulanNama = _jd.jdkm(jd, tmZn, "BULAN");

      final bayangan1 = _aq.bayanganQiblatHarian(
        gLon,
        gLat,
        tgl,
        bln,
        thn,
        tmZn,
        azQiblat,
        1,
      );

      final bayangan2 = _aq.bayanganQiblatHarian(
        gLon,
        gLat,
        tgl,
        bln,
        thn,
        tmZn,
        azQiblat,
        2,
      );

      results.add({
        "jd": jd,
        // "hari": hari,
        // "tanggal": tgl,
        // "bulan": bln,
        // "bulanNama": bulanNama,
        // "tahun": thn,
        "bayangan1": bayangan1,
        "bayangan2": bayangan2,
      });
    }

    return results;
  }

  List<Map<String, dynamic>> getRashdulRange({
    required int tahunAwal,
    required int tahunAkhir,
    required double tmZn,
  }) {
    final List<Map<String, dynamic>> results = [];

    for (int tahun = tahunAwal; tahun <= tahunAkhir; tahun++) {
      final rashdul1 = _aq.rashdulQiblat(tahun, tmZn, 1);
      final rashdul2 = _aq.rashdulQiblat(tahun, tmZn, 2);

      results.add({"tahun": tahun, "rashdul1": rashdul1, "rashdul2": rashdul2});
    }

    return results;
  }

  List<Map<String, dynamic>> getAntipodaRange({
    required int tahunAwal,
    required int tahunAkhir,
    required double tmZn,
  }) {
    final List<Map<String, dynamic>> results = [];

    for (int tahun = tahunAwal; tahun <= tahunAkhir; tahun++) {
      final antipoda1 = _aq.antipodaKabah(tahun, tmZn, 1);
      final antipoda2 = _aq.antipodaKabah(tahun, tmZn, 2);

      results.add({
        "tahun": tahun,
        "antipoda1": antipoda1,
        "antipoda2": antipoda2,
      });
    }

    return results;
  }
}
