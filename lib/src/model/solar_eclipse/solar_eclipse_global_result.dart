import '../../model/solar_eclipse/solar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseGlobalResult {
  final bool ada;
  final String? keterangan;

  // === BESSELIAN ELEMENTS ===
  final SolarBesselianResult? besselian;

  // === KONTAK WAKTU (JD TD) ===
  final double? p1;
  final double? u1;
  final double? c1;
  final double? u2;
  final double? p2;
  final double? mx;
  final double? p3;
  final double? u3;
  final double? c2;
  final double? u4;
  final double? p4;

  // === KONTAK WAKTU (JD UT) ===
  final double? p1UT;
  final double? u1UT;
  final double? c1UT;
  final double? u2UT;
  final double? p2UT;
  final double? mxUT;
  final double? p3UT;
  final double? u3UT;
  final double? c2UT;
  final double? u4UT;
  final double? p4UT;

  // === LONGITUDE TIAP KONTAK ===
  final double? lonP1;
  final double? lonU1;
  final double? lonC1;
  final double? lonU2;
  final double? lonP2;
  final double? lonMx;
  final double? lonP3;
  final double? lonU3;
  final double? lonC2;
  final double? lonU4;
  final double? lonP4;

  // === LATITUDE TIAP KONTAK ===
  final double? latP1;
  final double? latU1;
  final double? latC1;
  final double? latU2;
  final double? latP2;
  final double? latMx;
  final double? latP3;
  final double? latU3;
  final double? latC2;
  final double? latU4;
  final double? latP4;

  // === AZIMUTH TIAP KONTAK ===
  final double? azmP1;
  final double? azmU1;
  final double? azmC1;
  final double? azmU2;
  final double? azmP2;
  final double? azmMx;
  final double? azmP3;
  final double? azmU3;
  final double? azmC2;
  final double? azmU4;
  final double? azmP4;

  // === ALTITUDE TIAP KONTAK ===
  final double? altP1;
  final double? altU1;
  final double? altC1;
  final double? altU2;
  final double? altP2;
  final double? altMx;
  final double? altP3;
  final double? altU3;
  final double? altC2;
  final double? altU4;
  final double? altP4;

  // === PARAMETER GERHANA ===
  final double? magnitude;
  final String? jenis;
  final double? durasiTotalitas;
  final double? lebar;

  // === EPHEMERIS PUNCAK (TERPISAH) ===
  final EclipseEphemerisBodyGlobal? sunEphemeris;
  final EclipseEphemerisBodyGlobal? moonEphemeris;

  const SolarEclipseGlobalResult({
    required this.ada,
    this.keterangan,
    this.besselian,

    // Waktu TD
    this.p1,
    this.u1,
    this.c1,
    this.u2,
    this.p2,
    this.mx,
    this.p3,
    this.u3,
    this.c2,
    this.u4,
    this.p4,

    // Waktu UT
    this.p1UT,
    this.u1UT,
    this.c1UT,
    this.u2UT,
    this.p2UT,
    this.mxUT,
    this.p3UT,
    this.u3UT,
    this.c2UT,
    this.u4UT,
    this.p4UT,

    // Longitude
    this.lonP1,
    this.lonU1,
    this.lonC1,
    this.lonU2,
    this.lonP2,
    this.lonMx,
    this.lonP3,
    this.lonU3,
    this.lonC2,
    this.lonU4,
    this.lonP4,

    // Latitude
    this.latP1,
    this.latU1,
    this.latC1,
    this.latU2,
    this.latP2,
    this.latMx,
    this.latP3,
    this.latU3,
    this.latC2,
    this.latU4,
    this.latP4,

    // Azimuth
    this.azmP1,
    this.azmU1,
    this.azmC1,
    this.azmU2,
    this.azmP2,
    this.azmMx,
    this.azmP3,
    this.azmU3,
    this.azmC2,
    this.azmU4,
    this.azmP4,

    // Altitude
    this.altP1,
    this.altU1,
    this.altC1,
    this.altU2,
    this.altP2,
    this.altMx,
    this.altP3,
    this.altU3,
    this.altC2,
    this.altU4,
    this.altP4,

    // Parameter
    this.magnitude,
    this.jenis,
    this.durasiTotalitas,
    this.lebar,

    // Ephemeris
    this.sunEphemeris,
    this.moonEphemeris,
  });
}
