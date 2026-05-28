import '../../model/solar_eclipse/solar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class SolarEclipseGlobalSummary {
  final int tahunHijri;
  final int bulanHijri;
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
  final double? magnitude;
  final double? durasiGerhana;
  final double? durasiTotalitas;
  final double? lebar;
  final double? durasi;
  final String jenis;

  //Besselian element
  final SolarBesselianResult? besselian;

  final EclipseEphemerisBodyGlobal? sunEphemeris; // ⬅️ WAJIB nullable
  final EclipseEphemerisBodyGlobal? moonEphemeris; // ⬅️ WAJIB nullable

  SolarEclipseGlobalSummary({
    required this.tahunHijri,
    required this.bulanHijri,
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
    this.magnitude,
    this.durasiGerhana,
    this.durasiTotalitas,
    this.lebar,
    this.durasi,
    this.besselian,
    this.sunEphemeris,
    this.moonEphemeris,
    required this.jenis,
  });
}
