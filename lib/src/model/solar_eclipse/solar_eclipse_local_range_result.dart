class SolarEclipseLocalSummary {
  final int tahunHijri;
  final int bulanHijri;

  final double? u1;
  final double? u2;
  final double? max;
  final double? u3;
  final double? u4;

  final double? altU1;
  final double? altU2;
  final double? altMax;
  final double? altU3;
  final double? altU4;

  final double? durasi;
  final String jenis;

  SolarEclipseLocalSummary({
    required this.tahunHijri,
    required this.bulanHijri,
    required this.u1,
    required this.u2,
    required this.max,
    required this.u3,
    required this.u4,
    required this.altU1,
    required this.altU2,
    required this.altMax,
    required this.altU3,
    required this.altU4,
    required this.durasi,
    required this.jenis,
  });
}
