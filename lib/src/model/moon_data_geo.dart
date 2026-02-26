class MoonDataGeo {
  final double longitudeTrue;
  final double longitudeApparent;
  final double latitudeTrue;
  final double latitudeApparent;

  final double rightAscension;
  final double declination;

  final double distanceAU;
  final double distanceKm;
  final double distanceER;

  final double greenwichHourAngle;
  final double localHourAngle;
  final double horizontalParallax;
  final double semidiameter;

  final double azimuth;
  final double altitude;

  final double phaseAngle;
  final double diskIlluminationFraction;
  final double brightLimbAngle;

  MoonDataGeo({
    required this.longitudeTrue,
    required this.longitudeApparent,
    required this.latitudeTrue,
    required this.latitudeApparent,

    required this.rightAscension,
    required this.declination,

    required this.distanceAU,
    required this.distanceKm,
    required this.distanceER,

    required this.greenwichHourAngle,
    required this.localHourAngle,
    required this.horizontalParallax,
    required this.semidiameter,

    required this.azimuth,
    required this.altitude,

    required this.phaseAngle,
    required this.diskIlluminationFraction,
    required this.brightLimbAngle,
  });
}
