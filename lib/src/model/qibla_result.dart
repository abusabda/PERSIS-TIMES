class QiblaResult {
  final double arahSpherical;
  final double arahEllipsoid;
  final double arahVincenty;

  final double jarakSphericalKm;
  final double jarakEllipsoidKm;
  final double jarakVincentyKm;

  final double bayangan1;
  final double bayangan2;

  final String rashdul1;
  final String rashdul2;

  final String antipoda1;
  final String antipoda2;

  QiblaResult({
    required this.arahSpherical,
    required this.arahEllipsoid,
    required this.arahVincenty,
    required this.jarakSphericalKm,
    required this.jarakEllipsoidKm,
    required this.jarakVincentyKm,
    required this.bayangan1,
    required this.bayangan2,
    required this.rashdul1,
    required this.rashdul2,
    required this.antipoda1,
    required this.antipoda2,
  });
}
