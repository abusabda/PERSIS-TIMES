class LunarEclipseLocalSummary {
  final int tahunHijri;
  final int bulanHijri;

  final double? p1;
  final double? u1;
  final double? u2;
  final double? mx;
  final double? u3;
  final double? u4;
  final double? p4;

  final double? altP1;
  final double? altU1;
  final double? altU2;
  final double? altMx;
  final double? altU3;
  final double? altU4;
  final double? altP4;

  final double? durasiUmbral;
  final double? durasiPenumbral;
  final String jenis;

  LunarEclipseLocalSummary({
    required this.tahunHijri,
    required this.bulanHijri,
    required this.p1,
    required this.u1,
    required this.u2,
    required this.mx,
    required this.u3,
    required this.u4,
    required this.p4,
    required this.altP1,
    required this.altU1,
    required this.altU2,
    required this.altMx,
    required this.altU3,
    required this.altU4,
    required this.altP4,
    required this.durasiUmbral,
    required this.durasiPenumbral,
    required this.jenis,
  });
}
