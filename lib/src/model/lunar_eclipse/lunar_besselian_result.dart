class LunarBesselianResult {
  final double jde;
  final double deltaT;
  final double t0;

  final List<double> x;
  final List<double> y;
  final List<double> d;

  final List<double> f1;
  final List<double> f2;
  final List<double> sm;

  final List<double> mu;

  final List<double> hp;
  final List<double> dm;

  LunarBesselianResult({
    required this.jde,
    required this.deltaT,
    required this.t0,
    required this.x,
    required this.y,
    required this.d,
    required this.f1,
    required this.f2,
    required this.hp,
    required this.dm,
    required this.sm,
    required this.mu,
  });

  // 🔥 TAMBAHKAN INI
  bool get isValid {
    return x.length == 5 &&
        y.length == 5 &&
        f1.length == 5 &&
        f2.length == 5 &&
        sm.length == 5 &&
        !jde.isNaN &&
        !deltaT.isNaN &&
        !t0.isNaN;
  }
}
