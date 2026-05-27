//import '../../model/lunar_eclipse/lunar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class LunarEclipseLocalSummary {
  final int tahunHijri;
  final int bulanHijri;

  // Kontak Gerhana (JD)
  final double? p1;
  final double? u1;
  final double? u2;
  final double? mx;
  final double? u3;
  final double? u4;
  final double? p4;

  // Altitude
  final double? altP1;
  final double? altU1;
  final double? altU2;
  final double? altMx;
  final double? altU3;
  final double? altU4;
  final double? altP4;

  // Azimuth
  final double? azmP1;
  final double? azmU1;
  final double? azmU2;
  final double? azmMx;
  final double? azmU3;
  final double? azmU4;
  final double? azmP4;

  // Durasi
  final double? durasiPenumbral;
  final double? durasiUmbral;
  final double? durasiTotal; // ✅ TAMBAHKAN INI

  // Magnitude
  final double? magnitudePenumbral; // ✅ TAMBAHKAN INI
  final double? magnitudeUmbral; // ✅ TAMBAHKAN INI

  // Radius
  final double? radiusPenumbral;
  final double? radiusUmbral;

  // Delta T
  final double? deltaT; // ✅ TAMBAHKAN INI

  // Ephemeris Data Saat Puncak
  final EclipseEphemerisBody? sunData;
  final EclipseEphemerisBody? moonData;

  // Jenis Gerhana
  final String jenis;

  LunarEclipseLocalSummary({
    required this.tahunHijri,
    required this.bulanHijri,

    // ✅ UBAH: Semua properti nullable jadi optional (pakai 'this.prop')
    this.p1,
    this.u1,
    this.u2,
    this.mx,
    this.u3,
    this.u4,
    this.p4,
    this.altP1,
    this.altU1,
    this.altU2,
    this.altMx,
    this.altU3,
    this.altU4,
    this.altP4,
    this.azmP1,
    this.azmU1,
    this.azmU2,
    this.azmMx,
    this.azmU3,
    this.azmU4,
    this.azmP4,
    this.durasiPenumbral,
    this.durasiUmbral,
    this.durasiTotal,
    this.magnitudePenumbral,
    this.magnitudeUmbral,
    this.radiusPenumbral,
    this.radiusUmbral,
    this.deltaT,
    this.sunData,
    this.moonData,

    // ✅ Jenis selalu ada, tetap required
    required this.jenis,
  });
}
