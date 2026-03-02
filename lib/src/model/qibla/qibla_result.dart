import 'qibla_event_result.dart';

class QiblaResult {
  final double arahSpherical;
  final double arahEllipsoid;
  final double arahVincenty;

  final double jarakSphericalKm;
  final double jarakEllipsoidKm;
  final double jarakVincentyKm;

  final double bayangan1;
  final double bayangan2;

  final QiblaEventResult rashdul1;
  final QiblaEventResult rashdul2;

  final QiblaEventResult antipoda1;
  final QiblaEventResult antipoda2;

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
