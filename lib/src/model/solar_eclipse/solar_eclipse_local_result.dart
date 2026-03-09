import '../../model/solar_eclipse/solar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseLocalResult {
  final bool ada;
  final String? keterangan;

  final SolarBesselianResult besselian;

  final EclipseContact? u1;
  final EclipseContact? u2;
  final EclipseContact? mx;
  final EclipseContact? u3;
  final EclipseContact? u4;

  final EclipseEphemeris? ephemerisMaximum;

  final double? magnitude;
  final double? obscuration;
  final String? jenis;

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
    this.ephemerisMaximum,
    this.magnitude,
    this.obscuration,
    this.jenis,
    this.durasiGerhana,
    this.durasiTotalitas,
    this.deltaT,
  });
}
