import '../../model/lunar_eclipse/lunar_besselian_result.dart';
import '../../model/helper_eclipse/helper_eclipse.dart';

class LunarEclipseGlobalSummary {
  final int tahunHijri;
  final int bulanHijri;
  final double? p1;
  final double? u1;
  final double? u2;
  final double? mx;
  final double? u3;
  final double? u4;
  final double? p4;
  final double? durasiPenumbral;
  final double? durasiUmbral;
  final double? durasiTotal;

  final LunarBesselianResult? besselian;

  final EclipseEphemerisBody? sun; // ⬅️ WAJIB nullable
  final EclipseEphemerisBody? moon; // ⬅️ WAJIB nullable

  final String jenis;

  LunarEclipseGlobalSummary({
    required this.tahunHijri,
    required this.bulanHijri,
    this.p1,
    this.u1,
    this.u2,
    this.mx,
    this.u3,
    this.u4,
    this.p4,
    this.durasiPenumbral,
    this.durasiUmbral,
    this.durasiTotal,
    this.besselian,
    this.sun,
    this.moon,
    required this.jenis,
  });
}
