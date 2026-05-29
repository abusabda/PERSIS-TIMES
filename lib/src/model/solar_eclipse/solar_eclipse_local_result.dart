import '../../model/solar_eclipse/solar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseLocalResult {
  final bool ada;
  final String? keterangan;

  // === BESSELIAN ===
  final SolarBesselianResult? besselian;

  // === WAKTU KONTAK (TD) ===
  final double? u1TD;
  final double? u2TD;
  final double? mxTD;
  final double? u3TD;
  final double? u4TD;

  // === WAKTU KONTAK (UT) ===
  final double? u1UT;
  final double? u2UT;
  final double? mxUT;
  final double? u3UT;
  final double? u4UT;

  // === ALTITUDE & AZIMUTH ===
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

  // === EPHEMERIS PUNCAK (DIPISAH) ===
  final EclipseEphemerisBody? sunEphemeris;
  final EclipseEphemerisBody? moonEphemeris;

  // === PARAMETER GERHANA ===
  final double? magnitude;
  final double? obscuration;
  final String jenis;
  final double? durasiGerhana;
  final double? durasiTotalitas;

  const SolarEclipseLocalResult({
    required this.ada,
    this.keterangan,
    this.besselian,

    // Waktu TD
    this.u1TD,
    this.u2TD,
    this.mxTD,
    this.u3TD,
    this.u4TD,

    // Waktu UT
    this.u1UT,
    this.u2UT,
    this.mxUT,
    this.u3UT,
    this.u4UT,

    // Altitude & Azimuth
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

    // Ephemeris (dipisah)
    this.sunEphemeris,
    this.moonEphemeris,

    // Parameter
    this.magnitude,
    this.obscuration,
    required this.jenis,
    this.durasiGerhana,
    this.durasiTotalitas,
  });
}
