class SolarBesselianResult {
  final double? jde;
  final double? deltaT;
  final double? t0;

  final List<double>? x;
  final List<double>? y;
  final List<double>? d;
  final List<double>? mu;
  final List<double>? l1;
  final List<double>? l2;

  final double? tanf1;
  final double? tanf2;

  const SolarBesselianResult({
    this.jde,
    this.deltaT,
    this.t0,
    this.x,
    this.y,
    this.d,
    this.mu,
    this.l1,
    this.l2,
    this.tanf1,
    this.tanf2,
  });

  bool get isValid =>
      jde != null &&
      x != null &&
      y != null &&
      d != null &&
      mu != null &&
      l1 != null &&
      l2 != null;
}
