import '../../model/solar_eclipse/solar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseLocalSummary {
  final int tahunHijri;
  final int bulanHijri;

  // === WAKTU DALAM TD (Terrestrial Dynamical Time) ===
  final double? u1TD;
  final double? u2TD;
  final double? mxTD;
  final double? u3TD;
  final double? u4TD;

  // === WAKTU DALAM UT (Universal Time) ===
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

  // === PARAMETER GERHANA ===
  final double? magnitude;
  final double? obscuration;
  final double? durasiTotal;
  final double? durasiGerhana;

  // === EPHEMERIS SAAT PUNCAK ===
  final EclipseEphemerisBody? sunEphemeris;
  final EclipseEphemerisBody? moonEphemeris;

  // === BESSELIAN ELEMENTS ===
  final SolarBesselianResult? besselian;

  final String jenis;

  SolarEclipseLocalSummary({
    required this.tahunHijri,
    required this.bulanHijri,

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

    // Parameter
    this.magnitude,
    this.obscuration,
    this.durasiTotal,
    this.durasiGerhana,

    // Ephemeris
    this.sunEphemeris,
    this.moonEphemeris,

    // Besselian
    this.besselian,

    required this.jenis,
  });
}
