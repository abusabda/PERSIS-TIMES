class SunDataGeo {
  final double longitudeTrue;
  final double longitudeApparent;
  final double latitudeTrue;
  final double latitudeApparent;

  final double rightAscension;
  final double declination;

  final double greenwichHourAngle;
  final double localHourAngle;

  final double azimuth;
  final double altitude;

  final double distanceAU;
  final double distanceKm;
  final double distanceER;

  final double semidiameter;
  final double horizontalParallax;

  SunDataGeo({
    required this.longitudeTrue,
    required this.longitudeApparent,
    required this.latitudeTrue,
    required this.latitudeApparent,

    required this.rightAscension,
    required this.declination,

    required this.greenwichHourAngle,
    required this.localHourAngle,

    required this.distanceAU,
    required this.distanceKm,
    required this.distanceER,

    required this.semidiameter,
    required this.horizontalParallax,

    required this.azimuth,
    required this.altitude,
  });
}
