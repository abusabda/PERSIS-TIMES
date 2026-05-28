import '../../model/solar_eclipse/solar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseLocalResult {
  final bool ada;
  final String? keterangan;

  final SolarBesselianResult besselian;

  final double? u1;
  final double? u2;
  final double? mx;
  final double? u3;
  final double? u4;

  final double? altU1;
  final double? altU2;
  final double? altMx;
  final double? altU3;
  final double? altU4;

  final double? azmU1;
  final double? azmU2;
  final double? azmMx;
  final double? azmU3;
  final double? azmU4;

  final EclipseEphemeris? ephemerisMaximum;

  final double? magnitude;
  final double? obscuration;
  final String jenis;

  final double? deltaT; // ← TAMBAHKAN INI

  final double? durasiGerhana;
  final double? durasiTotalitas;

  const SolarEclipseLocalResult({
    required this.ada,
    required this.besselian,
    this.keterangan,
    this.u1,
    this.u2,
    this.mx,
    this.u3,
    this.u4,
    this.altU1,
    this.altU2,
    this.altMx,
    this.altU3,
    this.altU4,
    this.azmU1,
    this.azmU2,
    this.azmMx,
    this.azmU3,
    this.azmU4,
    this.ephemerisMaximum,
    this.magnitude,
    this.obscuration,
    this.durasiGerhana,
    this.durasiTotalitas,
    this.deltaT,
    required this.jenis,
  });
}
