import 'package:test/test.dart';

import 'package:myhisab/src/core/astronomy/julian_day.dart';
import 'package:myhisab/src/core/prayer/waktu_salat.dart';
import 'package:myhisab/src/core/qibla/arah_kiblat.dart';

void main() {
  group('Astronomy Test', () {
    test('Julian Day 1 Jan 2000', () {
      final jd = JulianDay();
      final result = jd.kmjd(1, 1, 2000, 12, 0);

      expect(result, closeTo(2451545.0, 0.1));
    });
  });

  group('Prayer Time Test', () {
    test('Zuhur Jakarta', () {
      final ws = WaktuSalat();

      final result = ws.zuhur(1, 1, 2025, 106.8, 7);

      expect(result.time, isNotNull);
      expect(result.time!, greaterThan(11));
      expect(result.time!, lessThan(13));
    });
  });

  group('Qibla Direction Test', () {
    test('Arah kiblat Jakarta', () {
      final qibla = ArahKiblat();

      final arah = qibla.arahQiblatSpherical(106.8, -6.2);

      expect(arah, closeTo(295, 5));
    });
  });
}
